-- Revert buylocal:letters from pg

BEGIN;

DROP TABLE buylocal.letters;

COMMIT;
