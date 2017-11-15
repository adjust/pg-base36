
DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
	EXECUTE $E$ ALTER FUNCTION base36_in(cstring) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_out(base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_recv(internal) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_send(base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36(text) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION text(base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_eq(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_ne(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_lt(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_le(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_gt(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_ge(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION base36_cmp(base36, base36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION hash_base36(base36) PARALLEL SAFE $E$;
  END IF;
END;
$$;

DO $$
DECLARE version_num integer;
BEGIN
  SELECT current_setting('server_version_num') INTO STRICT version_num;
  IF version_num > 90600 THEN
	EXECUTE $E$ ALTER FUNCTION bigbase36_in(cstring) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_out(bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_recv(internal) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_send(bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36(text) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION text(bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_eq(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_ne(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_lt(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_le(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_gt(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_ge(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION bigbase36_cmp(bigbase36, bigbase36) PARALLEL SAFE $E$;
	EXECUTE $E$ ALTER FUNCTION hash_bigbase36(bigbase36) PARALLEL SAFE $E$;
  END IF;
END;
$$;

