SS Collections by SunShah — V4.4 UAT

1. Run migration migrations/0003_v44_ai_events_dispatch.sql against the SAME D1 database used by V4.3.2.
2. Deploy this package to the existing ss-collections-uat Worker.
3. Workers AI binding AI is included in wrangler.jsonc and uses @cf/zai-org/glm-4.7-flash.
4. Test /api/health — it must show version 4.4.

V4.4 additions:
- SS Collections AI customer-service endpoint /api/ai/chat (English/Urdu/Roman Urdu; guarded business rules).
- Upcoming-event unobtrusive card on storefront.
- One-click Yes / No / Not available event interest.
- Event discount message for visitors and extra discount note for Yes responses.
- Dynamic dispatch working days chosen by Admin at payment confirmation.
- Custom-request D1 endpoint and reference-code support.
- V4.3.2 secure Admin, D1, R2, product/order/gallery foundations retained.

IMPORTANT: AI must never confirm payments/refunds, change prices, unlock sold items or promise exceptional discounts. Those remain Owner/Admin decisions.
