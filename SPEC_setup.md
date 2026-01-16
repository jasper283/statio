# SPEC_setup.md — App Store Connect Setup

## 1. Goal
Allow users to securely configure App Store Connect API credentials and verify connectivity.

This is the mandatory entry step before accessing any data-related features.

---

## 2. Input Fields

The setup screen must provide the following input fields:

- Issuer ID  
  - TextField
  - Required

- Key ID  
  - TextField
  - Required

- Private Key  
  - Multiline TextEditor
  - Accepts pasted `.p8` file content
  - Required
  - The content must not be echoed to logs or analytics

All labels, placeholders, and helper texts must be localized.

---

## 3. User Actions & Flow

### 3.1 Verify & Connect
- Primary action button: “Verify & Connect” (localized)
- On tap:
  1. Generate JWT using the provided credentials
  2. Call a lightweight App Store Connect API endpoint
     - Example: list available apps
  3. Validate that the credentials are correct and authorized

### 3.2 Success
- Save credentials securely to Keychain
- Persist minimal non-sensitive metadata if needed (e.g. last verified time)
- Navigate automatically to the Dashboard screen
- Trigger an initial data sync after setup completes

### 3.3 Failure
- Do NOT save any credentials
- Show a localized error message
- Error messages must:
  - Be user-friendly
  - Avoid leaking technical details or sensitive data
- Allow the user to retry without restarting the app

---

## 4. Security Requirements (HARD)

- Private Key (.p8 content):
  - Must be stored in Keychain only
  - Must never be written to logs
  - Must never be stored in UserDefaults, files, or SQLite

- JWT:
  - Generated in-memory
  - Short-lived
  - Never persisted

- Networking:
  - Direct connection to App Store Connect
  - No proxy server in v1.0

---

## 5. Credential Management

### 5.1 Remove Credentials
The Settings screen must provide an explicit action to remove credentials:

- “Remove App Store Connect Credentials” (localized)
- On confirmation:
  - Delete credentials from Keychain
  - Clear all locally cached SQLite data
  - Clear widget snapshot data
  - Navigate back to the Setup screen

### 5.2 Reconfiguration
- After credentials are removed:
  - The app must behave as a fresh install
  - Dashboard and data screens must be inaccessible
  - User must complete setup again to proceed

---

## 6. UX Requirements

- Provide clear guidance text explaining:
  - What an App Store Connect API Key is
  - That the key stays on the device only
  - That data has a T+1 / T+2 delay
- Provide a link or help text explaining how to create an ASC API Key
  - The link text must be localized
- Loading, success, and error states must all be visually distinct and localized

---

## 7. Definition of Done

The setup feature is considered complete when:

- Invalid credentials are rejected with a clear error message
- Valid credentials allow successful entry into the Dashboard
- Credentials persist securely across app launches
- Removing credentials fully resets the app state
- No sensitive data appears in logs, crash reports, or UI
