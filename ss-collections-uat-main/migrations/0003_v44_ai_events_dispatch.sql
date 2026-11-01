-- SS Collections by SunShah V4.4
PRAGMA foreign_keys = ON;
ALTER TABLE orders ADD COLUMN dispatch_working_days INTEGER;
CREATE TABLE IF NOT EXISTS event_interest (id INTEGER PRIMARY KEY AUTOINCREMENT,event_id INTEGER NOT NULL,choice TEXT NOT NULL CHECK(choice IN ('yes','no','not_available')),visitor_key TEXT,created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(event_id) REFERENCES events(id) ON DELETE CASCADE);
CREATE INDEX IF NOT EXISTS idx_event_interest_event ON event_interest(event_id);
CREATE TABLE IF NOT EXISTS custom_requests (id INTEGER PRIMARY KEY AUTOINCREMENT,customer_name TEXT NOT NULL,whatsapp TEXT NOT NULL,product_type TEXT,reference_code TEXT,colour_size TEXT,instructions TEXT,reference_r2_key TEXT,status TEXT NOT NULL DEFAULT 'new',created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP);
CREATE INDEX IF NOT EXISTS idx_custom_requests_status ON custom_requests(status);
INSERT OR IGNORE INTO settings(key,value) VALUES ('ai_customer_service','on'),('event_popup','on');
