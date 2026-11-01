SS Collections by SunShah — Cloudflare UAT V4.3.1

Corrective UAT release.

Changes:
- PBKDF2 iterations reduced to 10,000 for Cloudflare Workers Free-tier UAT CPU constraints.
- Secure admin/session model retained.
- Health endpoint reports 4.3.1.
- Admin surfaces backend detail on UAT login errors for troubleshooting.
- Old V3.2 customer/admin labels removed.

IMPORTANT
Run SS_Collections_D1_V4.3.1_OWNER_RESEED.sql once before/after deployment so the temporary owner credential matches the new PBKDF2 cost.
Temporary UAT owner password remains: SSV43@424cc1
Change it immediately after successful login.

No product/order/media schema changes are required.
