# Flutter Card Form

A customizable Flutter widget for securely collecting credit card information. This library provides a user-friendly form with built-in validation and localization support, making it easy to integrate into your Flutter applications for payment processing.

**Current Version:** 0.0.1-beta.4

## Features

*   **Easy Integration:** Simple to add to your existing Flutter projects.
*   **Input Validation:** Built-in validation for card number, expiry date, CVV, and cardholder name.
*   **Localization Support:** Easily translate field labels and hints using `flutter_localizations`.
*   **Customizable Appearance:** Style the form to match your app's theme.
*   **Secure:** Designed with security in mind, but **remember that handling sensitive card data requires PCI DSS compliance.** This library helps with the UI aspect; ensure your backend and overall architecture are secure.
*   **Payment Service Agnostic:** Designed to work with your preferred payment processing service.
*   **Visual Cues:** Includes common card brand logos (Visa, Mastercard, Amex) for better user experience.

## Minimum Requirements

*   **Dart SDK:** Version 2.17.0 or higher

## Installation

1.  **Add dependency:**
    Open your `pubspec.yaml` file and add the following line under `dependencies`:
    ```yml
    dependencies:
        conekta_component: any
    ```
