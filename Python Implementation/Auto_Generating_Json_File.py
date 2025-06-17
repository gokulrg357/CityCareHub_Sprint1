import json
import random

# Sample feedback comments
comments = [
    "Issue resolved quickly.",
    "Still waiting for resolution.",
    "Service was prompt and helpful.",
    "Had to call multiple times.",
    "Very satisfied with the solution.",
    "Poor response from the department.",
    "Team was cooperative and efficient.",
    "Complaint closed without resolution.",
    "Appreciate the fast service.",
    "Unsatisfactory handling of the issue."
]

# Generate 20 random feedback entries
feedback_data = []
for i in range(1, 21):  # feedback_id 1 to 20
    entry = {
        "feedback_id": i,
        "citizen_id": random.randint(101, 130),
        "complaint_id": random.randint(1001, 1020),
        "rating": random.randint(1, 5),
        "comment": random.choice(comments)
    }
    feedback_data.append(entry)

# Write to feedback.json
with open("feedback.json", "w", encoding="utf-8") as f:
    json.dump(feedback_data, f, indent=4)
    print("feedback.json file with 20 entries created successfully.")
