# ASK SS Voice + Text — V4.5 Beta 1

## Implemented
- Microphone speech-to-text via browser SpeechRecognition where supported.
- Language selection: Urdu (Pakistan) or English (US). Roman Urdu may be recognized when spoken, but accuracy varies by browser.
- Existing D1-backed ASK SS chat is reused; text chat remains available.
- Optional spoken assistant replies via browser speechSynthesis.
- Microphone permissions are requested only on user click.
- Graceful fallback to typed chat if browser speech APIs are unsupported.

## Limitations / not yet implemented
- This is a **browser speech beta**, not OpenAI Realtime Voice or a GPT-powered agent. Existing rules-based ASK SS responses remain in place.
- Browser support and Urdu speech synthesis vary by device.
- Full bilingual Urdu intent coverage, OpenAI Realtime integration, server-side safety/rate limiting, and customer identity verification for order queries remain separate release blockers.
- DO NOT deploy to production until privacy and order-access checks are completed.

## UAT
1. Deploy to staging, open ASK SS on Android Chrome.
2. Select Urdu and tap Speak; allow microphone; say a product category.
3. Select English and test product questions.
4. Toggle voice replies and test audio playback; verify fallback on unsupported browsers.
5. Test typed chat, quick-action buttons, Add Product, cart and orders for regressions.
