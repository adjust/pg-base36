-- bigbase36 binary should copy data binary from country;
BEGIN;
CREATE TABLE before (a bigbase36);
INSERT INTO before VALUES ('aa'), ('-aa'), ('1y2p0ij32e8e7'), ('-1y2p0ij32e8e7'), ('0');
CREATE TABLE after (a bigbase36);
COPY before TO '/tmp/tst' WITH (FORMAT binary);
COPY after FROM '/tmp/tst' WITH (FORMAT binary);
SELECT * FROM after;
ROLLBACK;
