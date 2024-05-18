FROM python:3.11-slim
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY pythonv2.py app.py
COPY ../.env .env
CMD ["python", "app.py"]