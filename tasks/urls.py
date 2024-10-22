from django.urls import path
from . import views

urlpatterns = [
    # Admin dashboard
    path('admin-panel/dashboard/', views.admin_dashboard, name='admin_dashboard'),

    # User management for admins
    path('admin/create_user/', views.create_user, name='create_user'),
    path('admin/users/', views.admin_user_management, name='admin_user_management'),
    path('admin/view_user/<int:user_id>/', views.view_user_profile, name='view_user_profile'),
    path('admin/edit_user/<int:user_id>/', views.edit_user_profile, name='edit_user_profile'),
    path('admin/delete_user/<int:user_id>/', views.delete_user, name='delete_user'),

    # User Dashboard and Tasks
    path('user/dashboard/', views.general_user_dashboard, name='user_dashboard'),
    path('user/tasks/', views.task_list, name='task_list'),
    path('user/tasks/add/', views.add_task, name='add_task'),
    path('user/tasks/edit/<int:task_id>/', views.edit_task, name='edit_task'),
    path('user/tasks/delete/<int:task_id>/', views.delete_task, name='delete_task'),
    path('user/edit_profile/', views.edit_profile, name='edit_profile'),

    # Admin-specific task management
    path('admin-panel/tasks/edit/<int:task_id>/', views.edit_task, name='edit_task'),
    path('admin-panel/tasks/delete/<int:task_id>/', views.delete_task, name='delete_task'),

    # Authentication
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),

    # Download Tasks
    path('tasks/download/<int:task_id>/', views.download_task, name='download_task'),
    path('tasks/download-all/', views.download_all_tasks, name='download_all_tasks'),  # New path for downloading all tasks

    path('download_user_tasks/<int:user_id>/', views.download_user_tasks, name='download_user_tasks'),
    path('give-attendance/', views.give_attendance, name='give_attendance'),
    path('attendance-dashboard/', views.attendance_dashboard, name='attendance_dashboard'),
    path('attendance-list/', views.attendance_list, name='attendance_list'), 
]
