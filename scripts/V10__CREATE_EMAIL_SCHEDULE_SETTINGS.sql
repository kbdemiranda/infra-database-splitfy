CREATE TABLE email_schedule_settings
(
    id           BIGSERIAL PRIMARY KEY,
    schedule_key VARCHAR(100) NOT NULL UNIQUE,
    description  VARCHAR(255),
    is_enabled   BOOLEAN      NOT NULL DEFAULT TRUE,
    timezone     VARCHAR(64)  NOT NULL DEFAULT 'America/Sao_Paulo',
    created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE email_schedule_occurrences
(
    id                        BIGSERIAL PRIMARY KEY,
    email_schedule_setting_id BIGINT    NOT NULL,
    day_of_week               SMALLINT  NOT NULL,
    execution_time            TIME      NOT NULL,
    created_at                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_email_schedule_occurrences_setting
        FOREIGN KEY (email_schedule_setting_id)
            REFERENCES email_schedule_settings (id)
            ON DELETE CASCADE,

    CONSTRAINT ck_email_schedule_occurrences_day_of_week
        CHECK (day_of_week BETWEEN 1 AND 7),

    CONSTRAINT uq_email_schedule_occurrences_slot
        UNIQUE (email_schedule_setting_id, day_of_week, execution_time)
);

CREATE INDEX ix_email_schedule_occurrences_setting_id
    ON email_schedule_occurrences (email_schedule_setting_id);

INSERT INTO email_schedule_settings (schedule_key,
                                     description,
                                     is_enabled,
                                     timezone)
VALUES ('DASHBOARD_EMAIL',
        'Scheduled dashboard e-mail dispatch',
        TRUE,
        'America/Sao_Paulo');

INSERT INTO email_schedule_occurrences (email_schedule_setting_id,
                                        day_of_week,
                                        execution_time)
SELECT ess.id, d.day_of_week, TIME '09:00:00'
FROM email_schedule_settings ess
         CROSS JOIN (VALUES (1), (2), (3), (4), (5), (6), (7)) AS d(day_of_week)
WHERE ess.schedule_key = 'DASHBOARD_EMAIL';