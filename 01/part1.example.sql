# Make sure we have a clear table
DROP TABLE IF EXISTS input;
CREATE TABLE input (i int, line varchar(200));

# Insert data
INSERT INTO input VALUES (0, "1abc2");
INSERT INTO input VALUES (1, "pqr3stu8vwx");
INSERT INTO input VALUES (2, "a1b2c3d4e5f");
INSERT INTO input VALUES (3, "treb7uchet");

UPDATE input SET line = REGEXP_REPLACE(line, '[^0-9]', ''); # Remove all non-number characters
UPDATE input SET line = REGEXP_REPLACE(line, '([0-9])', '\\1\\1'); # Double every digit so we can deal with line that just have one digit
UPDATE input SET line = REGEXP_REPLACE(line, '(.).*(.)', '\\1\\2'); # Get our two digit number
SELECT SUM(line) from input; # Create final sum