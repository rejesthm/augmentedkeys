# AugmentedKeys M0 Design Memory

- Aesthetic: restrained stage-ready dark foundation; calm, legible, and intentionally non-productized.
- Dials: design variance 2/10, motion intensity 0/10, visual density 2/10.
- Type: Flutter platform text theme is a temporary M0 exception so no unreviewed font dependency or asset is added; final typography requires licensing and product-design review.
- Color: dark Material 3 foundation with a single muted emerald seed `#7BC8A4`; no gradients, pure black/white declarations, shadows, or status colors are introduced by this screen.
- Layout: centered single-column status content, 32 logical-pixel outer padding, 640 logical-pixel maximum width, scroll-safe on small phones, and `SafeArea` protected.
- Motion: none.
- Components: `AugmentedKeysApp` and `M0FoundationScreen` only.
- Copy: use the exact factual strings from the widget test; no marketing claims or banned filler words.
- Accessibility: semantic header, readable hierarchy, no interactive controls, and no false readiness language.
- Project-specific bans: no simulated keyboard, meters, controls, competitor-derived visuals, fake readiness claims, animations, or third-party visual dependencies in M0.
- Last updated: `2026-08-29 — initial M0 foundation screen`.
