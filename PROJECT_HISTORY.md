# SS Collections by SunShah — Master Project History

This file preserves the approved project decisions from the ChatGPT development thread through V4.3.

## Business identity
- Brand: **SS Collections by SunShah**
- Domain: **www.sunshah.net**
- Facebook: https://www.facebook.com/SSCollections.SunShah
- Instagram: **ss_collections125**
- WhatsApp: **0346 0113599**
- Business operator: Owner manages the business; technology is maintained collaboratively by Shah and ChatGPT.

## Core product doctrine
- Products are handmade/customised and typically one-of-one.
- Every product has quantity 1.
- Order submission reserves the item until its payment deadline.
- If payment is not received by the due date the reservation can be revoked and the product returns to Available.
- Admin confirmation of payment changes the item permanently to **Sold & Locked**.
- A sold item remains visible in **Our Creations** and may inspire a similar custom order, but is never silently restocked as the same piece.

## Catalogue & marketing
- Compact marketplace layout: 4 products/row desktop, 2 mobile; 6–8 visible during normal browsing.
- Product supports multiple images/videos and full-size review.
- Customer-facing images carry SS Collections branding/watermark plus Facebook, Instagram, website and WhatsApp.
- Categories: All | Bags | Dresses | Jewellery | Hair Accessories | Travel Bags | Winter Collection | Summer Collection | Wedding | Home Décor | Shoes | Other.
- **Our Creations** is the permanent historical/current/future design gallery with reference codes for custom orders.
- **Handmade Journey** shows making-process photos/videos to demonstrate genuine handcrafting.
- Stalls & Events page publishes city, venue, date, timing, stall number, map and media.

## Orders & payments
- Cart terminology is used instead of Bag.
- Order number must be used as payment reference for reconciliation.
- Payments may include bank transfer, QR and later card gateway integration.
- Order confirmation WhatsApp message includes order no., product picture, amount and payment deadline.
- Payment confirmation message: customer is informed SS Collections received payment and dispatch will occur within 3 working days, with tracking shared via WhatsApp.
- SMS was deliberately removed; WhatsApp is the primary communication channel.

## Dispatch evidence
- Admin/Agent can upload actual product photos/videos and packed parcel photos/videos against each order.
- These can be shared with the ordering customer before dispatch for confirmation.
- Transit damage remains the responsibility of SS Collections toward the customer.

## Returns & refunds
- Dedicated Returns page/workflow for damaged, wrong or defective products.
- Customer can provide reason and supporting evidence.
- Refund occurs only after SS Collections receives the returned product and confirms the defect/error.
- Approved refund target: within **15 working days** of receipt and defect confirmation.

## Admin doctrine
- Public visitors do not see the operational Admin dashboard.
- Secure staff access at `/admin.html`.
- Owner can create Admin/Agent login IDs and passwords, assign permissions, disable access and review audit history.
- Every meaningful change requires explicit **Save / Proceed** or confirmation.
- Agents cannot permanently delete core business records.
- Sold & Locked status is protected; non-owner staff cannot reopen a sold item.

## Cloudflare architecture
- Cloudflare Worker + Static Assets: storefront/application.
- D1 binding `DB`: business records.
- R2 binding `FILES`: product/media, journey, payment/dispatch/return evidence.
- GitHub repo: `shahsal/ss-collections-uat`, branch `main`.
- UAT Worker: `ss-collections-uat.shahsal123.workers.dev`.
- V4.2 confirmed `/api/health`: D1 true, R2 true.
- Production domain `www.sunshah.net` remains intentionally unconnected until UAT approval.

## V4.3 scope
- Server-side Owner/Agent authentication using PBKDF2 password hashing and secure HttpOnly sessions.
- Real D1-backed product, user, order, event, creation and journey management.
- Real R2 image/video uploads from Admin.
- Payment confirmation locks product permanently.
- Dispatch evidence uploads and audit trail.
