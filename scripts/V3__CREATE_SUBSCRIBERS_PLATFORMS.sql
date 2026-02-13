CREATE TABLE subscribers_platforms
(
    id              BIGSERIAL PRIMARY KEY,
    subscriber_id   BIGINT      NOT NULL,
    platform_id     BIGINT      NOT NULL,
    subscribed_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    unsubscribed_at TIMESTAMPTZ,
    is_active       BOOLEAN     NOT NULL DEFAULT TRUE,
    created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at      TIMESTAMPTZ,
    deleted_at      TIMESTAMPTZ,

    CONSTRAINT fk_sp_subscriber
        FOREIGN KEY (subscriber_id) REFERENCES subscribers (id),

    CONSTRAINT fk_sp_platform
        FOREIGN KEY (platform_id) REFERENCES platforms (id),

    -- opcional: evita reativar “assinado” sem ter data
    CONSTRAINT chk_sp_unsubscribed_requires_inactive
        CHECK (unsubscribed_at IS NULL OR is_active = FALSE)
);

-- Garante 1 assinatura ativa por subscriber + platform (mesmo com histórico)
CREATE UNIQUE INDEX ux_sp_active_subscription
    ON subscribers_platforms (subscriber_id, platform_id)
    WHERE is_active = TRUE AND deleted_at IS NULL;

-- Índices pra consultas comuns
CREATE INDEX ix_sp_subscriber_id
    ON subscribers_platforms (subscriber_id);

CREATE INDEX ix_sp_platform_id
    ON subscribers_platforms (platform_id);

CREATE INDEX ix_sp_active_by_subscriber
    ON subscribers_platforms (subscriber_id, is_active)
    WHERE deleted_at IS NULL;

CREATE INDEX ix_sp_active_by_platform
    ON subscribers_platforms (platform_id, is_active)
    WHERE deleted_at IS NULL;
