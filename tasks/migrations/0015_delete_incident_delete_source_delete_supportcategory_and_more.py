from django.db import migrations

class Migration(migrations.Migration):

    dependencies = [
        ('management', '0001_initial'),  # Management app dependency
        ('tasks', '0014_incident_source_supportcategory_and_more'),
    ]

    operations = [
        # All operations related to Incident, Source, and SupportCategory have been removed
        # because these models are now in the management app, and no further modifications
        # in tasks are needed in this migration.
    ]
