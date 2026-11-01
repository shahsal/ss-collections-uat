PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS settings (
  key TEXT PRIMARY KEY,
  value TEXT NOT NULL,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admin_users (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  login_id TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  password_hash TEXT,
  password_salt TEXT,
  role TEXT NOT NULL DEFAULT 'agent' CHECK(role IN ('owner','admin','agent')),
  permissions_json TEXT NOT NULL DEFAULT '{}',
  is_active INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admin_sessions (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  admin_user_id INTEGER NOT NULL,
  token_hash TEXT NOT NULL UNIQUE,
  expires_at TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(admin_user_id) REFERENCES admin_users(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL UNIQUE,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  description TEXT,
  price_pkr INTEGER NOT NULL DEFAULT 0,
  discount_type TEXT NOT NULL DEFAULT 'percent' CHECK(discount_type IN ('percent','fixed')),
  discount_value REAL NOT NULL DEFAULT 0,
  status TEXT NOT NULL DEFAULT 'available' CHECK(status IN ('available','reserved','sold_locked','seasonal','coming_soon','archive')),
  unique_piece INTEGER NOT NULL DEFAULT 1,
  featured INTEGER NOT NULL DEFAULT 0,
  reserved_order_no TEXT,
  reserved_until TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  product_id INTEGER NOT NULL,
  media_type TEXT NOT NULL DEFAULT 'image' CHECK(media_type IN ('image','video')),
  r2_key TEXT,
  asset_url TEXT,
  caption TEXT,
  is_primary INTEGER NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS creations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  code TEXT NOT NULL UNIQUE,
  title TEXT NOT NULL,
  category TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Past Collection',
  season TEXT,
  note TEXT,
  custom_possible INTEGER NOT NULL DEFAULT 1,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS creation_media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  creation_id INTEGER NOT NULL,
  media_type TEXT NOT NULL DEFAULT 'image' CHECK(media_type IN ('image','video')),
  r2_key TEXT,
  asset_url TEXT,
  caption TEXT,
  is_primary INTEGER NOT NULL DEFAULT 0,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(creation_id) REFERENCES creations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS handmade_journey (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  description TEXT,
  product_id INTEGER,
  creation_id INTEGER,
  stage TEXT,
  media_type TEXT NOT NULL DEFAULT 'video' CHECK(media_type IN ('image','video')),
  r2_key TEXT,
  external_url TEXT,
  is_published INTEGER NOT NULL DEFAULT 1,
  sort_order INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL,
  FOREIGN KEY(creation_id) REFERENCES creations(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  title TEXT NOT NULL,
  city TEXT,
  venue TEXT,
  stall_no TEXT,
  event_date TEXT,
  timing TEXT,
  maps_url TEXT,
  media_r2_key TEXT,
  asset_url TEXT,
  details TEXT,
  status TEXT NOT NULL DEFAULT 'upcoming',
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_no TEXT NOT NULL UNIQUE,
  customer_name TEXT NOT NULL,
  whatsapp TEXT NOT NULL,
  email TEXT,
  address TEXT,
  city TEXT,
  amount_pkr INTEGER NOT NULL DEFAULT 0,
  payment_method TEXT,
  payment_due_at TEXT,
  payment_reference TEXT,
  payment_status TEXT NOT NULL DEFAULT 'pending' CHECK(payment_status IN ('pending','submitted','confirmed','rejected','refunded')),
  order_status TEXT NOT NULL DEFAULT 'reserved' CHECK(order_status IN ('reserved','payment_pending','paid','preparing','awaiting_dispatch_confirmation','dispatched','delivered','revoked','cancelled','return_requested','returned','refunded')),
  courier_name TEXT,
  tracking_id TEXT,
  customer_dispatch_confirmed INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS order_items (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  unit_price_pkr INTEGER NOT NULL,
  product_snapshot_name TEXT NOT NULL,
  product_snapshot_code TEXT NOT NULL,
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY(product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS payments (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER NOT NULL,
  payment_reference TEXT,
  amount_pkr INTEGER,
  method TEXT,
  proof_r2_key TEXT,
  status TEXT NOT NULL DEFAULT 'submitted',
  submitted_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  confirmed_at TEXT,
  confirmed_by INTEGER,
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY(confirmed_by) REFERENCES admin_users(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS order_media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER NOT NULL,
  media_type TEXT NOT NULL CHECK(media_type IN ('product_before_dispatch','parcel_before_dispatch','making_journey','other')),
  file_type TEXT NOT NULL DEFAULT 'image' CHECK(file_type IN ('image','video')),
  r2_key TEXT NOT NULL,
  caption TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS returns (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  order_id INTEGER NOT NULL,
  reason TEXT NOT NULL,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'requested',
  owner_received_at TEXT,
  defect_confirmed_at TEXT,
  refund_due_at TEXT,
  refunded_at TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(order_id) REFERENCES orders(id)
);

CREATE TABLE IF NOT EXISTS return_media (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  return_id INTEGER NOT NULL,
  media_type TEXT NOT NULL DEFAULT 'image' CHECK(media_type IN ('image','video')),
  r2_key TEXT NOT NULL,
  caption TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(return_id) REFERENCES returns(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  product_id INTEGER,
  order_id INTEGER,
  customer_name TEXT,
  rating INTEGER NOT NULL CHECK(rating BETWEEN 1 AND 5),
  feedback TEXT,
  service_rating INTEGER CHECK(service_rating BETWEEN 1 AND 5),
  is_approved INTEGER NOT NULL DEFAULT 0,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE SET NULL,
  FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS audit_log (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  admin_user_id INTEGER,
  action TEXT NOT NULL,
  entity_type TEXT,
  entity_id TEXT,
  details_json TEXT,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY(admin_user_id) REFERENCES admin_users(id) ON DELETE SET NULL
);

CREATE INDEX IF NOT EXISTS idx_products_status ON products(status);
CREATE INDEX IF NOT EXISTS idx_products_category ON products(category);
CREATE INDEX IF NOT EXISTS idx_products_reserved_until ON products(reserved_until);
CREATE INDEX IF NOT EXISTS idx_orders_no ON orders(order_no);
CREATE INDEX IF NOT EXISTS idx_orders_payment_due ON orders(payment_due_at);
CREATE INDEX IF NOT EXISTS idx_order_items_order ON order_items(order_id);
CREATE INDEX IF NOT EXISTS idx_product_media_product ON product_media(product_id);
CREATE INDEX IF NOT EXISTS idx_creation_media_creation ON creation_media(creation_id);
CREATE INDEX IF NOT EXISTS idx_reviews_product ON reviews(product_id);

INSERT OR IGNORE INTO settings(key,value) VALUES
('brand_name','SS Collections by SunShah'),
('whatsapp','923460113599'),
('facebook','https://www.facebook.com/SSCollections.SunShah'),
('instagram','https://www.instagram.com/ss_collections125/'),
('website','https://www.sunshah.net'),
('reservation_hours','24'),
('dispatch_working_days','3'),
('refund_working_days','15');

INSERT OR IGNORE INTO products(code,name,category,description,price_pkr,discount_value,status,featured) VALUES
('BAG-00001','Signature Mirror-Work Boho Bag','Bags','A one-of-one embroidered statement bag finished with mirror-work, shells, tassels and a detachable handcrafted strap.',6500,0,'available',1),
('BAG-00002','Colourful Handmade Potli Bag','Bags','A unique handmade potli with bright embroidery and individual handcrafted character.',4200,10,'available',1),
('TRV-00001','Heritage Travel Trolley Bag','Travel Bags','A unique customised trolley bag combining traditional craft with practical travel use.',18500,0,'available',1),
('TRV-00002','Handcrafted Office & Laptop Bag','Travel Bags','A one-off office and laptop bag with traditional detailing adapted for everyday use.',12500,0,'available',0),
('DRS-00001','Maroon Mirror-Work Three-Piece','Dresses','A unique traditional three-piece with Sindhi/Balochi-inspired mirror and thread embroidery.',28000,8,'available',1),
('HAI-00001','Traditional Hair Jewellery','Hair Accessories','A one-of-one festive hair ornament with colourful cords, beads, bells and handcrafted detailing.',3800,0,'available',0),
('BAG-00003','Fringe Folk Handbag','Bags','A compact one-off folk handbag with vivid embroidery, mirror accents and fringe.',7200,0,'available',0),
('BAG-00004','Festival Embroidered Clutch','Wedding','A one-piece festive clutch with shells, beadwork, tassels and traditional embroidery.',4800,15,'available',0);

INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Vibrant Handmade Embroidered Boho Bag.png',1,0 FROM products WHERE code='BAG-00001';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Colourful Handmade Embroidered Bag Collection.png',1,0 FROM products WHERE code='BAG-00002';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Handcrafted Bags for Travel and Work.png',1,0 FROM products WHERE code='TRV-00001';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Handcrafted Bags for Travel and Work.png',1,0 FROM products WHERE code='TRV-00002';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Maroon Mirror-Work Embroidered Kameez Board.png',1,0 FROM products WHERE code='DRS-00001';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/SS Collections Hair Jewellery Showcase.png',1,0 FROM products WHERE code='HAI-00001';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/fringe-folk-handbag.png',1,0 FROM products WHERE code='BAG-00003';
INSERT OR IGNORE INTO product_media(product_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/festival-embroidered-clutch.png',1,0 FROM products WHERE code='BAG-00004';

INSERT OR IGNORE INTO creations(code,title,category,status,season,note,custom_possible) VALUES
('BAG-00125','Signature Mirror-Work Boho Bag','Bags','Sold','All Season','Past creation • similar custom design possible',1),
('BAG-00126','Colourful Handmade Potli','Bags','Available Now','All Season','Current creation',1),
('TRV-00041','Heritage Travel Trolley','Travel Bags','Seasonal','Travel','Made on request',1),
('DRS-00342','Maroon Mirror-Work Dress','Dresses','Past Collection','Summer Collection','Reference design',1),
('JEW-00118','Traditional Hair Jewellery','Hair Accessories','Sold','Wedding','Past creation',1),
('BAG-00127','Fringe Folk Handbag','Bags','Coming Soon','All Season','Future inspiration',1),
('BAG-00128','Festival Embroidered Clutch','Wedding','Sold','Wedding','Past festive creation',1),
('HOM-00021','Handcrafted Textile Inspiration','Home Décor','Inspiration Only','All Season','Discuss a custom concept',1);

INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Vibrant Handmade Embroidered Boho Bag.png',1,0 FROM creations WHERE code='BAG-00125';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Colourful Handmade Embroidered Bag Collection.png',1,0 FROM creations WHERE code='BAG-00126';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Handcrafted Bags for Travel and Work.png',1,0 FROM creations WHERE code='TRV-00041';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Maroon Mirror-Work Embroidered Kameez Board.png',1,0 FROM creations WHERE code='DRS-00342';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/SS Collections Hair Jewellery Showcase.png',1,0 FROM creations WHERE code='JEW-00118';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/fringe-folk-handbag.png',1,0 FROM creations WHERE code='BAG-00127';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/festival-embroidered-clutch.png',1,0 FROM creations WHERE code='BAG-00128';
INSERT OR IGNORE INTO creation_media(creation_id,asset_url,is_primary,sort_order)
SELECT id,'/assets/Handmade Boho Bags Collection Display.png',1,0 FROM creations WHERE code='HOM-00021';
