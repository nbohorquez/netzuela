from __future__ import absolute_import
from celery import Celery

celery = Celery(broker='amqp://',
                backend='redis://localhost:6379/0',
                include=['productos.tareas'])
celery.conf.update(
	CELERY_TASK_RESULT_EXPIRES=3600,
)

if __name__ == '__main__':
	celery.start()
