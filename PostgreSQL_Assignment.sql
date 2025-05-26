-- Active: 1747799976434@@127.0.0.1@5432@postgres
create table rangers (
  ranger_id serial primary key,
  name varchar(50) not null,
  region varchar(50) not null
);


create table species(
  species_id serial primary key,
  common_name varchar(100) not null,
  scientific_name VARCHAR(100) not NULL,
  discovery_date DATE not NULL,
  conservation_status varchar(50) check (
    conservation_status in ('Endangered', 'Vulnerable', 'Historic')
  )
);


create table sightings(
  sighting_id serial primary key,
  species_id integer REFERENCES species(species_id) on delete CASCADE,
  ranger_id INT REFERENCES rangers(ranger_id) on delete CASCADE,
  sighting_time TIMESTAMP not NULL,
  location VARCHAR(200) NOT NULL,
  notes TEXT
);


INSERT INTO rangers (name, region) VALUES
('Alice Green', 'Northern Hills'),
('Bob White', 'River Delta'),
('Carol King', 'Mountain Range'),
('Derek Fox', 'Coastal Plains'),
('Eva Stone', 'Sunset Canyon'),
('Frank Wolfe', 'Highland Forest'),
('Grace Dawn', 'Silent Valley'),
('Hugo Blaze', 'Eastern Peaks'),
('Ivy Moss', 'Foggy Hollow'),
('Jake Storm', 'Crystal Waters'),
('Kira Frost', 'Frozen Ridge'),
('Liam Fern', 'Verdant Basin');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Golden Eagle', 'Aquila chrysaetos', '1766-01-01', 'Vulnerable'),
('Indian Cobra', 'Naja naja', '1758-01-01', 'Vulnerable'),
('Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
('Gaur', 'Bos gaurus', '1827-01-01', 'Vulnerable'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Endangered'),
('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
('Black Panther', 'Panthera pardus', '1758-01-01', 'Endangered'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Indian Rhinoceros', 'Rhinoceros unicornis', '1758-01-01', 'Endangered'),
('Malayan Tapir', 'Tapirus indicus', '1819-01-01', 'Vulnerable'),
('Indian Wolf', 'Canis lupus pallipes', '1831-01-01', 'Endangered'),
('Nilgiri Tahr', 'Nilgiritragus hylocrius', '1838-01-01', 'Endangered'),
('Fishing Cat', 'Prionailurus viverrinus', '1827-01-01', 'Vulnerable'),
('Indian Star Tortoise', 'Geochelone elegans', '1831-01-01', 'Vulnerable'),
('Barasingha', 'Rucervus duvaucelii', '1823-01-01', 'Vulnerable'),
('Shadow Leopard', 'Panthera nebulosa nocturna', '2024-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(4, 4, 'Shadow Pass', '2024-05-19 10:00:00', 'Tracks seen'),
(5, 5, 'Stonewall Pass', '2024-05-20 08:30:00', 'High altitude flight'),
(6, 6, 'Riverbend', '2024-05-21 14:15:00', NULL),
(7, 7, 'Sunset Ridge', '2024-05-22 17:45:00', 'Cub spotted'),
(8, 8, 'Cedar Hollow', '2024-05-23 06:20:00', 'Herd moving'),
(9, 9, 'Cliff Pass', '2024-05-24 19:00:00', 'Elusive sighting'),
(10, 10, 'North Path', '2024-05-24 11:00:00', 'Quick slither'),
(11, 11, 'Southwatch', '2024-05-25 13:30:00', NULL),
(12, 12, 'Foggy Pass', '2024-05-25 09:15:00', 'Burrow found'),
(13, 1, 'Grassland Point', '2024-05-25 15:40:00', 'Single male'),
(14, 2, 'Moonlight Bay', '2024-05-26 07:00:00', 'Water crossing'),
(15, 3, 'Crystal River', '2024-05-26 18:20:00', NULL),
(16, 4, 'Whisper Pass', '2024-05-27 06:50:00', 'Tracks only'),
(17, 5, 'Dry Creek', '2024-05-27 09:30:00', NULL),
(18, 6, 'Foggy Hollow', '2024-05-27 12:15:00', 'Basking observed'),
(19, 7, 'Golden Trail', '2024-05-27 16:00:00', NULL),
(20, 8, 'Ivy Lookout', '2024-05-27 17:30:00', 'Roaring sound'),
(1, 9, 'Misty Pass', '2024-05-28 08:10:00', 'Footprints'),
(2, 10, 'Rocky Base', '2024-05-28 13:45:00', NULL),
(3, 11, 'Pine Valley', '2024-05-28 14:25:00', NULL),
(4, 12, 'Wildbrush Path', '2024-05-28 15:55:00', 'Calf sighted'),
(5, 1, 'Southward Ridge', '2024-05-29 09:10:00', NULL),
(6, 2, 'Echoing Woods', '2024-05-29 10:50:00', NULL),
(7, 3, 'Passwatch Cliffs', '2024-05-29 11:30:00', 'Vocal calls'),
(8, 4, 'River Delta', '2024-05-29 13:00:00', NULL),
(9, 5, 'Northern Hills', '2024-05-29 14:45:00', 'Leopard cry'),
(10, 6, 'Oldstone Pass', '2024-05-29 17:00:00', 'Den found');

--* Problem 1 
insert into rangers (name, region) values ('Derek Fox', 'Costal Plains');

--* Problem 2
select count(DISTINCT species_id) as unique_species_count from sightings;

--* Problem 3
select * from sightings WHERE location ILIKE '%pass';


--* Problem 4
select r.name, count(s.sighting_id) as total_sightings 
  from rangers r 
  left JOIN sightings s ON r.ranger_id = s.ranger_id
  GROUP BY r.ranger_id, r.name
  ORDER BY r.name;

--* Problem 5
 SELECT common_name 
  FROM species 
  where species_id NOT in (
    SELECT DISTINCT species_id 
    from sightings
  );


  --* Problem 6
  SELECT sp.common_name, s.sighting_time, r.name 
  FROM sightings s 
  JOIN species sp ON s.species_id = sp.species_id 
  JOIN rangers r ON s.ranger_id = r.ranger_id 
  ORDER BY s.sighting_time DESC LIMIT 2; 


--* Problem 7
UPDATE species SET conservation_status = 'Historic' 
where discovery_date < '1800-01-01';

-- * Problem 8
SELECT sighting_id,
  CASE 
    WHEN extract(HOUR from sighting_time) < 12 then 'Morning' 
    WHEN  extract(HOUR FROM sighting_time) between 12 and 17 then 'Afternoon' 
    ELSE  'Evening'
  END AS time_of_day
FROM sightings
ORDER BY sighting_id;

--* Problem 9
DELETE from rangers 
  WHERE ranger_id NOT IN (
    select DISTINCT ranger_id from sightings
  );


select * from rangers;
select * from species;
select * from sightings;


