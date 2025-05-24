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
SELECT rangers.name, COUNT(sighting_id) AS total_sightings
FROM sightings
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
GROUP BY
    rangers.name;