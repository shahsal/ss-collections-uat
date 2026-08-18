-- SS Collections by SunShah V4.3 Secure Admin migration
PRAGMA foreign_keys = ON;

-- Seed / refresh the UAT Owner account. Change this password immediately after first login.
INSERT INTO admin_users(login_id,display_name,password_hash,password_salt,role,permissions_json,is_active)
VALUES('owner','SS Collections Owner','5f19d4519fb9ef2d0d2087177e70297d805d6b1b540d59cff22a2ee620b5aeab','0a7d09572325295e53d0d0a9ace7a191','owner','{"all":true}',1)
ON CONFLICT(login_id) DO UPDATE SET
 display_name=excluded.display_name, password_hash=excluded.password_hash, password_salt=excluded.password_salt,
 role='owner', permissions_json='{"all":true}', is_active=1, updated_at=CURRENT_TIMESTAMP;

DELETE FROM admin_sessions WHERE expires_at < CURRENT_TIMESTAMP;

CREATE INDEX IF NOT EXISTS idx_admin_sessions_hash ON admin_sessions(token_hash);
CREATE INDEX IF NOT EXISTS idx_admin_users_login ON admin_users(login_id);
CREATE INDEX IF NOT EXISTS idx_audit_created ON audit_log(created_at);
CREATE INDEX IF NOT EXISTS idx_payments_order ON payments(order_id);
CREATE INDEX IF NOT EXISTS idx_returns_status ON returns(status);
CREATE INDEX IF NOT EXISTS idx_events_date ON events(event_date);
