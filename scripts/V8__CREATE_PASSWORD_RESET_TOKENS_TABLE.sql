CREATE TABLE IF NOT EXISTS PASSWORD_RESET_TOKENS
(
    id           BIGSERIAL PRIMARY KEY,
    user_id      UUID        NOT NULL REFERENCES USERS (ID),
    token_hash   VARCHAR(64) NOT NULL UNIQUE,
    expires_at   TIMESTAMP   NOT NULL,
    used_at      TIMESTAMP   NULL,
    requested_ip VARCHAR(64) NULL,
    created_at   TIMESTAMP   NOT NULL,
    updated_at   TIMESTAMP   NULL,
    deleted_at   TIMESTAMP   NULL
);

CREATE INDEX IF NOT EXISTS idx_password_reset_tokens_user_id
    ON password_reset_tokens (user_id);

CREATE INDEX IF NOT EXISTS idx_password_reset_tokens_expires_at
    ON password_reset_tokens (expires_at);