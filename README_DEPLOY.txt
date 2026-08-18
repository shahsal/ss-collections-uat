SS Collections by SunShah — Cloudflare UAT V4.0

This package is Phase 1 of the Cloudflare migration.
It deploys the approved V3.2.1 storefront to a temporary workers.dev address using Cloudflare Workers + Static Assets.

The included D1 migration is the planned production schema, but the current storefront still uses its browser-prototype storage. Do not connect sunshah.net yet and do not treat this as production order storage.

Recommended UAT sequence:
1. Deploy to workers.dev.
2. Review the public site on desktop and mobile.
3. Then enable D1 and R2 and migrate products/orders/admin data in V4.1.
4. Only after database/security UAT, connect www.sunshah.net.

Worker name: ss-collections-uat
Health endpoint after deployment: /api/health
