import csv
import random
from datetime import datetime, timedelta

# Header
data = [
    ["complaint_id", "citizen_id", "department_id", "description", "status", "assigned_team_id", "created_at",
     "resolved_at", "zone_id"]
]

# Sample descriptions and statuses
descriptions = [
    "Overflowing dustbin", "Streetlight not working", "Garbage not collected", "Water leakage",
    "Road potholes", "Illegal parking", "Noise complaint", "Open manhole",
    "Tree fallen", "Drain blockage"
]
statuses = ["Resolved", "Pending", "In Progress"]

# Generate 20 random complaint records
base_date = datetime(2024, 6, 1, 8, 0, 0)
for i in range(1001, 1021):  # complaint_id from 1001 to 1020
    citizen_id = random.randint(101, 130)
    department_id = random.randint(1, 5)
    description = random.choice(descriptions)
    status = random.choice(statuses)
    assigned_team_id = random.randint(1, 3)
    created_at = base_date + timedelta(days=random.randint(0, 15), hours=random.randint(0, 23),
                                       minutes=random.randint(0, 59))

    # If resolved, set resolved_at 1–5 hours later; else empty
    if status == "Resolved":
        resolved_at = created_at + timedelta(hours=random.randint(1, 5))
        resolved_str = resolved_at.strftime("%Y-%m-%d %H:%M:%S")
    else:
        resolved_str = ""

    zone_id = random.randint(1, 4)

    data.append([
        i,
        citizen_id,
        department_id,
        description,
        status,
        assigned_team_id,
        created_at.strftime("%Y-%m-%d %H:%M:%S"),
        resolved_str,
        zone_id
    ])

# Write to CSV
with open("complaints.csv", mode="w", newline='', encoding='utf-8') as file:
    writer = csv.writer(file)
    writer.writerows(data)

print("complaintsss.csv with 20 rows generated successfully.")
