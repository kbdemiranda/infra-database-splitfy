CREATE TABLE IF NOT EXISTS profiles
(
    id         UUID PRIMARY KEY,
    name       VARCHAR(20) NOT NULL UNIQUE,
    created_at TIMESTAMP   NOT NULL,
    updated_at TIMESTAMP
);

INSERT INTO profiles (id, name, created_at, updated_at)
VALUES (GEN_RANDOM_UUID(), 'VIEWER', NOW(), NOW()),
       (GEN_RANDOM_UUID(), 'EDITOR', NOW(), NOW()),
       (GEN_RANDOM_UUID(), 'ADMIN', NOW(), NOW())
ON CONFLICT (name) DO NOTHING;
