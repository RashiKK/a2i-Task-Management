# Generated by Django 4.2.6 on 2024-09-22 04:27

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('tasks', '0012_remove_task_title_alter_task_source'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='task_date',
            field=models.DateField(blank=True, null=True),
        ),
    ]