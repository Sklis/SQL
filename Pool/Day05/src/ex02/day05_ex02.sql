CREATE INDEX idx_person_name ON person (upper(name));

set enable_seqscan =off;

explain  analyse
select * from person p
where upper(p.name) = upper('Denis');