from django.db import models
from django.contrib.auth.models import User
from management.models import Source, SupportCategory, Incident 
from django.utils import timezone


# Choices for blood group and user types
BLOOD_GROUP_CHOICES = [
    ('A+', 'A+'),
    ('A-', 'A-'),
    ('B+', 'B+'),
    ('B-', 'B-'),
    ('AB+', 'AB+'),
    ('AB-', 'AB-'),
    ('O+', 'O+'),
    ('O-', 'O-'),
]

USER_TYPE_CHOICES = [
    ('admin', 'Admin'),
    ('general', 'General User'),
     ('team_coordinator', 'Team Coordinator'),
]

# UserProfile model to extend the default Django User model
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    full_name = models.CharField(max_length=255)
    nid = models.CharField(max_length=50, unique=True, null=True, blank=True)
    phone_no = models.CharField(max_length=20, null=True, blank=True)
    blood_group = models.CharField(max_length=4, choices=BLOOD_GROUP_CHOICES, null=True, blank=True)
    date_of_birth = models.DateField(null=True, blank=True)
    user_type = models.CharField(max_length=20, choices=USER_TYPE_CHOICES)

    def __str__(self):
        return self.user.username

# Task model
class Task(models.Model):
    description = models.TextField()
    status = models.CharField(max_length=50, choices=[
        ('Dependency', 'Dependency'),
        ('Pending', 'Pending'),
        ('Done', 'Done'),
        ('Working', 'Working'),
        ('i-Top', 'i-Top'),
        ('Others', 'Others'),
    ])
    created_at = models.DateTimeField(auto_now_add=True)
    source = models.ForeignKey('management.Source', on_delete=models.SET_NULL, null=True)
    incident = models.ForeignKey('management.Incident', on_delete=models.SET_NULL, null=True)
    support_category = models.ForeignKey('management.SupportCategory', on_delete=models.SET_NULL, null=True)
    office_name = models.CharField(max_length=255)
    created_by = models.ForeignKey(User, on_delete=models.CASCADE, related_name='tasks')
    task_date = models.DateField(null=True, blank=True)

    def __str__(self):
        return f"Task {self.pk}"

# TaskAttachment model for file attachments
class TaskAttachment(models.Model):
    task = models.OneToOneField(Task, on_delete=models.CASCADE, related_name='attachment')
    attachment = models.FileField(upload_to='uploads/')

    def __str__(self):
        return f"Attachment for {self.task.id}"



class Attendance(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    date = models.DateField(auto_now_add=True)  # Date of attendance
    time_in = models.TimeField(null=True, blank=True)  # Time the user marked attendance
    time_out = models.TimeField(null=True, blank=True)  # Time the user checked out (if needed)
    is_present = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.user.username} - {self.date} - {self.time_in}"