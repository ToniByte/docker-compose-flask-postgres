from flask import Flask
import os
import psycopg2

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
    host=os.getenv("DB_HOST"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=os.getenv("DB_PORT", "5432"),
    sslmode="require",
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