FROM python:3.11.8
LABEL description = "Capstone-2024-19 magician server"
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENTRYPOINT ["python", "main.py"]