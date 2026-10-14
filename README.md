# 🛒 Marketi  - Advanced E-Commerce Mobile Application

> A feature-rich, scalable, and high-performance cross-platform e-commerce mobile application built with Flutter, leveraging a robust feature-based architecture, Cubit for predictable state management, Dio for network operations, and Auto Route for type-safe navigation.

---

## 🌟 Table of Contents
- [About The Project](#-about-the-project)
- [Architecture & Design Patterns](#-architecture--design-patterns)
- [Tech Stack & Tooling](#-tech-stack--tooling)
- [App User Flows & Screens](#-app-user-flows--screens)
- [Key Features](#-key-features)
- [Project Structure (Feature-Based)](#-project-structure-feature-based)
- [Author & Team](#-author--team)

---

##  About The Project

**Marketi** is a comprehensive e-commerce ecosystem designed to deliver a seamless and native shopping experience. Developed collaboratively by a skilled engineering team, the app handles everything from secure user authentication and dynamic product catalogs to advanced search, cart management, seamless checkout, and profile customization (including Dark Mode support).

---

##  Architecture & Design Patterns

* **Feature-Based Architecture:** The project codebase is strictly modularized by features (e.g., auth, cart, profile, home), ensuring high maintainability, scalability, and clean separation of concerns among team members.
* **State Management & Networking:** Built using **Cubit** to manage UI states reactively and predictably across all features, paired with **Dio** as the core HTTP client for handling RESTful API requests, interceptors, error handling, and token management efficiently.
* **Navigation:** Powered by **Auto Route** for type-safe routing and deep-linking capabilities across complex screen hierarchies.

---

##  Tech Stack & Tooling

* **Framework:** Flutter (Dart)
* **State Management:** Flutter Cubit (Bloc library)
* **Networking & API:** Dio (RESTful API integration, interceptors, and error handling)
* **Routing:** `auto_route` (Type-safe navigation generator)
* **UI/UX Adaptation:** Responsive layouts tailored for diverse mobile viewports, supporting both Light and Dark themes.

---

##  App User Flows & Screens

The application is structured around intuitive and user-centric flows:
1. **Onboarding & Authentication:** Splash screen, interactive onboarding slides, secure Sign In, Sign Up, and OTP/Password recovery workflows.
2. **Core Shopping Experience:** Dynamic Home screen, advanced search filters, rich product details, category listings, and brand showcases.
3. **Checkout & Cart Management:** Empty/Active cart states, seamless checkout steps, address management, and order success confirmation.
4. **User Dashboard & Settings:** Comprehensive profile customization, account preferences, security settings, and support modals with full Dark Mode toggle.

---

##  Project Structure (Feature-Based)

```text
marketi-app/
├── lib/
│   ├── core/                # Core utilities, Dio client configuration, themes, routes
│   ├── features/            # Feature-first modular structure
│   │   ├── auth/            # Login, Register, Forgot Password (Cubit + Dio services)
│   │   ├── home/            # Dashboard, Banners, Products
│   │   ├── cart/            # Cart management & Checkout flow
│   │   ├── search/          # Search filters & results
│   │   └── profile/         # User profile & settings (Dark mode support)
│   └── main.dart
└── pubspec.yaml
