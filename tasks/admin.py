from django.contrib import admin
from .models import UserProfile  # Make sure this import matches your models.py


admin.site.register(UserProfile)

