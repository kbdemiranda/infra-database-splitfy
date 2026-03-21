ALTER TABLE subscribers
    ADD COLUMN IF NOT EXISTS financial_responsible_subscriber_id BIGINT;

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM information_schema.table_constraints
        WHERE constraint_name = 'fk_subscribers_financial_responsible'
    ) THEN
        ALTER TABLE subscribers
            ADD CONSTRAINT fk_subscribers_financial_responsible
            FOREIGN KEY (financial_responsible_subscriber_id) REFERENCES subscribers(id);
    END IF;
END $$;

UPDATE subscribers
SET financial_responsible_subscriber_id = id
WHERE financial_responsible_subscriber_id IS NULL;
