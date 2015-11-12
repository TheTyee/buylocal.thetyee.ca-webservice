-- Verify buylocal:schema on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('buylocal', 'usage');

ROLLBACK;
