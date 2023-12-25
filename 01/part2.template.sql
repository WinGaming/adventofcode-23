# Make sure we have a clear table
DROP TABLE IF EXISTS input;
CREATE TABLE input (i int, line varchar(200));

# Insert data
%%DATA%%

# Translating spelled out digits
UPDATE input SET line = REGEXP_REPLACE(line, 'one', 'one1one');
UPDATE input SET line = REGEXP_REPLACE(line, 'two', 'two2two');
UPDATE input SET line = REGEXP_REPLACE(line, 'three', 'three3three');
UPDATE input SET line = REGEXP_REPLACE(line, 'four', 'four4four');
UPDATE input SET line = REGEXP_REPLACE(line, 'five', 'five5five');
UPDATE input SET line = REGEXP_REPLACE(line, 'six', 'six6six');
UPDATE input SET line = REGEXP_REPLACE(line, 'seven', 'seven7seven');
UPDATE input SET line = REGEXP_REPLACE(line, 'eight', 'eight8eight');
UPDATE input SET line = REGEXP_REPLACE(line, 'nine', 'nine9nine');

UPDATE input SET line = REGEXP_REPLACE(line, '[^0-9]', ''); # Remove all non-number characters
UPDATE input SET line = REGEXP_REPLACE(line, '([0-9])', '\\1\\1'); # Double every digit so we can deal with line that just have one digit
UPDATE input SET line = REGEXP_REPLACE(line, '(.).*(.)', '\\1\\2'); # Get our two digit number
SELECT SUM(line) from input; # Create final sum