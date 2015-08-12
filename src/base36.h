#ifndef BASE36_H
#define BASE36_H

#include "postgres.h"
#include "utils/builtins.h"
#include "libpq/pqformat.h"

typedef int32 base36;
typedef int64 bigbase36;

static int base36_digits[36] =
{
  '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
  'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
  'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
  'u', 'v', 'w', 'x', 'y', 'z'
};

Datum base36_in(PG_FUNCTION_ARGS);
Datum base36_out(PG_FUNCTION_ARGS);
Datum base36_cast_to_text(PG_FUNCTION_ARGS);
Datum base36_cast_from_text(PG_FUNCTION_ARGS);
Datum base36_cast_to_bigint(PG_FUNCTION_ARGS);
Datum base36_cast_from_bigint(PG_FUNCTION_ARGS);

Datum bigbase36_in(PG_FUNCTION_ARGS);
Datum bigbase36_out(PG_FUNCTION_ARGS);
Datum bigbase36_cast_to_text(PG_FUNCTION_ARGS);
Datum bigbase36_cast_from_text(PG_FUNCTION_ARGS);
Datum bigbase36_cast_to_bigint(PG_FUNCTION_ARGS);
Datum bigbase36_cast_from_bigint(PG_FUNCTION_ARGS);
#define OUTOFRANGE_ERROR(_str, _typ)                            \
  do {                                                          \
    ereport(ERROR,                                              \
      (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),             \
        errmsg("value \"%s\" is out of range for type %s",      \
          _str, _typ)));                                        \
  } while(0)                                                    \


#endif // BASE36_H