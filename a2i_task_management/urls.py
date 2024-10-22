from django.urls import path, include  # Include necessary modules
from django.contrib import admin
from tasks import views  # Import your custom views

urlpatterns = [
    # Custom admin dashboard URL
    path('admin/dashboard/', views.admin_dashboard, name='admin_dashboard'),  # Custom admin dashboard view

    # Admin routes for Django's built-in admin
    path('admin/', admin.site.urls),

    # Base URL redirects dynamically based on user type
    path('', views.home_redirect, name='home'),

    # Include URLs from tasks app
    path('tasks/', include('tasks.urls')),

    # Include management app URLs
    path('management/', include('management.urls')),
]
