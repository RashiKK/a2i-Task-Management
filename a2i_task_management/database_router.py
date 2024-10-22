class ManagementRouter:
    """
    A router to control all database operations on models in the management app.
    """

    def db_for_read(self, model, **hints):
        """Direct read operations for management models to 'management_db'."""
        if model._meta.app_label == 'management':
            return 'management_db'
        return 'default'

    def db_for_write(self, model, **hints):
        """Direct write operations for management models to 'management_db'."""
        if model._meta.app_label == 'management':
            return 'management_db'
        return 'default'

    def allow_relation(self, obj1, obj2, **hints):
        """Allow relations if a model in the management app is involved."""
        if obj1._meta.app_label == 'management' or obj2._meta.app_label == 'management':
            return True
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        """Ensure that management models only appear in the 'management_db'."""
        if app_label == 'management':
            return db == 'management_db'
        return db == 'default'
