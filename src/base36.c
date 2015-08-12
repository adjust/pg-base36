#include "base36.h"
PG_MODULE_MAGIC;

#define BASE36_LENGTH      6

static base36 base36_powers[BASE36_LENGTH] =
{
	1,
	36,
	1296,
	46656,
	1679616,
	60466176
};

static inline
base36 base36_from_str(const char *str)
{
	int i = 0, d = 0, n = strlen(str);
	base36 c = 0;
	bool neg_sign = false;

	if (n == 0){
			OUTOFRANGE_ERROR(str, "base36");
	}
	else if(str[0] == '-')
	{
	  if (n-1 > BASE36_LENGTH)
			OUTOFRANGE_ERROR(str, "base36");
		neg_sign = true;
		i = 1;
	}
	else if (n > BASE36_LENGTH)
	{
		OUTOFRANGE_ERROR(str, "base36");
	}

	for(;i<n; i++) {
		if( str[i] >= '0' && str[i] <= '9' )
			d = str[i] - '0';
		else if ( str[i] >= 'A' && str[i] <= 'Z' )
			d = 10 + str[i] - 'A';
		else if ( str[i] >= 'a' && str[i] <= 'z' )
			d = 10 + str[i] - 'a';
		else
			ereport(ERROR, (
				errcode(ERRCODE_SYNTAX_ERROR),
				errmsg("value \"%c\" is not a valid digit for type base36", str[i])
				)
		);

		c += d * base36_powers[n-i-1];

		if ( c < 0 )
			OUTOFRANGE_ERROR(str, "base36");
	}
	if (neg_sign)
		return 0 - c;

	return c;
}

static inline
char *base36_to_str(base36 c)
{
	int i, d, p = 0;
	base36 m = abs(c);
	bool discard = true;

	char *str = palloc0((BASE36_LENGTH + 2) * sizeof(char));
	if (c < 0 )
		str[p++] = '-';

	for(i=BASE36_LENGTH-1; i>=0; i--)
	{
		d = m / base36_powers[i];
		m = m - base36_powers[i] * d;

		discard = discard && (d == 0 && i >0);

		if( !discard )
			str[p++] = base36_digits[d];
	}

	return str;
}


PG_FUNCTION_INFO_V1(base36_in);
Datum
base36_in(PG_FUNCTION_ARGS)
{
	char *str = PG_GETARG_CSTRING(0);
	PG_RETURN_INT32(base36_from_str(str));
}

PG_FUNCTION_INFO_V1(base36_out);
Datum
base36_out(PG_FUNCTION_ARGS)
{
	base36 c = PG_GETARG_INT32(0);
	PG_RETURN_CSTRING(base36_to_str(c));
}

PG_FUNCTION_INFO_V1(base36_cast_from_text);
Datum
base36_cast_from_text(PG_FUNCTION_ARGS)
{
	text *txt = PG_GETARG_TEXT_P(0);
	char *str = DatumGetCString(DirectFunctionCall1(textout, PointerGetDatum(txt)));
	PG_RETURN_INT32(base36_from_str(str));
}

PG_FUNCTION_INFO_V1(base36_cast_to_text);
Datum
base36_cast_to_text(PG_FUNCTION_ARGS)
{
	base36 c  = PG_GETARG_INT32(0);
	text *out = (text *)DirectFunctionCall1(textin, PointerGetDatum(base36_to_str(c)));
	PG_RETURN_TEXT_P(out);
}