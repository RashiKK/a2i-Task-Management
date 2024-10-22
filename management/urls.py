from django.urls import path
from . import views  # Import the views from management

urlpatterns = [
    # Source management
    path('sources/', views.source_list, name='source_list'),
    path('sources/edit/<int:source_id>/', views.edit_source, name='edit_source'),
    path('sources/delete/<int:source_id>/', views.delete_source, name='delete_source'),

    # SupportCategory management
    path('support-categories/', views.support_category_list, name='support_category_list'),
    path('support-categories/edit/<int:category_id>/', views.edit_support_category, name='edit_support_category'),
    path('support-categories/delete/<int:category_id>/', views.delete_support_category, name='delete_support_category'),

    # Incident management
    path('incidents/', views.incident_list, name='incident_list'),
    path('incidents/edit/<int:incident_id>/', views.edit_incident, name='edit_incident'),
    path('incidents/delete/<int:incident_id>/', views.delete_incident, name='delete_incident'),
]
