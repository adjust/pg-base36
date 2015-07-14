CREATE FUNCTION bigbase36_in(cstring)
RETURNS bigbase36
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION bigbase36_out(bigbase36)
RETURNS cstring
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION bigbase36_recv(internal)
RETURNS bigbase36
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION bigbase36_send(bigbase36)
RETURNS bytea
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT;

CREATE TYPE bigbase36 (
	INPUT          = bigbase36_in,
	OUTPUT         = bigbase36_out,
	RECEIVE        = bigbase36_recv,
	SEND           = bigbase36_send,
	LIKE           = bigint,
	CATEGORY       = 'N'
);
COMMENT ON TYPE bigbase36 IS 'bigint written in bigbase36: [0-9a-z]+';

CREATE FUNCTION bigbase36(text)
RETURNS bigbase36
AS '$libdir/base36', 'bigbase36_cast_from_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE FUNCTION text(bigbase36)
RETURNS text
AS '$libdir/base36', 'bigbase36_cast_to_text'
LANGUAGE C IMMUTABLE STRICT;

CREATE CAST (text as bigbase36) WITH FUNCTION bigbase36(text) AS IMPLICIT;
CREATE CAST (bigbase36 as text) WITH FUNCTION text(bigbase36);

CREATE CAST (bigint as bigbase36) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (bigbase36 as bigint) WITHOUT FUNCTION AS IMPLICIT;

CREATE FUNCTION bigbase36_eq(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8eq';

CREATE FUNCTION bigbase36_ne(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8ne';

CREATE FUNCTION bigbase36_lt(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8lt';

CREATE FUNCTION bigbase36_le(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8le';

CREATE FUNCTION bigbase36_gt(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8gt';

CREATE FUNCTION bigbase36_ge(bigbase36, bigbase36)
RETURNS boolean LANGUAGE internal IMMUTABLE AS 'int8ge';

CREATE FUNCTION bigbase36_cmp(bigbase36, bigbase36)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'btint8cmp';

CREATE FUNCTION hash_bigbase36(bigbase36)
RETURNS integer LANGUAGE internal IMMUTABLE AS 'hashint8';

CREATE OPERATOR = (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_eq,
	COMMUTATOR = '=',
	NEGATOR = '<>',
	RESTRICT = eqsel,
	JOIN = eqjoinsel
);
COMMENT ON OPERATOR =(bigbase36, bigbase36) IS 'equals?';

CREATE OPERATOR <> (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_ne,
	COMMUTATOR = '<>',
	NEGATOR = '=',
	RESTRICT = neqsel,
	JOIN = neqjoinsel
);
COMMENT ON OPERATOR <>(bigbase36, bigbase36) IS 'not equals?';

CREATE OPERATOR < (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_lt,
	COMMUTATOR = > ,
	NEGATOR = >= ,
   	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <(bigbase36, bigbase36) IS 'less-than';

CREATE OPERATOR <= (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_le,
	COMMUTATOR = >= ,
	NEGATOR = > ,
   	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <=(bigbase36, bigbase36) IS 'less-than-or-equal';

CREATE OPERATOR > (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_gt,
	COMMUTATOR = < ,
	NEGATOR = <= ,
   	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >(bigbase36, bigbase36) IS 'greater-than';

CREATE OPERATOR >= (
	LEFTARG = bigbase36,
	RIGHTARG = bigbase36,
	PROCEDURE = bigbase36_ge,
	COMMUTATOR = <= ,
	NEGATOR = < ,
   	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >=(bigbase36, bigbase36) IS 'greater-than-or-equal';

CREATE OPERATOR CLASS btree_bigbase36_ops
DEFAULT FOR TYPE bigbase36 USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       bigbase36_cmp(bigbase36, bigbase36);

CREATE OPERATOR CLASS hash_bigbase36_ops
    DEFAULT FOR TYPE bigbase36 USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_bigbase36(bigbase36);
