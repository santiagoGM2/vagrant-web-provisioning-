#!/usr/bin/env bash
set -e
export DEBIAN_FRONTEND=noninteractive

echo ">>> Provisioning db: install postgresql"
apt-get update -y
apt-get install -y postgresql postgresql-contrib

systemctl enable postgresql
systemctl start postgresql

PG_USER="taller_user"
PG_PASS="taller_pass"
PG_DB="taller_db"

sudo -u postgres psql <<-EOSQL
DO
\$do\$
BEGIN
   IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = '${PG_USER}') THEN
      CREATE ROLE ${PG_USER} LOGIN PASSWORD '${PG_PASS}';
   END IF;
END
\$do\$;

CREATE DATABASE ${PG_DB} OWNER ${PG_USER};
\connect ${PG_DB};

CREATE TABLE IF NOT EXISTS persons (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT
);

INSERT INTO persons (name, email)
SELECT 'Alice Example', 'alice@example.com'
WHERE NOT EXISTS (SELECT 1 FROM persons);

INSERT INTO persons (name, email)
SELECT 'Bob Example', 'bob@example.com'
WHERE NOT EXISTS (SELECT 1 FROM persons WHERE name='Bob Example');
EOSQL

echo ">>> DB provisioning finalizado"
