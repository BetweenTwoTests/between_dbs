INSERT INTO test.types_numeric_int (`id`, `bool`, `boolean`, `bit_1`, `bit_64`, `smallint_signed`, `smallint_unsigned`, `mediumint_signed`, `mediumint_unsigned`, `int_signed`, `int_unsigned`, `integer_signed`, `integer_unsigned`, `bigint_signed`, `bigint_unsigned`) values (1, -- id
true, -- bool
true, -- boolean
b'00', -- bit_1
b'0000000000000000000000000000000000000000000000000000000000000000', -- bit_64
-32768, -- smallint_signed
0, -- smallint_unsigned
-8388608, -- mediumint_signed
0, -- mediumint_unsigned
-2147483648, -- int_signed
0, -- int_unsigned
-2147483648, -- integer_signed
0, -- integer_unsigned
-9223372036854775808, -- bigint_signed
0 -- bigint_unsigned
);
INSERT INTO test.types_numeric_int (`id`, `bool`, `boolean`, `bit_1`, `bit_64`, `smallint_signed`, `smallint_unsigned`, `mediumint_signed`, `mediumint_unsigned`, `int_signed`, `int_unsigned`, `integer_signed`, `integer_unsigned`, `bigint_signed`, `bigint_unsigned`) values (2, -- id
false, -- bool
false, -- boolean
b'0', -- bit_1
b'0000000000000000000000000000000011111111111111111111111111111111', -- bit_64
-10923, -- smallint_signed
21845, -- smallint_unsigned
-2796203, -- mediumint_signed
5592405, -- mediumint_unsigned
-715827883, -- int_signed
1431655765, -- int_unsigned
-715827883, -- integer_signed
1431655765, -- integer_unsigned
-3074457345618258944, -- bigint_signed
6148914691236516864 -- bigint_unsigned
);
INSERT INTO test.types_numeric_int (`id`, `bool`, `boolean`, `bit_1`, `bit_64`, `smallint_signed`, `smallint_unsigned`, `mediumint_signed`, `mediumint_unsigned`, `int_signed`, `int_unsigned`, `integer_signed`, `integer_unsigned`, `bigint_signed`, `bigint_unsigned`) values (3, -- id
TRUE, -- bool
TRUE, -- boolean
b'1', -- bit_1
b'1111111111111111111111111111111100000000000000000000000000000000', -- bit_64
10922, -- smallint_signed
43690, -- smallint_unsigned
2796202, -- mediumint_signed
11184810, -- mediumint_unsigned
715827882, -- int_signed
2863311530, -- int_unsigned
715827882, -- integer_signed
2863311530, -- integer_unsigned
3074457345618257920, -- bigint_signed
12297829382473033728 -- bigint_unsigned
);
INSERT INTO test.types_numeric_int (`id`, `bool`, `boolean`, `bit_1`, `bit_64`, `smallint_signed`, `smallint_unsigned`, `mediumint_signed`, `mediumint_unsigned`, `int_signed`, `int_unsigned`, `integer_signed`, `integer_unsigned`, `bigint_signed`, `bigint_unsigned`) values (4, -- id
FALSE, -- bool
FALSE, -- boolean
b'01', -- bit_1
b'1111111111111111111111111111111111111111111111111111111111111111', -- bit_64
32767, -- smallint_signed
65535, -- smallint_unsigned
8388607, -- mediumint_signed
16777215, -- mediumint_unsigned
2147483647, -- int_signed
4294967295, -- int_unsigned
2147483647, -- integer_signed
4294967295, -- integer_unsigned
9223372036854775807, -- bigint_signed
18446744073709551615 -- bigint_unsigned
);
