SS Collections by SunShah — Cloudflare UAT V4.1

1. Upload/replace these files in the ss-collections-uat GitHub repository.
2. Let Cloudflare auto-deploy. The D1 binding name is DB.
3. In D1 > ss-collections-uat-db > Console, run migrations/0001_initial.sql once.
4. Test /api/health, /api/products, /api/events and /api/creations.

R2 is NOT required in V4.1. Existing static product images remain in public/assets. Media-library URLs can later point to Cloudflare R2 or approved social/video sources.

Important: the visible Admin remains the prototype/local Admin in this incremental package. Do not enter real payment/customer data until server-side authentication is added in V4.2.
