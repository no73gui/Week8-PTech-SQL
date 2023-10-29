-- Drop tables with foreign key references. These tables need to be created AFTER the tables with 0 foreign key constraints.
-- project_category has foreign keys
DROP TABLE IF EXISTS project_category;
DROP TABLE IF EXISTS material;
DROP TABLE IF EXISTS step;
DROP TABLE IF EXISTS projects;
DROP TABLE IF EXISTS category;
-- Create tables without foreign key constraints
CREATE TABLE IF NOT EXISTS projects (
    project_id INT NOT NULL AUTO_INCREMENT,
    project_name VARCHAR(128),
    estimated_hours DECIMAL(7, 2),
    actual_hours DECIMAL(7, 2),
    difficulty INT,
    notes TEXT,
    PRIMARY KEY (project_id)
);
CREATE TABLE IF NOT EXISTS category (
    category_id INT NOT NULL AUTO_INCREMENT,
    category_name VARCHAR(128),
    PRIMARY KEY (category_id)
);
-- Create tables with foreign key constraints. These tables need to form relationships with pre-existing tables the server already knows about.
CREATE TABLE IF NOT EXISTS project_category (
    project_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS material (
    material_id INT NOT NULL AUTO_INCREMENT,
    project_id INT NOT NULL,
    material_name VARCHAR(128) NOT NULL,
    num_required INT,
    cost DECIMAL(7, 2),
    PRIMARY KEY (material_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS step (
    step_id INT NOT NULL AUTO_INCREMENT,
    project_id INT NOT NULL,
    step_text TEXT NOT NULL,
    step_order INT,
    PRIMARY KEY (step_id),
    FOREIGN KEY (project_id) REFERENCES projects(project_id) ON DELETE CASCADE
);