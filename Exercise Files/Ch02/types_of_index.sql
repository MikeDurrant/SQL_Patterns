-- types of index

-- B-tree: commonly used (balanced trees)
-- Bitmap: used when commons have low cardinality (few distint values)
-- Hash: key value lookups
-- Special purpose: e.g. geospatial


-- B-tree: root and nodes; balanced because each subtree is roughly 50-50 split
--   efficient lookups through branching
--   index stores the location of a data block
--   works well for high cardinality
--   rebalances as needed
--   time access is logarithmic with number of nodes in the tree

-- explain tells us a full scan happens at cost of 26.5 (no index)
explain select * from staff where email = 'bphillips5@time.com'

-- create b-tree index (default index)
create index idx_staff_email on staff(email);

-- explain tells us a full scan happens at cost of 8.3 (no index)
explain select * from staff where email = 'bphillips5@time.com'

-- bitmaps: Yes No columns need two bits for each value
-- boolean operations are quick
-- good with low cardinality columns
-- updating bitmap indexes are costly to maintain
-- postgres calculates bitmaps on the fly - you do not create them
select * from staff where job_title = 'Operator'

-- no index cost 26.5 time 0.217ms
explain analyze select * from staff where job_title = 'Operator'

-- create index
create index idx_staff_job_title on staff(job_title);

-- explain again
-- this time a bitmap heap scan is used (only visits needed data blocks)
-- need to keep indexes up to date to give query planner lots of options
explain analyze select * from staff where job_title = 'Operator'

-- hash: matches arbritrary length data to a fixed hash value (with a hash algorithm)
-- only for equality (not for a range of values)
-- smaller than b-tree indexes
-- as fast as b-tree

-- create hash index
create index idx_hash_staff_email on staff using hash (email);

-- explain to see if using index
explain select * from staff where email = 'bphillips5@time.com'


-- postgres also has other index types:
-- gist, sp-gist, gin, brin