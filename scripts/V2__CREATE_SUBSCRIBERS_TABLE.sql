CREATE TABLE IF NOT EXISTS subscribers
(
    id               BIGSERIAL,
    subscriber_token UUID         NOT NULL,
    name             VARCHAR(255) NOT NULL,
    email            VARCHAR(255) NOT NULL,
    created_at       TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at       TIMESTAMP    NULL,
    deleted_at       TIMESTAMP    NULL,

    CONSTRAINT pk_subscriber PRIMARY KEY (id)
);

CREATE INDEX idx_subscribers_token ON subscribers (subscriber_token);
CREATE INDEX idx_subscribers_deleted_at ON subscribers (deleted_at);