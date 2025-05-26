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
('Eva Stone', 'Sunset Canyon'),
('Frank Wolfe', 'Highland Forest'),
('Grace Dawn', 'Silent Valley'),
('Hugo Blaze', 'Eastern Peaks');


INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) VALUES
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Golden Eagle', 'Aquila chrysaetos', '1766-01-01', 'Vulnerable'),
('Indian Cobra', 'Naja naja', '1758-01-01', 'Vulnerable'),
('Sloth Bear', 'Melursus ursinus', '1791-01-01', 'Vulnerable'),
('Clouded Leopard', 'Neofelis nebulosa', '1821-01-01', 'Endangered'),
('King Cobra', 'Ophiophagus hannah', '1836-01-01', 'Vulnerable'),
('Indian Pangolin', 'Manis crassicaudata', '1822-01-01', 'Endangered'),
('Barasingha', 'Rucervus duvaucelii', '1823-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered'),
('Indian Star Tortoise', 'Geochelone elegans', '1831-01-01', 'Vulnerable'),
('Black Panther', 'Panthera pardus', '1758-01-01', 'Endangered');


INSERT INTO sightings (species_id, ranger_id, location, sighting_time, notes) VALUES
(1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image'),
(2, 2, 'Riverbend', '2024-05-11 13:00:00', 'Paw prints'),
(3, 3, 'Bamboo Grove East', '2024-05-12 09:10:00', NULL),
(4, 4, 'Stonewall Pass', '2024-05-13 08:30:00', 'High altitude'),
(5, 5, 'Riverbend', '2024-05-14 14:15:00', 'Slither'),
(6, 6, 'Sunset Ridge', '2024-05-15 17:45:00', 'Cub spotted'),
(7, 7, 'Cedar Hollow', '2024-05-16 06:20:00', 'Herd moving'),
(8, 1, 'Foggy Pass', '2024-05-17 09:15:00', 'Burrow found'),
(9, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL),
(1, 3, 'Moonlight Bay', '2024-05-19 07:00:00', 'Crossing'),
(2, 4, 'Crystal River', '2024-05-20 18:20:00', NULL),
(3, 5, 'Whisper Pass', '2024-05-21 06:50:00', 'Tracks only'),
(4, 6, 'Dry Creek', '2024-05-22 09:30:00', NULL),
(5, 7, 'Foggy Hollow', '2024-05-23 12:15:00', 'Sunbathing'),
(6, 1, 'Golden Trail', '2024-05-24 16:00:00', NULL),
(7, 2, 'Ivy Lookout', '2024-05-25 17:30:00', 'Roaring sound'),
(8, 3, 'Misty Pass', '2024-05-26 08:10:00', 'Footprints'),
(9, 4, 'Rocky Base', '2024-05-27 13:45:00', NULL),
(1, 5, 'Pine Valley', '2024-05-28 14:25:00', NULL),
(2, 6, 'Oldstone Pass', '2024-05-29 17:00:00', 'Den found');




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



