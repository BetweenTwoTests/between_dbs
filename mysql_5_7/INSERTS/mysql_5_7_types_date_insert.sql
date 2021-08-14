INSERT INTO test.types_date (`id`, `date`, `datetime`, `datetime_6`, `timestamp`, `timestamp_6`, `time`, `time_6`, `year_default`, `year_4`) values (1, -- id
'1000-01-01', -- date
'1000-01-01 00:00:00', -- datetime
'1000-01-01 00:00:00.000000', -- datetime_6
'1970-01-01 00:00:01', -- timestamp
'1970-01-01 00:00:01.000000', -- timestamp_6
'-838:59:59', -- time
'-838:59:59.000000', -- time_6
'0000', -- year_default
'0000' -- year_4
);
INSERT INTO test.types_date (`id`, `date`, `datetime`, `datetime_6`, `timestamp`, `timestamp_6`, `time`, `time_6`, `year_default`, `year_4`) values (2, -- id
'9999-12-31', -- date
'9999-12-31 23:59:59', -- datetime
'9999-12-31 23:59:59.999999', -- datetime_6
'2038-01-19 03:14:07', -- timestamp
'2038-01-19 03:14:07.999999', -- timestamp_6
'838:59:59', -- time
'838:59:59.000000', -- time_6
'2155', -- year_default
'2155' -- year_4
);
