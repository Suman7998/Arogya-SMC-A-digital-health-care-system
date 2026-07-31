ALTER TABLE facilities ADD COLUMN geom GEOMETRY(Point, 4326);
UPDATE facilities SET geom = ST_SetSRID(ST_MakePoint(location_lng, location_lat), 4326);
CREATE INDEX idx_facilities_geom ON facilities USING GIST (geom);
