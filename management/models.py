from django.db import models

# Model for Source
class Source(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

# Model for SupportCategory
class SupportCategory(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name

# Model for Incident
class Incident(models.Model):
    name = models.CharField(max_length=100)

    def __str__(self):
        return self.name
