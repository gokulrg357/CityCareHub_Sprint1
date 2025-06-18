-- dim_citizens table

CREATE TABLE dim_citizens (
    citizen_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT
);
INSERT INTO dim_citizens (citizen_id, name, email, phone, address)
SELECT DISTINCT citizen_id, name, email, phone, address
FROM source_citizens
WHERE citizen_id IS NOT NULL;


-- dim_zones table
CREATE TABLE dim_zones (
    zone_id INT PRIMARY KEY,
    zone_name VARCHAR(100),
    zone_supervisor VARCHAR(100)
);
INSERT INTO dim_zones (zone_id, zone_name, zone_supervisor)
SELECT DISTINCT
    zone_id,
    CONCAT('Zone ', zone_id),
    CONCAT('Supervisor_', zone_id)
FROM source_complaints
WHERE zone_id IS NOT NULL;

-- dim_departments table
CREATE TABLE dim_departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    department_head VARCHAR(100)
);
INSERT INTO dim_departments (department_id, department_name, department_head)
SELECT DISTINCT
    department_id,
    CONCAT('Department ', department_id),
    CONCAT('Head_', department_id)
FROM source_complaints
WHERE department_id IS NOT NULL;


-- dim_teams table
CREATE TABLE dim_teams (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(100),
    department_id INT,
    team_lead VARCHAR(100),
    FOREIGN KEY (department_id) REFERENCES dim_departments(department_id)
);
INSERT INTO dim_teams (team_id, team_name, department_id, team_lead)
SELECT 
    assigned_team_id,
    CONCAT('Team ', assigned_team_id),
    MIN(department_id),  -- Or MAX, depending on logic
    CONCAT('Lead_', assigned_team_id)
FROM source_complaints
WHERE assigned_team_id IS NOT NULL
GROUP BY assigned_team_id;


-- fact_complaints table
CREATE TABLE fact_complaints (
    complaint_id INT PRIMARY KEY,
    citizen_id INT,
    department_id INT,
    complaint_type VARCHAR(100),
    description TEXT,
    status VARCHAR(50),
    assigned_team_id INT,
    created_at DATETIME,
    resolved_at DATETIME,
    zone_id INT,
    resolution_time_hours INT,

    FOREIGN KEY (citizen_id) REFERENCES dim_citizens(citizen_id),
    FOREIGN KEY (department_id) REFERENCES dim_departments(department_id),
    FOREIGN KEY (assigned_team_id) REFERENCES dim_teams(team_id),
    FOREIGN KEY (zone_id) REFERENCES dim_zones(zone_id)
);

INSERT INTO fact_complaints (
    complaint_id, citizen_id, department_id, complaint_type, description, status,
    assigned_team_id, created_at, resolved_at, zone_id, resolution_time_hours
)
SELECT DISTINCT
    sc.complaint_id,
    sc.citizen_id,
    sc.department_id,
    sc.complaint_type,
    sc.description,
    sc.status,
    sc.assigned_team_id,
    STR_TO_DATE(NULLIF(sc.created_at, ''), '%Y-%m-%d %H:%i:%s'),
    STR_TO_DATE(NULLIF(sc.resolved_at, ''), '%Y-%m-%d %H:%i:%s'),
    sc.zone_id,
    TIMESTAMPDIFF(HOUR,
        STR_TO_DATE(NULLIF(sc.created_at, ''), '%Y-%m-%d %H:%i:%s'),
        STR_TO_DATE(NULLIF(sc.resolved_at, ''), '%Y-%m-%d %H:%i:%s')
    )
FROM source_complaints sc
WHERE
    sc.complaint_id IS NOT NULL
    AND sc.created_at <> ''
    AND sc.resolved_at <> ''
    AND NOT EXISTS (
        SELECT 1 FROM fact_complaints fc WHERE fc.complaint_id = sc.complaint_id
    );
 
 
 -- fact_feedback table   
    CREATE TABLE fact_feedback (
    feedback_id INT PRIMARY KEY,
    citizen_id INT,
    complaint_id INT,
    rating INT,
    comment TEXT,

    FOREIGN KEY (citizen_id) REFERENCES dim_citizens(citizen_id),
    FOREIGN KEY (complaint_id) REFERENCES fact_complaints(complaint_id)
);


INSERT INTO fact_feedback (
    feedback_id, citizen_id, complaint_id, rating, comment
)
SELECT DISTINCT
    sf.feedback_id,
    sf.citizen_id,
    sf.complaint_id,
    sf.rating,
    sf.comment
FROM source_feedback sf
JOIN fact_complaints fc ON sf.complaint_id = fc.complaint_id
WHERE sf.feedback_id IS NOT NULL;
