CREATE TABLE test.types_char (
	id int not null primary key,
	char_0 char(0) NULL,
	char_1 char(1) NULL,
	char_255 char(255) NULL,
	varchar_0 varchar(0) NULL,
	varchar_1 varchar(1) NULL,
	varchar_255 varchar(255) NULL
) 
ENGINE=InnoDB 
DEFAULT CHARSET=latin1;


CREATE TABLE test.types_varchar_max (
	varchar_65533 varchar(65533) NOT NULL -- 65535 is max in theory, but row has total limit including overhead
)
ENGINE=InnoDB
DEFAULT CHARSET=latin1;


CREATE TABLE test.types_text (
	id int not null primary key,
	`tinytext` TINYTEXT NULL, -- 255 char max
	`mediumtext` MEDIUMTEXT NULL, -- 16777215 char max 
	`longtext` LONGTEXT NULL, -- 4294967295 characters max
	`text` text NULL -- 65535 char  max
)
ENGINE=InnoDB
DEFAULT CHARSET=latin1;

CREATE TABLE test.types_date (
	id int not null primary key,
	`date` DATE NULL,
	`datetime` DATETIME NULL,
	`datetime_6` DATETIME(6) NULL,
	`timestamp` TIMESTAMP NULL,
	`timestamp_6` TIMESTAMP(6) NULL,
	`time` TIME NULL,
	`time_6` TIME(6) NULL,
	`year_default` YEAR NULL,
-- 	`year_2` YEAR(2) NULL, -- Not supported in MySQL 5.7
	`year_4` YEAR(4) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=latin1;


CREATE TABLE test.types_numeric_int (
	id int not null primary key,
	`bool` BOOL NULL,
	`boolean` BOOLEAN NULL, -- equivalent to bool
	bit_1 bit(1) NULL,
	bit_64 bit(64) NULL,
	-- smallint(size), mediumint(size), int(size), bigint(size) -> size parameter specifies the maximum display width (which is 255)
	`smallint_signed` smallint NULL, -- Signed range is from -32768 to 32767
	`smallint_unsigned` smallint unsigned NULL, -- Unsigned range is from 0 to 65535
	`mediumint_signed` mediumint NULL, -- Signed range is from -8388608 to 8388607
	`mediumint_unsigned` mediumint unsigned NULL, -- Unsigned range is from 0 to 16777215
	`int_signed` int NULL, -- Signed range is from -2147483648 to 2147483647
	`int_unsigned` int unsigned NULL, -- Unsigned range is from 0 to 4294967295
	`integer_signed` int NULL, -- equivalent to int_signed
	`integer_unsigned` int unsigned NULL, -- equivalent to int_unsigned
	`bigint_signed` bigint NULL, -- -9223372036854775808 to 9223372036854775807
	`bigint_unsigned` bigint unsigned NULL -- 0 to 18446744073709551615
	)
ENGINE=InnoDB
DEFAULT CHARSET=latin1;


-- Ranges are 3.402823466E+38 to 1.175494351E-38, 0 and 1.175494351E-38 to 3.402823466E+38. 
-- If the number of Decimals is not set or <= 24 it is a single-precision floating point number
CREATE TABLE test.types_numeric_float (
	id int not null primary key,
	float_string text NULL, -- string version
	float_default float NULL, -- default float(?,?), 38 precision
	float_10m_2d float(10,2) NULL,
	float_24m_24d float(24,24) NULL, -- Decimal precision can go to 24 places for a FLOAT.
	float_38m_24d float(38,24) NULL,
	float_39m_24d float(39,24) NULL,
	float_48m_24d float(48,24) NULL
)
ENGINE=InnoDB
DEFAULT CHARSET=latin1;








