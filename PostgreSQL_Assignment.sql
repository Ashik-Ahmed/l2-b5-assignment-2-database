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

-- Problem 5
SELECT species.common_name
FROM species
    LEFT JOIN sightings ON species.species_id = sightings.species_id
WHERE
    sightings.species_id IS NULL;

-- Problem 6
SELECT species.common_name, sightings.sighting_time, rangers.name
FROM
    sightings
    JOIN species ON sightings.species_id = species.species_id
    JOIN rangers ON sightings.ranger_id = rangers.ranger_id
ORDER BY sightings.sighting_time DESC
LIMIT 2;

-- Problem 7
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    EXTRACT(
        YEAR
        FROM discovery_date
    ) < 1800;