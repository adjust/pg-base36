CREATE FUNCTION base36_in(cstring)
RETURNS base36
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION base36_out(base36)
RETURNS cstring
AS '$libdir/base36'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION base36_recv(internal)
RETURNS base36
AS 'int4recv'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_send(base36)
RETURNS bytea
AS 'int4send'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE TYPE base36 (
	INPUT          = base36_in,
	OUTPUT         = base36_out,
	RECEIVE        = base36_recv,
	SEND           = base36_send,
	LIKE           = integer,
	CATEGORY       = 'N'
);
COMMENT ON TYPE base36 IS 'int written in base36: [0-9a-z]+';

CREATE FUNCTION base36(text)
RETURNS base36
AS '$libdir/base36', 'base36_cast_from_text'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE FUNCTION text(base36)
RETURNS text
AS '$libdir/base36', 'base36_cast_to_text'
LANGUAGE C IMMUTABLE STRICT PARALLEL SAFE;

CREATE CAST (text as base36) WITH FUNCTION base36(text) AS IMPLICIT;
CREATE CAST (base36 as text) WITH FUNCTION text(base36);

CREATE CAST (integer as base36) WITHOUT FUNCTION AS IMPLICIT;
CREATE CAST (base36 as integer) WITHOUT FUNCTION AS IMPLICIT;

CREATE FUNCTION base36_eq(base36, base36)
RETURNS boolean
AS 'int4eq'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_ne(base36, base36)
RETURNS boolean
AS 'int4ne'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_lt(base36, base36)
RETURNS boolean
AS 'int4lt'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_le(base36, base36)
RETURNS boolean
AS 'int4le'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_gt(base36, base36)
RETURNS boolean
AS 'int4gt'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_ge(base36, base36)
RETURNS boolean
AS 'int4ge'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION base36_cmp(base36, base36)
RETURNS integer
AS 'btint4cmp'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE FUNCTION hash_base36(base36)
RETURNS integer
AS 'hashint4'
LANGUAGE internal IMMUTABLE PARALLEL SAFE;

CREATE OPERATOR = (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_eq,
	COMMUTATOR = '=',
	NEGATOR = '<>',
	RESTRICT = eqsel,
	JOIN = eqjoinsel
);
COMMENT ON OPERATOR =(base36, base36) IS 'equals?';

CREATE OPERATOR <> (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_ne,
	COMMUTATOR = '<>',
	NEGATOR = '=',
	RESTRICT = neqsel,
	JOIN = neqjoinsel
);
COMMENT ON OPERATOR <>(base36, base36) IS 'not equals?';

CREATE OPERATOR < (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_lt,
	COMMUTATOR = > ,
	NEGATOR = >= ,
	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <(base36, base36) IS 'less-than';

CREATE OPERATOR <= (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_le,
	COMMUTATOR = >= ,
	NEGATOR = > ,
	RESTRICT = scalarltsel,
	JOIN = scalarltjoinsel
);
COMMENT ON OPERATOR <=(base36, base36) IS 'less-than-or-equal';

CREATE OPERATOR > (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_gt,
	COMMUTATOR = < ,
	NEGATOR = <= ,
	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >(base36, base36) IS 'greater-than';

CREATE OPERATOR >= (
	LEFTARG = base36,
	RIGHTARG = base36,
	PROCEDURE = base36_ge,
	COMMUTATOR = <= ,
	NEGATOR = < ,
	RESTRICT = scalargtsel,
	JOIN = scalargtjoinsel
);
COMMENT ON OPERATOR >=(base36, base36) IS 'greater-than-or-equal';

CREATE OPERATOR CLASS btree_base36_ops
DEFAULT FOR TYPE base36 USING btree
AS
        OPERATOR        1       <  ,
        OPERATOR        2       <= ,
        OPERATOR        3       =  ,
        OPERATOR        4       >= ,
        OPERATOR        5       >  ,
        FUNCTION        1       base36_cmp(base36, base36);

CREATE OPERATOR CLASS hash_base36_ops
    DEFAULT FOR TYPE base36 USING hash AS
        OPERATOR        1       = ,
        FUNCTION        1       hash_base36(base36);
