import mysql.connector
import json

# MySQL database connection
conn = mysql.connector.connect(
    host='localhost',
    user='root',       
    password='gokul1808f@',   
    database='citycarehub'    
)
cursor = conn.cursor()

# Function to insert feedback into fact_feedback table
def insert_feedback(feedback_id, citizen_id, complaint_id, rating, comment):
    query = """
        INSERT INTO fact_feedback (
            feedback_id, citizen_id, complaint_id, rating, comment
        ) VALUES (%s, %s, %s, %s, %s)
    """
    values = (feedback_id, citizen_id, complaint_id, rating, comment)
    cursor.execute(query, values)
    print(f"Inserted feedback ID: {feedback_id}")

# Parse JSON file and insert records
def parse_json_feedback(file_path):
    with open(file_path, 'r') as f:
        feedback_list = json.load(f)
        for fb in feedback_list:
            insert_feedback(
                fb["feedback_id"],
                fb["citizen_id"],
                fb["complaint_id"],
                fb["rating"],
                fb["comment"]
            )

# Call the function with your JSON file
parse_json_feedback("C:/Users/gokul/Downloads/feedback.json")

# Commit and close connection
conn.commit()
cursor.close()
conn.close()
