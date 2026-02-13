CREATE TABLE IF NOT EXISTS profiles
(
    id         UUID                         NOT NULL,
    name       VARCHAR(20)                  NOT NULL UNIQUE,
    created_at TIMESTAMP WITHOUT TIME ZONE  NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE,

    CONSTRAINT pk_profiles PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS users
(
    id         UUID                         NOT NULL,
    name       VARCHAR(255)                 NOT NULL,
    email      VARCHAR(255)                 NOT NULL UNIQUE,
    password   VARCHAR(255)                 NOT NULL,
    profile_id UUID,
    is_enabled BOOLEAN                      NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP WITHOUT TIME ZONE  NOT NULL,
    updated_at TIMESTAMP WITHOUT TIME ZONE,
    deleted_at TIMESTAMP WITHOUT TIME ZONE,

    CONSTRAINT pk_users PRIMARY KEY (id),

    CONSTRAINT fk_users_profile
        FOREIGN KEY (profile_id)
            REFERENCES profiles (id)
            ON DELETE SET NULL
);
