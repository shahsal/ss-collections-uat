SS Collections by SunShah — Cloudflare UAT V4.2

PURPOSE
V4.2 adds the real Cloudflare D1 + R2 backend foundation while retaining the approved storefront.

BINDINGS REQUIRED
ASSETS = Worker static assets
DB = ss-collections-uat-db
FILES = ss-collections-uat-files

INITIAL DATABASE SETUP
Open Cloudflare > D1 > ss-collections-uat-db > Console.
Paste the full contents of migrations/0001_v42_initialize.sql and click Execute once.
Then type /tables to verify the tables.

DEPLOYMENT
Replace the files in GitHub repository ss-collections-uat with this package and commit to main.
Cloudflare Git integration should deploy automatically.

TESTS AFTER DEPLOY
/api/health should report version 4.2, d1:true, r2:true
/api/products should return seeded products
/api/creations should return the design gallery

V4.2 CUSTOMER BACKEND
- D1 product catalogue with unique-item status
- order creation and reservation in D1
- automatic payment due date/order reference
- expired unpaid reservations are released opportunistically and by hourly scheduled trigger
- R2 media delivery route /media/*
- ratings API
- Handmade Journey API

IMPORTANT
The existing visual staff/admin screens still retain local-browser editing in this incremental UAT build. Do not enter real sensitive customer/payment data into the admin prototype yet. The next security migration is server-side Admin/Agent authentication + authenticated R2 uploads.
deployment trigger for v2.4
V4.2 deployment initiated - 18 August 2026
