-- Deploy buylocal:letters to pg
-- requires: schema

BEGIN;

SET client_min_messages = 'warning';

CREATE TABLE buylocal.letters (
    id  INT PRIMARY KEY NOT NULL UNIQUE,
    date_created TIMESTAMPTZ NOT NULL,
    first_name  TEXT NOT NULL,
    last_name   TEXT NOT NULL,
    email   TEXT NOT NULL,
    business_name TEXT NOT NULL,
    business_city TEXT NOT NULL,
    business_url  TEXT NULL,
    letter_text   TEXT NOT NULL,
    public_name   TEXT NOT NULL
);

COMMIT;
