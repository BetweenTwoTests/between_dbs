# --
# This R script creates SQL files to mysql_5_7/mysql_5_7/INSERTS*.sql
# For schema defined by mysql_5_7/DDL/mysql_5_7_schema_ddl.sql
#
# For *_df variables:
#  string column cell values  `null` without `'` wrapper if that cell value is intended to be inserted as SQL null
#  string column cell values for non-null have `'` wrapper around the cell value
#
# ---

# Tested on R version 4.1.0 and package versions:
library(dplyr) # v 1.0.7
library(stringr) # v 1.4.0
library(readr) # v 2.0.0

leftEscapeString <- "`"
rightEscapeString <- "`"

make_insert_base_sql_string <- function(df, table_name, leftEscapeString, rightEscapeString) {
  if (ncol(df) == 0) 
    return("")
  
  colNamesSqlString <- str_c(colnames(df), collapse = str_glue("{rightEscapeString}, {leftEscapeString}"))
  as.character(
    str_glue("INSERT INTO {table_name} ({leftEscapeString}{colNamesSqlString}{rightEscapeString}) values ")
  )
}
make_insert_sql <- function(df, insert_base_sql) {
  c(
    #"truncate TABLE test.types_numeric_float;",
    str_c(
      insert_base_sql, 
      apply(
        df, 1, 
        function(x) {
          str_c("(", 
                str_c(sapply(1:length(x), function(i) {
                  str_c(str_c(x[i], ifelse(i != length(x), ", -- ", " -- "), names(x)[i]), "\n", collapse = "")
                }),collapse=""), 
                ");",collapse = "")
        }
      )
    )
  )
}
make_random_string <- function(charLengths, charLimit, stringGenerator) {
  stopifnot(is.vector(charLengths, "numeric"))
  
  # stringGenerator is a function that takes # as character length, e.g. function(i) strrep("a", i)
  # also must be efficient enough to generate large charlength
  stopifnot(is.character(stringGenerator(100)) && length(stringGenerator(100)) == 1)
  
  sapply(charLengths, function(i) { if (i > charLimit) "null" else str_glue("'{stringGenerator(i)}'") })
}

# char (test.types_char) ----
char_df <- tibble(
  id = NA_integer_,
  char_0      = make_random_string(1:255,   0, function(x) strrep("a", x)),
  char_1      = make_random_string(1:255,   1, function(x) strrep("a", x)), 
  char_255    = make_random_string(1:255, 255, function(x) strrep("a", x)), 
  varchar_0   = make_random_string(1:255,   0, function(x) strrep("a", x)), 
  varchar_1   = make_random_string(1:255,   1, function(x) strrep("a", x)), 
  varchar_255 = make_random_string(1:255, 255, function(x) strrep("a", x)), 
) %>% 
  mutate(id = row_number())

char_sql <- make_insert_sql(
  char_df, 
  make_insert_base_sql_string(char_df, "test.types_char", leftEscapeString, rightEscapeString)
)

fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_char_insert.sql")
writeLines(char_sql, fileConn)    
close(fileConn)

# Strip out `null` and `'` wrap around cell values
char_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & str_detect(x, "[\']")  , str_remove_all(x, "[\']"), x) })) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_char_insert.csv")

rm(list = c("char_df", "char_sql", "fileConn"))
# ----
# varchar_max (test.types_varchar_max) ---
varchar_max_df <- tibble(
  varchar_65533 = make_random_string(round(seq(1, 65533, length.out = 20)), 65533, function(x) strrep("a", x)),
)

varchar_max_sql <- make_insert_sql(
  varchar_max_df, 
  make_insert_base_sql_string(varchar_max_df, "test.types_varchar_max", leftEscapeString, rightEscapeString)
)

fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_varchar_max_insert.sql")    
writeLines(varchar_max_sql, fileConn)    
close(fileConn)

# Strip out `null` and `'` wrap around cell values
varchar_max_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & str_detect(x, "[\']")  , str_remove_all(x, "[\']"), x) })) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_varchar_max_insert.csv")

rm(list = c("varchar_max_df", "varchar_max_sql", "fileConn"))
# ----
# types_text (test.types_text) ---
text_df <- tibble(
  id = NA_integer_,
  tinytext   = make_random_string(1,        255, function(x) "tinytext charlen limit is 255"),
  mediumtext = make_random_string(1,   16777215, function(x) "mediumtext charlen limit is 16777215"),
  longtext   = make_random_string(1, 4294967295, function(x) "longtext charlen limit is 4294967295"),
  text       = make_random_string(1,      65535, function(x) "text charlen limit is 65535"),
) %>% 
  mutate(id = row_number())

text_sql <- make_insert_sql(
  text_df, 
  make_insert_base_sql_string(text_df, "test.types_text", leftEscapeString, rightEscapeString)
)

fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_text_insert.sql")    
writeLines(text_sql, fileConn)    
close(fileConn)

# Strip out `null` and `'` wrap around cell values
text_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & str_detect(x, "[\']")  , str_remove_all(x, "[\']"), x) })) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_text_insert.csv")

rm(list = c("text_df", "text_sql", "fileConn"))
# types_text (test.types_date) ---
date_df <- tibble(
  id           = c(1, 2),
  date         = c("'1000-01-01'"                 , "'9999-12-31'"                ),
  datetime     = c("'1000-01-01 00:00:00'"        , "'9999-12-31 23:59:59'"       ),
  datetime_6   = c("'1000-01-01 00:00:00.000000'" , "'9999-12-31 23:59:59.999999'"),
  timestamp    = c("'1970-01-01 00:00:01'"        , "'2038-01-19 03:14:07'"       ),
  timestamp_6  = c("'1970-01-01 00:00:01.000000'" , "'2038-01-19 03:14:07.999999'"),
  time         = c("'-838:59:59'"                 , "'838:59:59'"                 ),
  time_6       = c("'-838:59:59.000000'"          , "'838:59:59.000000'"          ),
  year_default = c("'0000'"                       , "'2155'"                      ),
   # year_2    = , -- Not supported in some versions of MYSQL 5.7
  year_4       = c("'0000'"                       , "'2155'")
)

date_sql <- make_insert_sql(
  date_df, 
  make_insert_base_sql_string(date_df, "test.types_date", leftEscapeString, rightEscapeString)
)

fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_date_insert.sql")    
writeLines(date_sql, fileConn)    
close(fileConn)

# Strip out `null` and `'` wrap around cell values
date_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & str_detect(x, "[\']")  , str_remove_all(x, "[\']"), x) })) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_date_insert.csv")

rm(list = c("date_df", "date_sql", "fileConn"))
# ----
# int (test.types_numeric_int) ----
int_df <- tibble(
  id = NA_integer_,
  bool = c("true","false","TRUE","FALSE"),
  boolean = c("true","false","TRUE","FALSE"), # equivalent to bool
  bit_1 = c("b'00'", "b'0'", "b'1'", "b'01'"), # == c(0, 0, 1, 1)
  bit_64 = c(
    "b'0000000000000000000000000000000000000000000000000000000000000000'", # == 0
    "b'0000000000000000000000000000000011111111111111111111111111111111'", # == 4294967295
    "b'1111111111111111111111111111111100000000000000000000000000000000'", # == 18446744069414584320
    "b'1111111111111111111111111111111111111111111111111111111111111111'"  # == 18446744073709551615
    ),
  # min-to-max range split into 4
  smallint_signed    = c(              "-32768",               "-10923",                "10922",                "32767"),              
  smallint_unsigned  = c(                   "0",                "21845",                "43690",                "65535"), 
  mediumint_signed   = c(            "-8388608",             "-2796203",              "2796202",              "8388607"),
  mediumint_unsigned = c(                   "0",              "5592405",             "11184810",             "16777215"),
  int_signed         = c(         "-2147483648",           "-715827883",            "715827882",           "2147483647"), 
  int_unsigned       = c(                   "0",           "1431655765",           "2863311530",           "4294967295"),
  integer_signed     = c(         "-2147483648",           "-715827883",            "715827882",           "2147483647"), 
  integer_unsigned   = c(                   "0",           "1431655765",           "2863311530",           "4294967295"),
  bigint_signed      = c("-9223372036854775808", "-3074457345618258944",  "3074457345618257920",  "9223372036854775807"),
  bigint_unsigned    = c(                   "0",  "6148914691236516864", "12297829382473033728", "18446744073709551615")
) %>% 
  mutate(id = row_number())

int_sql <- make_insert_sql(
  int_df, 
  make_insert_base_sql_string(int_df, "test.types_numeric_int", leftEscapeString, rightEscapeString)
)
  
fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_numeric_int_insert.sql")    
writeLines(int_sql, fileConn)    
close(fileConn)

# Strip out `null`. Don't remove `'` because of binary bit values
int_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_numeric_int_insert.csv")

rm(list = c("int_df", "int_sql", "fileConn"))
# ----
# float (test.types_numeric_float) ----
max_m <- 48
max_d <- 24

# space is added to make decimal points easier to view in SQL
makeValues <- function(max_m, m, d) {
  smallValues <- 
    sapply(
      max_m:0, 
      function(i) { 
        str_c(".", str_c(rep_len("4", i), collapse = ""), "4",collapse = "") %>% 
          str_pad(max_m+2, "right") %>% 
          str_pad(max_m*2+2, "left")
      }
    )
  zeroValues <-
    c(
      ".0" %>% str_pad(max_m+2, "right") %>% str_pad(max_m*2+2, "left"),
      "0" %>% str_pad(max_m+3, "right") %>% str_pad(max_m*2+2, "left"),
      "0.0" %>% str_pad(max_m+2+1, "right") %>% str_pad(max_m*2+2, "left")
    )
  largeValues <-
    sapply(
      1:max_m, 
      function(i) { 
        if (!is.null(m) && !is.null(d)) {
          ifelse(
            m-d < i,
            "null" %>% str_pad(max_m, "left") %>% str_pad(max_m*2+2, "right"),
            str_c(rep_len("4", i), collapse = "") %>% str_pad(max_m, "left") %>% str_pad(max_m*2+2, "right")
          )
        } else {
          str_c(rep_len("4", i), collapse = "") %>% str_pad(max_m, "left") %>% str_pad(max_m*2+2, "right")
        }
      }
    )
  largeValuesWithDecimals <- 
    sapply(
      max_m:0, 
      function(i) { 
        if (!is.null(m) && !is.null(d)) {
          ifelse(m-d >= i, # m-d > max(max_m-i,0) &&  
                 str_c(
                   str_c(rep_len("4", i), collapse = "") %>% str_pad(max_m, "left"), 
                   ".", 
                   "4", str_c(rep_len("4", max(max_m-i,0)), collapse = ""), 
                   collapse = ""
                 ) %>% str_pad(max_m*2+2, "right"),
                 "null" %>% str_pad(max_m, "left") %>% str_pad(max_m*2+2, "right")
          ) 
        } else {
          str_c(
            str_c(rep_len("4", i), collapse = "") %>% str_pad(max_m, "left"), 
            ".", 
            "4", str_c(rep_len("4", max(max_m-i,0)), collapse = ""), 
            collapse = ""
          ) %>% str_pad(max_m*2+2, "right")  
        }
      }
    )
  c(smallValues, zeroValues, largeValues, largeValuesWithDecimals)
}

float_df <- tibble(
  id = NA_integer_,
  float_string =  str_c("'", makeValues(max_m, NULL, NULL), "'", paste = ""),
  float_default = makeValues(max_m, 38, 0), # ? is it 38, 0, #91
  float_10m_2d = makeValues(max_m, 10, 2), 
  float_24m_24d = makeValues(max_m, 24, 24), 
  float_38m_24d = makeValues(max_m, 38, 24), 
  float_39m_24d = makeValues(max_m, 39, 24), 
  float_48m_24d = makeValues(max_m, 48, 24)
  ) %>% 
  mutate(id = row_number())
float_sql <- make_insert_sql(
  float_df, 
  make_insert_base_sql_string(float_df, "test.types_numeric_float", leftEscapeString, rightEscapeString)
)

fileConn <- file("mysql_5_7/INSERTS/mysql_5_7_types_numeric_float_insert.sql")    
writeLines(float_sql, fileConn)    
close(fileConn)

# Strip out `null`, `'` wrap around cell values, and remove extra spaces
float_df %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & x == "null", "", x) })) %>% 
  mutate(across(.fns = function(x) { ifelse(is.character(x) & str_detect(x, "[\']")  , str_remove_all(x, "[\']"), x) })) %>% 
  mutate(across(.fns = str_trim, side="both")) %>% 
  write_csv("mysql_5_7/INSERTS/mysql_5_7_types_numeric_float_insert.csv")

rm(list = c("float_df", "float_sql", "fileConn", "max_m", "max_d", "makeValues"))
# ----



