-- Busca por email (login)
CREATE INDEX IF NOT EXISTS idx_users_email
    ON users (email);

-- Busca por profile
CREATE INDEX IF NOT EXISTS idx_users_profile_id
    ON users (profile_id);

-- Soft delete queries (muito comum em filtros)
CREATE INDEX IF NOT EXISTS idx_users_deleted_at
    ON users (deleted_at);

-- Caso você filtre usuários ativos frequentemente
CREATE INDEX IF NOT EXISTS idx_users_is_enabled
    ON users (is_enabled);
