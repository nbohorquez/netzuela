## Broker settings.
BROKER_URL = "amqp://"

# List of modules to import when celery starts.
CELERY_IMPORTS = ("productos.tareas", )

## Using the database to store task state and results.
CELERY_RESULT_BACKEND = "redis://localhost:6379/0"

CELERY_ANNOTATIONS = {"tareas.registrar_producto": {"rate_limit": "10/s"}}
