-- adding an index
create index idx_staff_salary on staff(salary)

-- explain with index
-- still a full table scan
explain select * from staff


-- try with a filter to see if index is used
-- why is index not used?  this is because so many rows are greater than 75000 so full scan is better.
-- in this case the where statement is not selective enough
explain analyze select * from staff where salary > 75000


-- try with a filter to see if index is used on more selective where
-- index is used and the execution time is very fast at 0.034ms
-- execution time can change every time so you need to do multiple and take an average
explain analyze select * from staff where salary > 150000