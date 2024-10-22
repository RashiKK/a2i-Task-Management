from django.shortcuts import render, get_object_or_404, redirect
from .models import Source, SupportCategory, Incident
from .forms import SourceForm, SupportCategoryForm, IncidentForm
from tasks.models import Task

# Source Views
def source_list(request):
    sources = Source.objects.all()
    form = SourceForm()
    if request.method == 'POST':
        form = SourceForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('source_list')
    return render(request, 'source_list.html', {'sources': sources, 'form': form})


def edit_source(request, source_id):
    source = get_object_or_404(Source, id=source_id)
    if request.method == 'POST':
        form = SourceForm(request.POST, instance=source)
        if form.is_valid():
            form.save()
            return redirect('source_list')
    else:
        form = SourceForm(instance=source)
    return render(request, 'edit_source.html', {'form': form})


def delete_source(request, source_id):
    source = get_object_or_404(Source, id=source_id)

    # Set all tasks that have this source to null in the correct database
    Task.objects.using('default').filter(source=source).update(source=None)

    if request.method == 'POST':
        source.delete()  # Now you can delete the source
        return redirect('source_list')

    return render(request, 'delete_source.html', {'source': source})


# Support Category Views
def support_category_list(request):
    categories = SupportCategory.objects.all()
    form = SupportCategoryForm()

    if request.method == 'POST':
        form = SupportCategoryForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('support_category_list')

    return render(request, 'support_category_list.html', {'support_categories': categories, 'form': form})


def edit_support_category(request, category_id):
    category = get_object_or_404(SupportCategory, id=category_id)
    if request.method == 'POST':
        form = SupportCategoryForm(request.POST, instance=category)
        if form.is_valid():
            form.save()
            return redirect('support_category_list')
    else:
        form = SupportCategoryForm(instance=category)
    return render(request, 'edit_support_category.html', {'form': form})


def delete_support_category(request, category_id):
    category = get_object_or_404(SupportCategory, id=category_id)

    # Set all tasks that have this support category to null in the correct database
    Task.objects.using('default').filter(support_category=category).update(support_category=None)

    if request.method == 'POST':
        category.delete()  # Now you can delete the support category
        return redirect('support_category_list')

    return render(request, 'delete_support_category.html', {'category': category})


# Incident Views
def incident_list(request):
    incidents = Incident.objects.all()
    form = IncidentForm()
    if request.method == 'POST':
        form = IncidentForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('incident_list')
    return render(request, 'incident_list.html', {'incidents': incidents, 'form': form})


def edit_incident(request, incident_id):
    incident = get_object_or_404(Incident, id=incident_id)
    if request.method == 'POST':
        form = IncidentForm(request.POST, instance=incident)
        if form.is_valid():
            form.save()
            return redirect('incident_list')
    else:
        form = IncidentForm(instance=incident)
    return render(request, 'edit_incident.html', {'form': form})


def delete_incident(request, incident_id):
    incident = get_object_or_404(Incident, id=incident_id)

    # Set all tasks that have this incident to null in the correct database
    Task.objects.using('default').filter(incident=incident).update(incident=None)

    if request.method == 'POST':
        incident.delete()  # Now you can delete the incident
        return redirect('incident_list')

    return render(request, 'delete_incident.html', {'incident': incident})
