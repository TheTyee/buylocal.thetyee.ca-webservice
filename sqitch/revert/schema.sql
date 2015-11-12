-- Revert buylocal:schema from pg

BEGIN;

DROP SCHEMA buylocal;

COMMIT;
