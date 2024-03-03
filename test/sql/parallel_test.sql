BEGIN;
SET max_parallel_workers_per_gather=4;
DO $$
BEGIN
    IF current_setting('server_version_num')::int >= 160000 THEN
        EXECUTE 'SET debug_parallel_query = on';
    ELSE
        EXECUTE 'SET force_parallel_mode = on';
    END IF;
END $$;

CREATE TABLE parallel_test(i int, b1 base36, b2 bigbase36) WITH (parallel_workers = 4);
INSERT INTO parallel_test (i, b1, b2)
SELECT i, i::int, i::bigint
FROM generate_series(1,1e6) i;

EXPLAIN (costs off,verbose)
SELECT COUNT(*) FROM parallel_test WHERE b1 = '1ftese';

EXPLAIN (costs off,verbose)
SELECT COUNT(*) FROM parallel_test WHERE b2 = '1ftese';

EXPLAIN (costs off,verbose)
SELECT b1, COUNT(*) FROM parallel_test GROUP BY 1;
ROLLBACK;
