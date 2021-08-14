INSERT INTO test.types_text (`id`, `tinytext`, `mediumtext`, `longtext`, `text`) values (1, -- id
'tinytext charlen limit is 255', -- tinytext
'mediumtext charlen limit is 16777215', -- mediumtext
'longtext charlen limit is 4294967295', -- longtext
'text charlen limit is 65535' -- text
);
