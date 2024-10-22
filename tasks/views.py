from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth import logout, authenticate, login
from django.contrib.auth.models import User
from django.http import HttpResponse, HttpResponseForbidden
from django.db.models import Count
from django.db import IntegrityError
from django.utils.dateparse import parse_date
from django.core.exceptions import ValidationError

from .models import Task, TaskAttachment, UserProfile
from .forms import TaskForm, TaskAttachmentForm, UserProfileForm, EditUserProfileForm
from management.models import Source, SupportCategory, Incident
from management.forms import SourceForm, SupportCategoryForm, IncidentForm
from django.urls import reverse
from datetime import date
import csv
from django.utils.timezone import localtime, now
from .models import Attendance
from datetime import time





# Helper function to check if the user is admin
def is_admin(user):
    return user.is_staff

@login_required
def task_list(request):
    user_profile = request.user.userprofile
    view_own_tasks = request.GET.get('view_own_tasks', 'false') == 'true'  # Check if viewing own tasks

    # Determine which tasks the user can see
    if request.user.is_staff or user_profile.user_type == 'team_coordinator':
        if view_own_tasks:
            # View only their own tasks if the button is clicked
            tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')
        else:
            # Admins and Team Coordinators can see all tasks by default
            tasks = Task.objects.all().order_by('-created_at')
    else:
        # General Users can only see their own tasks
        tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')

    # Fetch choices from the management_db
    source_choices = Source.objects.using('management_db').all()
    incident_choices = Incident.objects.using('management_db').all()
    support_category_choices = SupportCategory.objects.using('management_db').all()

    # Get filter values from the GET request
    source_filter = request.GET.get('source_filter', 'All')
    incident_filter = request.GET.get('incident_filter', 'All')
    support_category_filter = request.GET.get('support_category_filter', 'All')
    search_query = request.GET.get('search', '')

    # Date filter values
    start_date = request.GET.get('start_date', '')
    end_date = request.GET.get('end_date', '')

    # Apply filters if they are not set to 'All'
    if source_filter != 'All':
        tasks = tasks.filter(source_id=source_filter)

    if incident_filter != 'All':
        tasks = tasks.filter(incident_id=incident_filter)

    if support_category_filter != 'All':
        tasks = tasks.filter(support_category_id=support_category_filter)

    # Apply date range filter
    if start_date:
        tasks = tasks.filter(task_date__gte=parse_date(start_date))
    if end_date:
        tasks = tasks.filter(task_date__lte=parse_date(end_date))

    # Apply search filter for username (for Admins and Team Coordinators)
    if (request.user.is_staff or user_profile.user_type == 'team_coordinator') and search_query:
        tasks = tasks.filter(created_by__username__icontains=search_query)

    # Render the task_list template with the appropriate context
    return render(request, 'task_list.html', {
        'tasks': tasks,
        'source_choices': source_choices,
        'incident_choices': incident_choices,
        'support_category_choices': support_category_choices,
        'search_query': search_query,
        'start_date': start_date,
        'end_date': end_date,
        'view_own_tasks': view_own_tasks  # Pass this to the template
    })

@login_required
def add_task(request):
    # Set the default task date to today's date
    today_date = date.today()

    if request.method == 'POST':
        form = TaskForm(request.POST)
        attachment_form = TaskAttachmentForm(request.POST, request.FILES)
        if form.is_valid():
            task = form.save(commit=False)
            task.created_by = request.user
            
            # Check if the user provided a task_date, otherwise use today's date
            if not form.cleaned_data.get('task_date'):
                task.task_date = today_date  # Default to today's date if not provided
            task.save()

            if attachment_form.is_valid() and 'attachment' in request.FILES:
                attachment = attachment_form.save(commit=False)
                attachment.task = task
                attachment.attachment = request.FILES['attachment']
                attachment.save()
            
            return redirect('task_list')
    else:
        form = TaskForm(initial={'task_date': today_date})
        attachment_form = TaskAttachmentForm()

    # Fetch tasks created today by the user
    today_tasks = Task.objects.filter(created_by=request.user, task_date=today_date)

    # Fetch choices from the management_db for form fields
    source_choices = Source.objects.using('management_db').all()
    incident_choices = Incident.objects.using('management_db').all()
    support_category_choices = SupportCategory.objects.using('management_db').all()

    return render(request, 'add_task.html', {
        'form': form,
        'attachment_form': attachment_form,
        'source_choices': source_choices,
        'incident_choices': incident_choices,
        'support_category_choices': support_category_choices,
        'today_date': today_date,  # Pass today's date to the template
        'today_tasks': today_tasks,  # Pass the tasks created today
    })


@login_required
def home_redirect(request):
    # Check if the user is admin or general user and redirect accordingly
    if request.user.is_staff:  # If the user is an admin
        return redirect('admin_dashboard')  # Admin dashboard
    else:  # General user
        return redirect('task_list')  # User task list

@login_required
def edit_task(request, task_id):
    # Get the task based on the task_id
    task = get_object_or_404(Task, id=task_id)

    # Only allow admin or the user who created the task to edit
    if not request.user.is_staff and request.user != task.created_by:
        return HttpResponseForbidden("You don't have permission to edit this task.")
    
    if request.method == 'POST':
        # If the request is POST, handle the form submission
        form = TaskForm(request.POST, instance=task)
        
        if form.is_valid():
            # Manually preserve the task_date if the user leaves it blank
            if not form.cleaned_data.get('task_date'):
                form.instance.task_date = task.task_date  # Preserve the previous task date
            form.save()  # Save the changes to the task
            return redirect('task_list')  # Redirect back to the task list
    else:
        # If it's a GET request, pre-fill the form with the existing task
        form = TaskForm(instance=task)

    return render(request, 'edit_task.html', {
        'form': form,
        'task': task,  # Pass task object to use task.id in the template
    })

@login_required
def delete_task(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    task.delete()
    return redirect('task_list')

# Admin dashboard view
@login_required
def admin_dashboard(request):
    user_profile = request.user.userprofile
    view_own_tasks = request.GET.get('view_own_tasks', 'false') == 'true'  # Check if viewing own tasks

    # Fetch choices from the management_db
    source_choices = Source.objects.using('management_db').all()
    incident_choices = Incident.objects.using('management_db').all()
    support_category_choices = SupportCategory.objects.using('management_db').all()

    # Initialize total task counters
    total_source_tasks = 0
    total_incident_tasks = 0
    total_support_category_tasks = 0

    # Admins and team coordinators can see all tasks by default unless they are filtering their own
    if request.user.is_staff or user_profile.user_type == 'team_coordinator':
        if view_own_tasks:
            tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')
        else:
            tasks = Task.objects.all().order_by('-created_at')
    else:
        # General users can only see their own tasks
        tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')

    # Count total tasks by source
    source_data = []
    source_labels = []
    source_counts = []
    for source in source_choices:
        task_count = tasks.filter(source=source).count()
        total_source_tasks += task_count
        source_data.append({'name': source.name, 'total_tasks': task_count})
        if task_count > 0:  # Only add sources with non-zero task count
            source_labels.append(source.name)
            source_counts.append(task_count)
    
    # Include tasks with no source (unassigned)
    unassigned_source_count = tasks.filter(source__isnull=True).count()
    if unassigned_source_count > 0:
        total_source_tasks += unassigned_source_count
        source_data.append({'name': 'Unassigned', 'total_tasks': unassigned_source_count})
        source_labels.append('Unassigned')
        source_counts.append(unassigned_source_count)

    # Count total tasks by incident
    incident_data = []
    incident_labels = []
    incident_counts = []
    for incident in incident_choices:
        task_count = tasks.filter(incident=incident).count()
        total_incident_tasks += task_count
        incident_data.append({'name': incident.name, 'total_tasks': task_count})
        if task_count > 0:  # Only add incidents with non-zero task count
            incident_labels.append(incident.name)
            incident_counts.append(task_count)
    
    # Include tasks with no incident (unassigned)
    unassigned_incident_count = tasks.filter(incident__isnull=True).count()
    if unassigned_incident_count > 0:
        total_incident_tasks += unassigned_incident_count
        incident_data.append({'name': 'Unassigned', 'total_tasks': unassigned_incident_count})
        incident_labels.append('Unassigned')
        incident_counts.append(unassigned_incident_count)

    # Count total tasks by support category
    support_category_data = []
    support_category_labels = []
    support_category_counts = []
    for support in support_category_choices:
        task_count = tasks.filter(support_category=support).count()
        total_support_category_tasks += task_count
        support_category_data.append({'name': support.name, 'total_tasks': task_count})
        if task_count > 0:  # Only add support categories with non-zero task count
            support_category_labels.append(support.name)
            support_category_counts.append(task_count)

    # Include tasks with no support category (unassigned)
    unassigned_support_category_count = tasks.filter(support_category__isnull=True).count()
    if unassigned_support_category_count > 0:
        total_support_category_tasks += unassigned_support_category_count
        support_category_data.append({'name': 'Unassigned', 'total_tasks': unassigned_support_category_count})
        support_category_labels.append('Unassigned')
        support_category_counts.append(unassigned_support_category_count)

    # Pass the data and the totals to the template
    return render(request, 'admin_dashboard.html', {
        'source_data': source_data,
        'incident_data': incident_data,
        'support_category_data': support_category_data,
        'total_source_tasks': total_source_tasks,
        'total_incident_tasks': total_incident_tasks,
        'total_support_category_tasks': total_support_category_tasks,
        'view_own_tasks': view_own_tasks,  # Pass this to template to toggle the "View My Tasks" button
        'source_labels': source_labels,  # Pass labels for pie chart
        'source_counts': source_counts,  # Pass counts for pie chart
        'incident_labels': incident_labels,  # Incident labels for pie chart
        'incident_counts': incident_counts,  # Incident counts for pie chart
        'support_category_labels': support_category_labels,  # Support category labels for pie chart
        'support_category_counts': support_category_counts,  # Support category counts for pie chart
    })

# User Management Views
@login_required
@user_passes_test(is_admin)
def create_user(request):
    if request.method == 'POST':
        form = UserProfileForm(request.POST)
        if form.is_valid():
            try:
                user_profile = form.save(commit=False)
                password = request.POST.get('password')
                
                if password:
                    user_profile.user.set_password(password)
                else:
                    form.add_error('password', 'Password is required')
                    return render(request, 'create_user.html', {'form': form})
                
                try:
                    user_profile.user.save()
                    user_profile.save()
                    return redirect('admin_user_management')
                except IntegrityError as e:
                    if '1062' in str(e):
                        form.add_error('username', 'This username is already taken.')
                    return render(request, 'create_user.html', {'form': form})
            
            except ValidationError as e:
                form.add_error(None, str(e))
        else:
            return render(request, 'create_user.html', {'form': form})
    
    else:
        form = UserProfileForm()

    return render(request, 'create_user.html', {'form': form})

@login_required
def view_user_profile(request, user_id):
    if not request.user.is_staff:
        return redirect('task_list')  # Redirect non-admin users

    profile = get_object_or_404(UserProfile, user_id=user_id)
    return render(request, 'view_user.html', {'profile': profile})

@login_required
def edit_profile(request):
    profile = get_object_or_404(UserProfile, user=request.user)
    if request.method == 'POST':
        form = EditUserProfileForm(request.POST, instance=profile, user=request.user)
        if form.is_valid():
            form.save()
            # Redirect based on user type
            if request.user.is_staff:
                return redirect('admin_dashboard')
            else:
                return redirect('task_list')
    else:
        form = EditUserProfileForm(instance=profile, user=request.user)
    return render(request, 'edit_profile.html', {'form': form})

@login_required
@user_passes_test(is_admin)
def admin_user_management(request):
    users = User.objects.all()
    return render(request, 'admin_user_management.html', {'users': users})

@login_required
def edit_user_profile(request, user_id):
    if not request.user.is_staff:
        return redirect('task_list')  # Only admins can edit other users

    # Get the user's profile based on the user_id
    profile = get_object_or_404(UserProfile, user_id=user_id)
    user = profile.user  # Get the related user instance

    if request.method == 'POST':
        form = EditUserProfileForm(request.POST, instance=profile, user=user)

        # Check if the form is valid
        if form.is_valid():
            form.save()  # This will save both the user and the profile
            return redirect('admin_user_management')  # Redirect after a successful update
        else:
            print("Form Errors:", form.errors)  # Print form errors to console for debugging
    else:
        form = EditUserProfileForm(instance=profile, user=user)  # Pre-fill form with user data

    # Render the edit user template and include form errors
    return render(request, 'edit_user.html', {
        'form': form,
        'profile': profile
    })

@login_required
@user_passes_test(is_admin)
def delete_user(request, user_id):
    profile = get_object_or_404(UserProfile, user_id=user_id)
    profile.user.delete()
    return redirect('admin_user_management')

@login_required
def success_page(request):
    return render(request, 'success.html')

# Authentication Views
def login_view(request):
    if request.method == 'POST':
        email = request.POST['email']
        password = request.POST['password']
        try:
            user = User.objects.get(email=email)  # Check if the user exists by email
            user = authenticate(request, username=user.username, password=password)  # Authenticate the user
            if user is not None:
                login(request, user)
                # Redirect based on user type
                if user.is_staff:  # Admins
                    return redirect(reverse('admin_dashboard'))  # Admin dashboard
                else:
                    user_profile = user.userprofile
                    if user_profile.user_type == 'team_coordinator' or user_profile.user_type == 'general':
                        return redirect(reverse('task_list'))  # General users and team coordinators go to their task list
            else:
                return render(request, 'login.html', {'error': 'Invalid email or password'})
        except User.DoesNotExist:
            return render(request, 'login.html', {'error': 'Invalid email or password'})
    return render(request, 'login.html')

@login_required
def logout_view(request):
    logout(request)
    return redirect('login')

@login_required
def general_user_dashboard(request):
    if request.user.is_staff:
        return redirect('admin_dashboard')
    tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')
    return render(request, 'user_dashboard.html', {'tasks': tasks})

@login_required
def user_list(request):
    if not request.user.is_staff:
        return redirect('task_list')  # General users should not access this view

    users = UserProfile.objects.all()  # Fetch all user profiles
    return render(request, 'user_list.html', {'users': users})

@login_required
def download_task(request, task_id):
    task = get_object_or_404(Task, id=task_id)
    
    # Create the HttpResponse object with CSV header.
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="task_{task.id}.csv"'

    writer = csv.writer(response)
    # Write headers
    writer.writerow(['ID', 'Description', 'Source', 'Incident', 'Support Category', 'Office Name', 'Task Date', 'Created By'])

    # Write task data
    writer.writerow([
        task.id,
        task.description,
        task.source.name if task.source else 'Unassigned',
        task.incident.name if task.incident else 'Unassigned',
        task.support_category.name if task.support_category else 'Unassigned',
        task.office_name,
        task.task_date,
        task.created_by.username
    ])

    return response

@login_required
def download_all_tasks(request):
    # Get all tasks based on user role
    if request.user.is_staff or request.user.userprofile.user_type == 'team_coordinator':
        tasks = Task.objects.all().order_by('-created_at')
    else:
        tasks = Task.objects.filter(created_by=request.user).order_by('-created_at')

    # Create the HttpResponse object with CSV header.
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="all_tasks.csv"'

    writer = csv.writer(response)
    # Write headers
    writer.writerow(['ID', 'Description', 'Source', 'Incident', 'Support Category', 'Office Name', 'Task Date', 'Created By'])

    # Write task data
    for task in tasks:
        writer.writerow([
            task.id,
            task.description,
            task.source.name if task.source else 'Unassigned',
            task.incident.name if task.incident else 'Unassigned',
            task.support_category.name if task.support_category else 'Unassigned',
            task.office_name,
            task.task_date,
            task.created_by.username
        ])

    return response

@login_required
@user_passes_test(is_admin)
def download_user_tasks(request, user_id):
    # Get the user based on user_id
    user = get_object_or_404(User, id=user_id)

    # Fetch all tasks created by this user
    tasks = Task.objects.filter(created_by=user).order_by('-created_at')

    # Create the HttpResponse object with CSV header.
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = f'attachment; filename="{user.username}_tasks.csv"'

    writer = csv.writer(response)
    # Write headers
    writer.writerow(['ID', 'Description', 'Source', 'Incident', 'Support Category', 'Office Name', 'Task Date', 'Created By'])

    # Write task data
    for task in tasks:
        writer.writerow([
            task.id,
            task.description,
            task.source.name if task.source else 'Unassigned',
            task.incident.name if task.incident else 'Unassigned',
            task.support_category.name if task.support_category else 'Unassigned',
            task.office_name,
            task.task_date,
            task.created_by.username
        ])

    return response


# Attendance function for general users
@login_required
def give_attendance(request):
    current_time = localtime().time()  # Exact current time when attendance is pressed
    current_date = localtime().date()  # Exact current date

    if time(8, 0) <= current_time <= time(17, 0):  # Between 9 AM to 5 PM
        attendance, created = Attendance.objects.get_or_create(user=request.user, date=current_date)
        if not attendance.is_present:  # If attendance not already given
            attendance.time_in = current_time  # Record the time attendance was given
            attendance.is_present = True
            attendance.save()
            return render(request, 'attendance_success.html')  # Success page
        else:
            return render(request, 'attendance_already_given.html')  # If already given
    else:
        return render(request, 'attendance_time_error.html')  # Error for time limit


# Function to check if the user is an admin
def is_admin(user):
    return user.is_superuser


# Attendance list for users/admins to view
@login_required
def attendance_list(request):
    attendance_date = request.GET.get('attendance_date', localtime().date())
    all_users = User.objects.all()
    
    attendance_records = Attendance.objects.filter(date=attendance_date)
    attendance_dict = {record.user.id: record for record in attendance_records}

    attendance_data = []
    for user in all_users:
        record = attendance_dict.get(user.id)
        attendance_data.append({
            'user': user,
            'date': attendance_date,
            'is_present': record.is_present if record else False,
            'time_in': record.time_in if record else None,
        })

    return render(request, 'attendance_list.html', {
        'attendance_list': attendance_data,
        'attendance_date': attendance_date,
    })


# Attendance dashboard for admin
@login_required
@user_passes_test(is_admin)
def attendance_dashboard(request):
    attendance_date = request.GET.get('attendance_date', localtime().date())
    all_users = User.objects.all()
    
    # Fetch attendance records for the selected date
    attendance_records = Attendance.objects.filter(date=attendance_date)
    attendance_dict = {record.user.id: record for record in attendance_records}
    
    attendance_data = []
    for user in all_users:
        record = attendance_dict.get(user.id)
        attendance_data.append({
            'user': user,
            'date': attendance_date,
            'is_present': record.is_present if record else False,
            'time_in': record.time_in if record else None,
        })

    # Process admin actions to add/remove attendance
    if request.method == 'POST':
        user_id = request.POST.get('user_id')
        action = request.POST.get('action')
        user = User.objects.get(id=user_id)
        
        attendance, created = Attendance.objects.get_or_create(user=user, date=attendance_date)
        if action == 'add':
            attendance.time_in = localtime().time()
            attendance.is_present = True
        elif action == 'remove':
            attendance.is_present = False
            attendance.time_in = None
        attendance.save()
        
        return redirect('attendance_dashboard')  # Refresh the page after update

    return render(request, 'admin_attendance_dashboard.html', {
        'attendance_list': attendance_data,
        'attendance_date': attendance_date,
    })