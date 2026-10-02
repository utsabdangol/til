-- String functions are basically functions that let me inspect or
-- modify text/string values in SQL.

SELECT *
FROM bakery.customers;



-- LENGTH tells how many characters are in a string.

SELECT LENGTH('sky');

-- can be use it on a column to see the length of each name.

SELECT first_name, LENGTH(first_name)
FROM employee_demographics;


-- UPPER converts all characters in a string to uppercase.

SELECT UPPER('sky');

SELECT first_name, UPPER(first_name)
FROM employee_demographics;



-- LOWER does the opposite of UPPER.
-- It converts all characters to lowercase.

SELECT LOWER('sky');

SELECT first_name, LOWER(first_name)
FROM employee_demographics;


-- TRIM removes whitespace from the beginning and end of a string.
-- It does NOT remove spaces in the middle.

SELECT TRIM('   sky   ');


-- LTRIM removes whitespace from the LEFT side only.

SELECT LTRIM('     I love SQL');



-- RTRIM removes whitespace from the RIGHT side only.

SELECT RTRIM('I love SQL    ');



-- LEFT lets  take a specific number of characters
-- starting from the LEFT side of the string.

SELECT LEFT('Alexander', 4);

-- So this gives the first 4 characters of each first name.

SELECT first_name, LEFT(first_name, 4)
FROM employee_demographics;



-- RIGHT is basically the opposite of LEFT.
-- It takes a specific number of characters starting from the RIGHT side.

SELECT RIGHT('Alexander', 6);

SELECT first_name, RIGHT(first_name, 4)
FROM employee_demographics;



-- SUBSTRING is more flexible than LEFT and RIGHT.
-- can be used to specify straing position and number of characters.
---------------------------------------------------------------

-- SUBSTRING(string, starting_position, number_of_characters)

SELECT SUBSTRING('Alexander', 2, 3);

-- This starts at position 2 and takes 3 characters.

-- A practical example:
--  using SUBSTRING to extract the year from a birth date.

SELECT birth_date, SUBSTRING(birth_date, 1, 4) AS birth_year
FROM employee_demographics;


-- REPLACE lets find a specific character/string
-- and replace it with something else.

-- Here, every 'a' is replaced with 'z'.

SELECT REPLACE(first_name, 'a', 'z')
FROM employee_demographics;


-- LOCATE tells the POSITION of something inside a string.

-- LOCATE(what_I_am_looking_for, where_I_am_searching)

SELECT LOCATE('x', 'Alexander');

-- If the character appears more than once, LOCATE returns
-- the position of the FIRST occurrence.

SELECT LOCATE('e', 'Alexander');

-- use it on a column.

SELECT first_name, LOCATE('a', first_name)
FROM employee_demographics;

-- It doesn't have to be just one character.
-- I can search for a whole string too.

SELECT first_name, LOCATE('Mic', first_name)
FROM employee_demographics;



-- CONCAT combines multiple strings together.

SELECT CONCAT('Alex', 'Freberg');

-- This is useful when I want to combine columns.
-- For example, I can create a full name from first_name and last_name.

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;



-- LENGTH   = tells me how long a string is
-- UPPER    = converts to uppercase
-- LOWER    = converts to lowercase
-- TRIM     = removes whitespace from both sides
-- LTRIM    = removes whitespace from the left
-- RTRIM    = removes whitespace from the right
-- LEFT     = takes characters from the left
-- RIGHT    = takes characters from the right
-- SUBSTRING = takes characters from a specific position
-- REPLACE  = replaces text with other text
-- LOCATE   = finds the position of text
-- CONCAT   = combines strings together
