ALTER TABLE users
    ADD COLUMN receives_dashboard_email BOOLEAN NOT NULL DEFAULT FALSE;

CREATE UNIQUE INDEX ux_users_single_dashboard_email_recipient
    ON users (receives_dashboard_email)
    WHERE receives_dashboard_email = TRUE
        AND deleted_at IS NULL;