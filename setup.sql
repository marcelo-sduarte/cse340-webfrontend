
-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');
 
-- ========================================
-- W02 Team Activity: Database Entities for Service Projects
-- Each Service Project should have the following information:
-- Project ID
-- Organization ID (of the organization that sponsors it)
-- Title
-- Description
-- Location
-- Date
-- ========================================
CREATE TABLE service_projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    project_date DATE,
    
    -- Relationship: Links to the Organizations table
    CONSTRAINT fk_organization
      FOREIGN KEY(organization_id) 
      REFERENCES organization(organization_id)
      ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: service projects
-- ========================================

-- =========================================================================
-- ORGANIZATION 1: BrightFuture Builders (5 Projects)
-- =========================================================================
INSERT INTO service_projects (organization_id, title, description, location, project_date) VALUES
(1, 'Community Center Roof Repair', 'Replacing damaged shingles and sealing leaks at the local youth center.', '123 Hope Street, Sector 4', '2026-06-01'),
(1, 'Park Bench Installation', 'Assembling and installing 10 new eco-friendly benches along the walking trail.', 'Riverside Park', '2026-06-05'),
(1, 'Wheelchair Ramp Construction', 'Building a wooden access ramp for an elderly community member’s home.', '45 Pine Avenue', '2026-06-12'),
(1, 'Library Painting Initiative', 'Repainting the children’s reading section with vibrant, welcoming colors.', 'Downtown Public Library', '2026-06-18'),
(1, 'Bus Stop Shelter Assembly', 'Constructing a new weather shelter at the main commuter bus stop.', 'Maple & 5th Intersection', '2026-06-25');

-- =========================================================================
-- ORGANIZATION 2: GreenHarvest Growers (5 Projects)
-- =========================================================================
INSERT INTO service_projects (organization_id, title, description, location, project_date) VALUES
(2, 'Spring Soil Preparation', 'Tilling community garden beds and mixing in organic compost.', 'GreenHarvest Main Hub', '2026-05-20'),
(2, 'Urban Greenhouse Assembly', 'Putting together a polycarbonate greenhouse kit for year-round growing.', 'West End Community Plot', '2026-05-27'),
(2, 'Rain Barrel Installation', 'Setting up rainwater collection systems on community farm sheds.', 'East Side Urban Farm', '2026-06-03'),
(2, 'Tomato Planting Drive', 'Planting over 100 heirloom tomato seedlings with local volunteers.', 'South Suburb Greenhouse', '2026-06-10'),
(2, 'Composting Workshop Setup', 'Building three-tier compost bins and setting up an educational station.', 'Civic Center Back Lawn', '2026-06-17');

-- =========================================================================
-- ORGANIZATION 3: UnityServe Volunteers (5 Projects)
-- =========================================================================
INSERT INTO service_projects (organization_id, title, description, location, project_date) VALUES
(3, 'Food Bank Sorting Day', 'Organizing and boxing canned food donations for weekly distribution.', 'County Food Bank Hub', '2026-05-22'),
(3, 'Senior Citizen Technology Day', 'One-on-one tutoring helping seniors navigate tablets and smartphones.', 'Oakridge Retirement Home', '2026-05-29'),
(3, 'Homeless Shelter Meal Prep', 'Cooking and serving hot dinners to residents at the shelter.', 'St. Jude Outreach Center', '2026-06-04'),
(3, 'Park Litter Cleanup Drive', 'Equipping volunteers to clear trash from walking trails and waterways.', 'Valley Woods Nature Trail', '2026-06-11'),
(3, 'School Supply Packing', 'Filling 500 backpacks with notebooks, pens, and markers for kids.', 'UnityServe Headquarters', '2026-06-18');

-- ========================================
-- Categories Table
--Categories have the following requirements:
-- Each category has a unique ID and a name.
-- A service project can belong to one or more categories.
-- A category can be associated with one more more service projects.
-- The relationship will be many to many
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE project_category (
    project_id INTEGER NOT NULL,
    category_id INTEGER NOT NULL,
    
    -- Composite Primary Key ensures a project cannot be assigned to the exact same category twice
    PRIMARY KEY (project_id, category_id),
    
    -- Links to the Service Projects table
    CONSTRAINT fk_project
        FOREIGN KEY (project_id) 
        REFERENCES service_projects(project_id) 
        ON DELETE CASCADE,
        
    -- Links to the Category table
    CONSTRAINT fk_category
        FOREIGN KEY (category_id) 
        REFERENCES category(category_id) 
        ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: project category 
-- ========================================
INSERT INTO category (name) VALUES 
('Construction & Infrastructure'),
('Environment & Agriculture'),
('Education & Training'),
('Community Outreach & Support');

-- =========================================================================
-- ASSOCIATIONS FOR BRIGHTFUTURE BUILDERS (Projects 1 - 5)
-- Primarily: Construction & Infrastructure (Category 1)
-- =========================================================================
INSERT INTO project_category (project_id, category_id) VALUES
(1, 1), -- Project 1 (Roof Repair) -> Construction
(2, 1), -- Project 2 (Park Benches) -> Construction
(2, 2), -- Project 2 (Park Benches) -> also fits Environment!
(3, 1), -- Project 3 (Wheelchair Ramp) -> Construction
(4, 1), -- Project 4 (Library Painting) -> Construction
(4, 3), -- Project 4 (Library Painting) -> also fits Education!
(5, 1); -- Project 5 (Bus Stop Shelter) -> Construction

-- =========================================================================
-- ASSOCIATIONS FOR GREENHARVEST GROWERS (Projects 6 - 10)
-- Primarily: Environment & Agriculture (Category 2)
-- =========================================================================
INSERT INTO project_category (project_id, category_id) VALUES
(6, 2), -- Project 6 (Soil Prep) -> Environment
(7, 2), -- Project 7 (Greenhouse Assembly) -> Environment
(7, 1), -- Project 7 (Greenhouse Assembly) -> also fits Construction!
(8, 2), -- Project 8 (Rain Barrel) -> Environment
(9, 2), -- Project 9 (Tomato Planting) -> Environment
(10, 2); -- Project 10 (Compost Workshop) -> Environment

-- =========================================================================
-- ASSOCIATIONS FOR UNITYSERVE VOLUNTEERS (Projects 11 - 15)
-- Primarily: Community Outreach / Education (Categories 4 & 3)
-- =========================================================================
INSERT INTO project_category (project_id, category_id) VALUES
(11, 4), -- Project 11 (Food Bank Sorting) -> Community Outreach
(12, 3), -- Project 12 (Senior Tech Day) -> Education
(12, 4), -- Project 12 (Senior Tech Day) -> also fits Community Outreach!
(13, 4), -- Project 13 (Homeless Meal Prep) -> Community Outreach
(14, 2), -- Project 14 (Park Litter Cleanup) -> Environment
(14, 4), -- Project 14 (Park Litter Cleanup) -> also fits Community Outreach!
(15, 3); -- Project 15 (School Supply Packing) -> Education