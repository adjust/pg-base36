#include "base36.h"

#define BIGBASE36_LENGTH      13


static bigbase36 bigbase36_powers[BIGBASE36_LENGTH] =
{
	1ULL,
	36ULL,
	1296ULL,
	46656ULL,
	1679616ULL,
	60466176ULL,
	2176782336ULL,
	78364164096ULL,
	2821109907456ULL,
	101559956668416ULL,
	3656158440062976ULL,
	131621703842267136ULL,
	4738381338321616896ULL
};

static inline
bigbase36 bigbase36_from_str(const char *str)
{
	int i = 0, d = 0, n = strlen(str);
	bigbase36 c = 0;
	bool neg_sign = false;

	if (n == 0){
			OUTOFRANGE_ERROR(str, "bigbase36");
	}
	else if(str[0] == '-')
	{
	  if (n-1 > BIGBASE36_LENGTH)
			OUTOFRANGE_ERROR(str, "bigbase36");

		neg_sign = true;
		i = 1;
	}
	else if (n > BIGBASE36_LENGTH)
	{
		OUTOFRANGE_ERROR(str, "bigbase36");
	}

	for(; i<n; i++) {
		if( str[i] >= '0' && str[i] <= '9' )
			d = str[i] - '0';
		else if ( str[i] >= 'A' && str[i] <= 'Z' )
			d = 10 + str[i] - 'A';
		else if ( str[i] >= 'a' && str[i] <= 'z' )
			d = 10 + str[i] - 'a';
		else
			ereport(ERROR, (
				errcode(ERRCODE_SYNTAX_ERROR),
				errmsg("value \"%c\" is not a valid digit for type bigbase36", str[i])
				)
		);

		c += d * bigbase36_powers[n-i-1];

		if ( c < 0 )
			OUTOFRANGE_ERROR(str, "bigbase36");
	}
	if (neg_sign)
		return 0 - c;

	return c;
}

static inline
char *bigbase36_to_str(bigbase36 c)
{
	int i, d, p = 0;
	bigbase36 m = labs(c);
	bool discard = true;
	char *str = palloc0((BIGBASE36_LENGTH + 2) * sizeof(char));
	if (c < 0 )
		str[p++] = '-';

	for(i=BIGBASE36_LENGTH-1; i>=0; i--)
	{
		d = m / bigbase36_powers[i];
		m = m - bigbase36_powers[i] * d;

		discard = discard && (d == 0 && i >0);

		if( !discard )
			str[p++] = base36_digits[d];
	}

	return str;
}


PG_FUNCTION_INFO_V1(bigbase36_in);
Datum
bigbase36_in(PG_FUNCTION_ARGS)
{
	char *str = PG_GETARG_CSTRING(0);
	PG_RETURN_INT64(bigbase36_from_str(str));
}

PG_FUNCTION_INFO_V1(bigbase36_out);
Datum
bigbase36_out(PG_FUNCTION_ARGS)
{
	bigbase36 c = PG_GETARG_INT64(0);
	PG_RETURN_CSTRING(bigbase36_to_str(c));
}

PG_FUNCTION_INFO_V1(bigbase36_cast_from_text);
Datum
bigbase36_cast_from_text(PG_FUNCTION_ARGS)
{
	text *txt = PG_GETARG_TEXT_P(0);
	char *str = DatumGetCString(DirectFunctionCall1(textout, PointerGetDatum(txt)));
	PG_RETURN_INT64(bigbase36_from_str(str));
}

PG_FUNCTION_INFO_V1(bigbase36_cast_to_text);
Datum
bigbase36_cast_to_text(PG_FUNCTION_ARGS)
{
	bigbase36 c  = PG_GETARG_INT64(0);
	text *out = (text *)DirectFunctionCall1(textin, PointerGetDatum(bigbase36_to_str(c)));
	PG_RETURN_TEXT_P(out);
}