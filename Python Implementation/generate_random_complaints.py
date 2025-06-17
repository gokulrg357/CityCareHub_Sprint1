import mysql.connector
import csv
from datetime import datetime
import time

# MySQL connection details
conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='gokul1808f@',
    database='sprint1'
)

cursor = conn.cursor()

# Function to calculate resolution time in hours
def calculate_resolution_time(created_at, resolved_at):
    if not resolved_at:
        return None
    fmt = "%Y-%m-%d %H:%M:%S"
    created = datetime.strptime(created_at, fmt)
    resolved = datetime.strptime(resolved_at, fmt)
    diff = resolved - created
    return round(diff.total_seconds() / 3600, 2)

# Read complaint CSV
with open("C:/Users/gokul/Downloads/complaintsss.csv", newline='', encoding='utf-8') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        complaint_id = int(row["complaint_id"])
        citizen_id = int(row["citizen_id"])
        department_id = int(row["department_id"])
        description = row["description"]
        status = row["status"]
        assigned_team_id = int(row["assigned_team_id"])
        created_at = row["created_at"]
        resolved_at = row["resolved_at"] if row["resolved_at"] else None
        zone_id = int(row["zone_id"])
        resolution_time = calculate_resolution_time(created_at, resolved_at)

        insert_query = """
            INSERT INTO fact_complaints (
                complaint_id, citizen_id, department_id, description, status,
                assigned_team_id, created_at, resolved_at, zone_id, resolution_time_hours
            )
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        values = (
            complaint_id, citizen_id, department_id, description, status,
            assigned_team_id, created_at, resolved_at, zone_id, resolution_time
        )

        cursor.execute(insert_query, values)
        print(f"Inserted complaint ID: {complaint_id}")
        time.sleep(1)  # simulate delay

# Commit changes and close connection
conn.commit()
cursor.close()
conn.close()
