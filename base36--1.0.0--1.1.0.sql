UPDATE pg_catalog.pg_operator 
	SET 
		oprcanmerge = true,
		oprcanhash  = true
WHERE oprname = '=' AND oprleft = 'base36'::regtype AND oprright = 'base36'::regtype;

UPDATE pg_catalog.pg_operator 
	SET 
		oprcanmerge = true,
		oprcanhash  = true
WHERE oprname = '=' AND oprleft = 'bigbase36'::regtype AND oprright = 'bigbase36'::regtype;