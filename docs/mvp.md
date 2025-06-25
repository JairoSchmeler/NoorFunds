# Minimum Viable Product

The MVP for **NoorFunds** focuses on donation tracking with a streamlined feature set. It draws from the goals and requirements outlined in the conception phase document.

## Core Features

- **Onboarding & Authentication** – new users are guided through registration and login screens to secure access.
- **Donation Dashboard** – display recent donations and quick actions for adding new records.
- **Record Donations** – allow manual entry of donation details or scanning receipts with the camera and OCR.
- **Export Analytics** – generate summaries and CSV exports of donation amounts.
- **Settings & Profiles** – basic profile editing and theme preferences stored locally.

These align with the "Key Features Identified" in the conception phase【F:docs/conception_phase.md†L13-L18】.

## Data Handling

- Store scanned images in the app’s documents directory under `scans/` so sensitive files stay offline【F:README.md†L97-L101】.
- Persist user accounts and donations using SQLite, initialized via `SqliteService.init()`【F:README.md†L103-L107】.
- The local database schema tracks users and donations with foreign keys, mirroring the domain model【F:README.md†L109-L126】.

## Essential Use Cases

1. **Record Donation** – capture a receipt image, parse text through the OCR service, edit details, and save a donation record【F:docs/conception_phase.md†L138-L142】.
2. **View Analytics** – aggregate totals and charts, then export results as CSV【F:docs/conception_phase.md†L144-L147】.
3. **Manage Settings** – update profile information and store onboarding status so tutorials only show once【F:docs/conception_phase.md†L149-L151】.

## Technical Stack

- Written in Flutter and Dart for Android and iOS cross‑platform support.
- Responsive design with the `sizer` package for adapting layout to different screen sizes【F:README.md†L83-L94】.
- Comprehensive theming covering light and dark modes, typography, and components【F:README.md†L64-L81】.
- Local OCR via Google ML Kit, camera capture, and a simple repository pattern for parsed receipts.

## Out of Scope for MVP

- Cloud synchronization or multi‑device access.
- Advanced search and filtering of donation records.
- Integration with third‑party payment platforms.

These are future enhancements listed in the conception phase document【F:docs/conception_phase.md†L153-L156】.

The MVP delivers a complete offline donation tracker with export capabilities and a polished mobile UI. It lays the foundation for additional features in later releases.
