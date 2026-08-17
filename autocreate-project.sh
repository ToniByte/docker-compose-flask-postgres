#!/bin/bash

# Create project directory
mkdir -p docker-compose-flask-postgres
cd docker-compose-flask-postgres

# ======================
# app.py
# ======================
cat > app.py << 'EOF'
from flask import Flask
import os
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        database=os.getenv("DB_NAME", "tonibyte"),
        user=os.getenv("DB_USER", "tonibyte"),
        password=os.getenv("DB_PASSWORD", "tonibytepass")
    )
    return conn

@app.route("/")
def hello():
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT version();")
        db_version = cur.fetchone()
        cur.close()
        conn.close()
        return f"Hello from Docker Compose!<br>Database connected successfully.<br>PostgreSQL version: {db_version[0]}"
    except Exception as e:
        return f"Hello from Docker Compose!<br>Database connection failed: {e}"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
EOF

# ======================
# requirements.txt
# ======================
cat > requirements.txt << 'EOF'
flask
psycopg2-binary
EOF

# ======================
# Dockerfile
# ======================
cat > Dockerfile << 'EOF'
FROM python:3.12-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY app.py .

EXPOSE 5000

CMD ["python", "app.py"]
EOF

# ======================
# docker-compose.yml
# ======================
cat > docker-compose.yml << 'EOF'
services:
  web:
    build: .
    ports:
      - "5000:5000"
    environment:
      - DB_HOST=db
      - DB_NAME=tonibyte
      - DB_USER=tonibyte
      - DB_PASSWORD=tonibytepass
    depends_on:
      - db
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    environment:
      - POSTGRES_DB=tonibyte
      - POSTGRES_USER=tonibyte
      - POSTGRES_PASSWORD=tonibytepass
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

volumes:
  postgres_data:
EOF

docker-compose up -d --build

echo ""
echo "✅ Project created successfully!"
echo "📁 Folder: docker-compose-flask-postgres"