-- Problem 1
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains')

-- Problem 2
SELECT COUNT(DISTINCT species_id) as unique_species_count
from sightings;

-- Problem 3
SELECT * FROM sightings WHERE location LIKE '%Pass%';

-- Problem 4