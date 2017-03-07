CREATE OR REPLACE FUNCTION base36_in(cstring)
RETURNS base36
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION base36_out(base36)
RETURNS cstring
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION base36_recv(internal)
RETURNS base36
AS 'int4recv'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_send(base36)
RETURNS bytea
AS 'int4send'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36(text)
RETURNS base36
AS '$libdir/base36', 'base36_cast_from_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION text(base36)
RETURNS text
AS '$libdir/base36', 'base36_cast_to_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION base36_eq(base36, base36)
RETURNS boolean
AS 'int4eq'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_ne(base36, base36)
RETURNS boolean
AS 'int4ne'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_lt(base36, base36)
RETURNS boolean
AS 'int4lt'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_le(base36, base36)
RETURNS boolean
AS 'int4le'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_gt(base36, base36)
RETURNS boolean
AS 'int4gt'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_ge(base36, base36)
RETURNS boolean
AS 'int4ge'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION base36_cmp(base36, base36)
RETURNS integer
AS 'btint4cmp'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION hash_base36(base36)
RETURNS integer
AS 'hashint4'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_out(bigbase36)
RETURNS cstring
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION bigbase36_recv(internal)
RETURNS bigbase36
AS 'int8recv'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_send(bigbase36)
RETURNS bytea
AS 'int8send'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36(text)
RETURNS bigbase36
AS '$libdir/base36', 'bigbase36_cast_from_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION text(bigbase36)
RETURNS text
AS '$libdir/base36', 'bigbase36_cast_to_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE OR REPLACE FUNCTION bigbase36_eq(bigbase36, bigbase36)
RETURNS boolean
AS 'int8eq'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_ne(bigbase36, bigbase36)
RETURNS boolean
AS 'int8ne'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_lt(bigbase36, bigbase36)
RETURNS boolean
AS 'int8lt'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_le(bigbase36, bigbase36)
RETURNS boolean
AS 'int8le'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_gt(bigbase36, bigbase36)
RETURNS boolean
AS 'int8gt'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_ge(bigbase36, bigbase36)
RETURNS boolean
AS 'int8ge'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION bigbase36_cmp(bigbase36, bigbase36)
RETURNS integer
AS 'btint8cmp'
LANGUAGE internal IMMUTABLE;

CREATE OR REPLACE FUNCTION hash_bigbase36(bigbase36)
RETURNS integer
AS 'hashint8'
LANGUAGE internal IMMUTABLE;
