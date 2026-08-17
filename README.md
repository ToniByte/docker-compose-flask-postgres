<div align="center">

T O N I B Y T E 

### Docker Compose — Flask + PostgreSQL

**Multi-container application with Flask and PostgreSQL**

[![Docker](https://img.shields.io/badge/Docker-Compose-blue?logo=docker)](https://www.docker.com/)
[![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)](https://www.python.org/)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?logo=postgresql)](https://www.postgresql.org/)
[![Flask](https://img.shields.io/badge/Flask-Latest-black?logo=flask)](https://flask.palletsprojects.com/)

</div>

---

# Docker Compose Flask + PostgreSQL

This project demonstrates how to run a Flask application together with a PostgreSQL database using Docker Compose.

## Goals

- Run multiple containers as a single application stack
- Connect a Python application to PostgreSQL
- Manage the entire environment with one configuration file
- Learn the basics of multi-container Docker workflows

## Project Structure

```text
docker-compose-flask-postgres/
├── app.py
├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── README.md
```

## Services

| Service | Description | Port |
| web | Flask application | 5000 |
| db | PostgreSQL 16 database | 5432 |

# How to Run  

## 1. Build and start all services  
```bash
docker-compose up -d --build
```
## 2. Check running services  
```bash
docker-compose ps
```
## 3. View logs  
```bash
docker-compose logs -f
```
## View logs of a specific service:  
```bash
docker-compose logs -f web
docker-compose logs -f db
```
## 4. Open the application  
```text
http://YOUR_SERVER_IP:5000
```
  
You should see a message confirming that the database connection is successful.  

text```
Hello from Docker Compose!  
Database connected successfully.  
```

# Useful Commands

```bash
docker-compose up -d --build #Build images and start all services
docker-compose ps            #List running services
docker-compose logs -f       #Follow logs of all services
docker-compose logs -f web   #Follow logs of the Flask app
docker-compose restart web   #Restart only the web service
docker-compose stop          #Stop all services
docker-compose start         #Start previously stopped services
docker-compose down          #Stop and remove containers
docker-compose down -v       #Stop containers and delete volumes
```

# Environment Variables  

The Flask application uses the following environment variables (defined in docker-compose.yml):  

| Variable | Default value | Description |
| DB_HOST | db | PostgreSQL hostname |
| DB_NAME | tonibyte | Database name | 
| DB_USER | tonibyte | Database user |
| DB_PASSWORD | tonibytepass | Database password |

# How It Works

1. Docker Compose starts two services: web and db  
2. The db service runs PostgreSQL and stores data in a named volume  
3. The web service builds the Flask application from the Dockerfile  
4. Flask connects to PostgreSQL using the psycopg2 driver  
5. The depends_on option ensures the database starts before the application 

# Why Docker Compose?

Running multiple containers manually is inconvenient and error-prone.  

Docker Compose allows you to:  

• Define the entire application stack in one file
• Start and stop all services with a single command
• Manage networking and volumes automatically
• Keep the development environment consistent

# License

This project is for educational and portfolio purposes.
