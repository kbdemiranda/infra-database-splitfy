CREATE TABLE payment_confirmations
(
    id                 BIGSERIAL,
    subscriber_id      BIGINT       NOT NULL,
    platform_id        BIGINT       NOT NULL,
    reference_month    VARCHAR(7)   NOT NULL,
    status             VARCHAR(20)  NOT NULL,
    requested_by_email VARCHAR(255) NOT NULL,
    requested_at       TIMESTAMP    NOT NULL,
    validated_by_email VARCHAR(255),
    validated_at       TIMESTAMP,
    created_at         TIMESTAMP    NOT NULL,
    updated_at         TIMESTAMP,
    deleted_at         TIMESTAMP,

    CONSTRAINT pk_payment_confirmations PRIMARY KEY (id),

    CONSTRAINT uk_payment_confirmations_unique
        UNIQUE (subscriber_id, platform_id, reference_month),

    CONSTRAINT fk_payment_confirmations_subscriber
        FOREIGN KEY (subscriber_id)
            REFERENCES subscribers (id),

    CONSTRAINT fk_payment_confirmations_platform
        FOREIGN KEY (platform_id)
            REFERENCES platforms (id)
);
