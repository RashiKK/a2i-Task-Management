# Generated by Django 4.2.6 on 2024-09-17 08:49

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0008_task_created_by'),
    ]

    operations = [
        migrations.AlterField(
            model_name='userprofile',
            name='nid',
            field=models.CharField(blank=True, max_length=50, null=True, unique=True),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='phone_no',
            field=models.CharField(blank=True, max_length=20, null=True),
        ),
    ]
