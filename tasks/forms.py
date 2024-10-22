from django import forms
from django.contrib.auth.models import User
from .models import UserProfile, Task, TaskAttachment, Source, Incident, SupportCategory, BLOOD_GROUP_CHOICES, USER_TYPE_CHOICES


# User profile form for creating a user
class UserProfileForm(forms.ModelForm):
    username = forms.CharField(max_length=150, required=True)  # Username field
    email = forms.EmailField(max_length=150, required=True)  # Email field
    password = forms.CharField(widget=forms.PasswordInput, required=True)  # Password field

    def __init__(self, *args, **kwargs):
        super(UserProfileForm, self).__init__(*args, **kwargs)
        self.fields['username'].initial = ''  # Ensure username is blank for new user
        self.fields['email'].initial = ''     # Ensure email is blank for new user
        self.fields['password'].initial = ''  # Ensure password is blank for new user

    class Meta:
        model = UserProfile
        fields = ['full_name', 'nid', 'phone_no', 'blood_group', 'date_of_birth', 'user_type']  # Ensure 'nid' is included
        widgets = {
            'full_name': forms.TextInput(attrs={'class': 'form-control'}),
            'nid': forms.TextInput(attrs={'class': 'form-control'}),  # Ensure nid is a text input
            'phone_no': forms.TextInput(attrs={'class': 'form-control'}),
            'blood_group': forms.Select(choices=BLOOD_GROUP_CHOICES, attrs={'class': 'form-control'}),  # Dropdown for blood group
            'date_of_birth': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'user_type': forms.Select(choices=USER_TYPE_CHOICES, attrs={'class': 'form-control'}),  # Dropdown for user type
        }

    def clean_email(self):
        email = self.cleaned_data['email']
        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("A user with that email already exists.")
        return email

    def save(self, commit=True):
        # Create the user object
        user = User.objects.create_user(
            username=self.cleaned_data['username'],
            email=self.cleaned_data['email'],
            password=self.cleaned_data['password']
        )
        # If user type is admin, mark them as staff
        if self.cleaned_data['user_type'] == 'admin':
            user.is_staff = True
        user.save()

        # Create the user profile
        profile = super().save(commit=False)
        profile.user = user
        if commit:
            profile.save()
        return profile


# Profile form for editing (with username, email, and password)
class EditUserProfileForm(forms.ModelForm):
    username = forms.CharField(max_length=150, required=True)  # Username field
    email = forms.EmailField(max_length=150, required=True)  # Email field
    password = forms.CharField(widget=forms.PasswordInput, required=False)  # Password field (optional for editing)

    def __init__(self, *args, **kwargs):
        user = kwargs.pop('user', None)  # Get the logged-in user
        super(EditUserProfileForm, self).__init__(*args, **kwargs)

        if user:
            self.fields['username'].initial = user.username
            self.fields['email'].initial = user.email

        # Always show the user_type field regardless of the role
        self.fields['user_type'] = forms.ChoiceField(
            choices=USER_TYPE_CHOICES,  # Ensure the choices are set here
            widget=forms.Select(attrs={'class': 'form-control'})
        )

    class Meta:
        model = UserProfile
        fields = ['full_name', 'nid', 'phone_no', 'blood_group', 'date_of_birth', 'user_type']
        widgets = {
            'full_name': forms.TextInput(attrs={'class': 'form-control'}),
            'nid': forms.TextInput(attrs={'class': 'form-control'}),
            'phone_no': forms.TextInput(attrs={'class': 'form-control'}),
            'blood_group': forms.Select(choices=BLOOD_GROUP_CHOICES, attrs={'class': 'form-control'}),
            'date_of_birth': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'user_type': forms.Select(choices=USER_TYPE_CHOICES, attrs={'class': 'form-control'}),
        }


    def save(self, commit=True):
        # Update the user model (username, email, and password)
        user = self.instance.user
        user.username = self.cleaned_data['username']
        user.email = self.cleaned_data['email']

        # If the user provided a new password, update it
        if self.cleaned_data['password']:
            user.set_password(self.cleaned_data['password'])
        user.save()

        # Save the UserProfile fields
        profile = super().save(commit=False)
        if commit:
            profile.save()
        return profile


# Task form
class TaskForm(forms.ModelForm):
    source = forms.ModelChoiceField(queryset=Source.objects.using('management_db').all(), empty_label="Select Source")
    incident = forms.ModelChoiceField(queryset=Incident.objects.using('management_db').all(), empty_label="Select Incident")
    support_category = forms.ModelChoiceField(queryset=SupportCategory.objects.using('management_db').all(), empty_label="Select Support Category")

    class Meta:
        model = Task
        fields = ['description', 'status', 'source', 'incident', 'support_category', 'office_name', 'task_date']
        widgets = {
            'description': forms.Textarea(attrs={'class': 'form-control'}),
            'status': forms.Select(attrs={'class': 'form-control'}),
            'office_name': forms.TextInput(attrs={'class': 'form-control'}),
            'task_date': forms.DateInput(attrs={'type': 'date'}),
        }


# Task attachment form
class TaskAttachmentForm(forms.ModelForm):
    class Meta:
        model = TaskAttachment
        fields = ['attachment']
        widgets = {
            'attachment': forms.FileInput(attrs={'class': 'form-control'}),
        }


# Form for creating a new Source
class SourceForm(forms.ModelForm):
    class Meta:
        model = Source
        fields = ['name']


# Form for creating a new SupportCategory
class SupportCategoryForm(forms.ModelForm):
    class Meta:
        model = SupportCategory
        fields = ['name']


# Form for creating a new Incident
class IncidentForm(forms.ModelForm):
    class Meta:
        model = Incident
        fields = ['name']
