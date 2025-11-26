# Pharmacy E-Shop System

This is a web-based Pharmacy Management System built with **Python (Flask)** for the backend and **MySQL** for the database. It includes a customer interface for shopping and an admin dashboard for management.

## Prerequisites

Before beginning, ensure you have the following installed on your machine:

1.  **Python 3.x**
2.  **MySQL Server**
3.  **Git** (Optional).

---

## Installation Guide

### Step 1: Database Setup

This project heavily relies on MySQL **Stored Procedures**.

1.  Open your MySQL management tool (MySQL Workbench, phpMyAdmin, HeidiSQL, or DBeaver).
2.  Create a new database named `Pharmacy`:
    ```sql
    CREATE DATABASE Pharmacy;
    ```
3.  **Import the Data**:
    *   Locate the file named `pharmacy` (or `pharmacy.sql`) in the root folder of this project.
    *   Import/Execute this SQL file into the `Pharmacy` database to create tables and stored procedures.

4.  **Configure Database Connection**:
    *   Open the `app.py` file.
    *   Locate the `db_config` dictionary (around line 15).
    *   Update the `user` and `password` to match your local MySQL credentials.

    ```python
    db_config = {
        'host': 'localhost',
        'user': 'root',           # Your MySQL Username
        'password': 'YOUR_PASSWORD', # Change 'Daubu055@' to your actual password
        'database': 'Pharmacy'
    }
    ```

### Step 2: Install Python Dependencies

Open the terminal or command prompt in the project root directory.

1.  **(Optional but Recommended)** Create a virtual environment:
    ```bash
    python -m venv venv
    # Windows:
    venv\Scripts\activate
    # Mac/Linux:
    source venv/bin/activate
    ```

2.  **Install Required Packages**:
    Run the following command to install Flask, MySQL Connector, and other dependencies found in the code:
    ```bash
    pip install flask mysql-connector-python flask-cors werkzeug
    ```

---

## Running the Server

Once the database is set up and dependencies are installed:

1.  Run the application:
    ```bash
    python app.py
    ```

2.  If successful, you will see output indicating the server is running on port **5001**:
    ```
    * Running on http://127.0.0.1:5001/ (Press CTRL+C to quit)
    * Debugger is active!
    ```

---

## How to Use

Open the web browser and navigate to:

*   **Customer Home Page:** [http://127.0.0.1:5001/](http://127.0.0.1:5001/)
*   **Login / Register:** [http://127.0.0.1:5001/login_register.html](http://127.0.0.1:5001/login_register.html)
*   **Admin Login:** [http://127.0.0.1:5001/admin_login.html](http://127.0.0.1:5001/admin_login.html)

---

## Project Structure

*   **`app.py`**: The main Flask application file handling API routes and database logic.
*   **`templates/`**: Contains HTML files (Views).
*   **`static/`**: Contains CSS styles, JavaScript files, and images.
*   **`pharmacy`**: The SQL dump file containing database structure and stored procedures.

## Troubleshooting

1.  **MySQL Connection Error**:
    *   If you see `Access denied for user...`, double-check the `db_config` in `app.py`.
    *   Ensure your MySQL server is running.

2.  **Missing Procedure Error**:
    *   If the app says `PROCEDURE ... does not exist`, it means the SQL import failed or wasn't completed. Re-import the `pharmacy` file.

3.  **Port Conflict**:
    *   If port 5001 is busy, change the line `app.run(debug=True, port=5001)` at the bottom of `app.py` to a different port (e.g., 5000 or 8080).
