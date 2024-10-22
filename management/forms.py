from django import forms
from .models import Source, SupportCategory, Incident

class SourceForm(forms.ModelForm):
    class Meta:
        model = Source
        fields = ['name']

class SupportCategoryForm(forms.ModelForm):
    class Meta:
        model = SupportCategory
        fields = ['name']  # Ensure the 'name' field is properly included

class IncidentForm(forms.ModelForm):
    class Meta:
        model = Incident
        fields = ['name']
