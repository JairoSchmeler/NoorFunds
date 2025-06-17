# 50-Day Development Timeline

This document outlines a day-by-day plan for building the NoorFunds application from initial research through feature implementation. Each week concludes with a recap of accomplishments.

## Day 1
- Kickoff meeting to clarify the concept of NoorFunds: a cross-platform donation management app.
- Analyze target users and key features (onboarding, dashboard, donation records, OCR scanning, analytics export, settings).

## Day 2
- Define project scope and milestones for the 50-day schedule.
- Outline initial requirements and create a shared design document.

## Day 3
- Research similar apps for inspiration on UI/UX and functionality.
- Decide on Flutter as the primary framework.

## Day 4
- Set up development environment with Flutter SDK and preferred IDE.
- Initialize Git repository and configure version control workflows.

## Day 5
- Create a basic Flutter project and push the initial commit to the repository.
- Configure CI scripts for running `flutter analyze` and `flutter test`.

## Day 6
- Establish project structure (`lib/`, `assets/`, `test/`).
- Integrate `flutter_lints` for code quality standards.

## Day 7
- Draft wireframes for splash screen, onboarding flow, and dashboard.
- Collect feedback from the team on the wireframes.

### Week 1 Recap
- Requirements gathered and schedule created.
- Development environment and repository set up.
- Initial project scaffolding and linting configured.
- Wireframes drafted for core screens.

## Day 8
- Implement splash screen widget and route.
- Add simple assets for the splash logo.

## Day 9
- Build basic navigation with named routes (`AppRoutes`).
- Configure initial route to splash screen.

## Day 10
- Start theming system: create `AppTheme` with light and dark color schemes.
- Apply theme in `main.dart`.

## Day 11
- Implement onboarding flow screens with placeholder text.
- Add navigation from splash screen to onboarding.

## Day 12
- Research responsive design solutions; integrate `sizer` package for percentages.
- Verify layout works on different device sizes.

## Day 13
- Create global error handling widget (`CustomErrorWidget`).
- Set `ErrorWidget.builder` in `main.dart` for catching Flutter errors.

## Day 14
- Review code, run `flutter analyze` and `flutter test` to ensure stability.

### Week 2 Recap
- Splash screen, theming, and onboarding flow implemented.
- Routing configured with named routes.
- Responsive design library integrated.
- Custom error widget set up.

## Day 15
- Design UI for dashboard home (summary stats, donation quick actions).
- Create placeholder dashboard widget in `presentation/dashboard_home`.

## Day 16
- Add bottom navigation structure for Dashboard, Records, and Settings.
- Connect navigation with routes.

## Day 17
- Implement donation records list screen with sample static data.
- Style list items to match theme.

## Day 18
- Create donation record detail screen with sections for donor, amount, and notes.
- Enable navigation from list to detail view.

## Day 19
- Integrate local storage with `shared_preferences` to persist onboarding completion state.
- Skip onboarding on subsequent app launches if already completed.

## Day 20
- Research network layer; add `dio` package for API requests.
- Prepare service classes for future remote data retrieval.

## Day 21
- Run tests and linters to keep codebase clean.
- Document progress in README.

### Week 3 Recap
- Dashboard, donation list, and detail screens created.
- Bottom navigation wired up.
- Onboarding persistence implemented.
- Prepared networking layer with Dio.

## Day 22
- Create camera scanning screen using `camera` and `image_picker` packages.
- Build simple UI for capturing donation receipts.

## Day 23
- Add OCR processing placeholder (future integration with real OCR service).
- Store captured image path for review.

## Day 24
- Build OCR results verification screen where users confirm extracted text.
- Allow editing of recognized donation details.

## Day 25
- Connect OCR verification output to donation record detail screen for saving new records.
- Ensure smooth navigation from camera to verification to detail.

## Day 26
- Implement export analytics screen with charts using `fl_chart`.
- Display summary statistics based on mock data.

## Day 27
- Add connectivity checks via `connectivity_plus` to warn users when offline.
- Show toast notifications with `fluttertoast`.

## Day 28
- Review code for camera, OCR, and analytics features.
- Run tests to confirm the app still builds successfully.

### Week 4 Recap
- Camera scanning and OCR verification flow built.
- Export analytics screen with charts added.
- Connectivity checks implemented.
- Continuous code reviews and testing maintained.

## Day 29
- Design and implement settings/profile screen for user preferences.
- Include theme toggle placeholder for future enhancement.

## Day 30
- Hook up cached image loading with `cached_network_image` for donation photos.
- Verify caching behavior on repeated loads.

## Day 31
- Configure `.env` support with `flutter_dotenv` and add sample environment variables.
- Ensure sensitive keys are ignored from version control.

## Day 32
- Add reusable widgets directory (`widgets/`) for buttons and form fields.
- Refactor existing screens to use these widgets.

## Day 33
- Improve routing structure in `AppRoutes` and ensure all screens are registered.
- Add initial tests for navigation using `flutter_test`.

## Day 34
- Polish light and dark themes, adjusting colors and typography.
- Update any placeholder TODOs in `AppTheme`.

## Day 35
- Create unit tests for utility functions in `core/`.
- Run `flutter test` to confirm everything passes.

## Day 36
- Conduct mid-project review with stakeholders.
- Gather feedback and adjust remaining tasks accordingly.

### Week 5 Recap
- Settings/profile screen implemented.
- Image caching and environment variable support added.
- Reusable widgets and improved routing in place.
- Initial unit and widget tests created.
- Themes polished based on feedback.

## Day 37
- Implement data models for donations and user profiles.
- Use `json_serializable` style patterns (manually coded) to parse sample JSON.

## Day 38
- Begin hooking up real or mock API endpoints with Dio service classes.
- Replace static donation list with fetched data.

## Day 39
- Add loading indicators and error states to network calls.
- Verify offline behavior interacts properly with connectivity checks.

## Day 40
- Refactor state management using setState/simple provider pattern for small screens.
- Ensure screens rebuild properly when data changes.

## Day 41
- Build export-to-CSV function for donation records in analytics screen.
- Allow user to share CSV file via system share sheet.

## Day 42
- Continue integrating feedback from testing; fix layout issues on smaller devices.
- Optimize asset sizes and compress images in `assets/images`.

## Day 43
- Write additional widget tests for camera flow and export analytics.
- Maintain code coverage above 80% for critical modules.

## Day 44
- Conduct security review of stored data and permissions (camera, storage).
- Ensure compliance with privacy guidelines.

### Week 6 Recap
- Data models and network layer finalized.
- Real or mock API integration implemented.
- CSV export and sharing added.
- Additional tests and security review completed.

## Day 45
- Perform UI polish pass on all screens: consistent margins, fonts, and icons.
- Validate dark theme across the entire app.

## Day 46
- Localize text strings for at least one additional language as a demonstration.
- Update build scripts to include localization files.

## Day 47
- Finalize app icon and splash screen imagery for both Android and iOS.
- Update `pubspec.yaml` to bundle required assets.

## Day 48
- Prepare Play Store/App Store screenshots using emulators or design tools.
- Draft basic store listing descriptions.

## Day 49
- Run full test suite and fix any last-minute bugs.
- Verify release builds with `flutter build apk --release` and `flutter build ios --release`.

## Day 50
- Complete final documentation (README updates and this timeline file).
- Tag `v1.0.0` release in Git and deliver to stakeholders.

### Final Week Recap
- UI polish, localization, and store assets completed.
- Release builds tested on Android and iOS.
- Documentation finalized and version tagged.

