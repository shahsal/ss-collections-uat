SS Collections by SunShah — Cloudflare UAT V4.3

SECURE ADMIN + D1/R2 MEDIA MANAGEMENT

1. Run migrations/0002_v43_secure_admin.sql ONCE in Cloudflare D1 Console.
2. Upload/replace the repository contents and commit to main.
3. Cloudflare auto-deploys.
4. Test /api/health — version should be 4.3 and secure_admin true.
5. Open /admin.html.

TEMPORARY UAT OWNER LOGIN
Login ID: owner
Temporary password: SSV43@424cc1
IMPORTANT: Log in and use Change Password immediately.

V4.3 FEATURES
- Secure HttpOnly session-based Owner/Agent login.
- Owner creates/disables staff and grants module permissions.
- Product add/edit with multiple image/video uploads to R2.
- Mandatory Save / Proceed confirmations.
- Order payment confirmation => product becomes Sold & Locked permanently.
- Courier/tracking updates and pre-dispatch product/parcel media uploads.
- Our Creations, Handmade Journey and Events management.
- Audit trail.

UAT MEDIA LIMITS
- Image: 8 MB each
- Short video: 20 MB each
For large production videos, use social embeds or a dedicated video delivery solution rather than oversized direct uploads.

PROJECT_HISTORY.md preserves the approved project/business rules for future reference.
