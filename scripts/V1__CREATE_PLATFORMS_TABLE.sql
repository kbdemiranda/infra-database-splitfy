CREATE TABLE IF NOT EXISTS platforms
(
    id              BIGSERIAL,
    platform_token  UUID           NOT NULL,
    name            VARCHAR(50)    NOT NULL,
    price           NUMERIC(12, 2) NOT NULL,
    currency        VARCHAR(3)     NOT NULL DEFAULT 'BRL',
    url             VARCHAR(50),
    service_type    VARCHAR(50)    NOT NULL,

    total_slots     INTEGER        NOT NULL,
    available_slots INTEGER        NOT NULL,

    created_at      TIMESTAMP      NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMP      NULL,
    deleted_at      TIMESTAMP      NULL,

    billing_cycle   VARCHAR(50)    NOT NULL DEFAULT 'MONTHLY',
    billing_date    CHAR(7)        NULL,

    CONSTRAINT pk_platform PRIMARY KEY (id)

);

CREATE INDEX idx_platform_token ON platforms (platform_token);
CREATE INDEX idx_platform_service_type ON platforms (service_type);
CREATE INDEX idx_platform_deleted_at ON platforms (deleted_at);
