CREATE TABLE IF NOT EXISTS participant_financial_responsibilities (
    participant_id bigint PRIMARY KEY,
    financial_responsible_participant_id bigint NOT NULL,
    created_at timestamp                        NOT NULL DEFAULT now(),
    updated_at timestamp                        NULL,
    CONSTRAINT fk_pfr_participant
      FOREIGN KEY (participant_id) REFERENCES subscribers_platforms (id),
    CONSTRAINT fk_pfr_financial_responsible
      FOREIGN KEY (financial_responsible_participant_id) REFERENCES subscribers_platforms(id)
);

INSERT INTO participant_financial_responsibilities (
    participant_id,
    financial_responsible_participant_id,
    created_at
)
SELECT sp.id, sp.id, now()
FROM subscribers_platforms sp
WHERE sp.deleted_at IS NULL
  AND NOT EXISTS (
    SELECT 1
    FROM participant_financial_responsibilities pfr
    WHERE pfr.participant_id = sp.id
);