-- Verify buylocal:letters on pg

BEGIN;

SELECT id, timestamp, date_created, first_name, last_name, email, business_name, business_city, business_url, letter_text, public_name
  FROM buylocal.letters
 WHERE FALSE; 

ROLLBACK;
