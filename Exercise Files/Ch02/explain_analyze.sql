-- get explain plan
-- for this one we get a full table scan (Seq Scan on staff)

explain
select * from staff


-- analyze also get back some other details
explain analyze select * from staff;

-- width is reduced for only one column
explain analyze select last_name from staff



-- a where clause added
-- computational units goes up from 0.24 to 0.265
-- execution time goes up from 0.109ms to 0.302ms
-- because additional steps require more cost
explain analyze  select * from staff where salary > 75000