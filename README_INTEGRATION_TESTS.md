# Integration Tests

This project includes comprehensive integration tests to verify the functionality of the Tandem AI language learning app.

## Overview

The integration tests are located in the `integration_test/` directory and cover:

- **App Integration Tests** (`app_test.dart`): Basic app startup and navigation
- **Chat Feature Tests** (`chat_feature_test.dart`): Chat functionality including settings, message sending, and chat history
- **Navigation Tests** (`navigation_test.dart`): Screen navigation and state preservation

## Test Structure

### 1. App Integration Tests
- App launches successfully
- Navigation between screens works

### 2. Chat Feature Tests
- Chat screen loads with proper settings dropdowns
- User interaction with language, level, and topic dropdowns
- Starting new chats
- Typing and sending messages
- Chat history display
- Multiple chat creation

### 3. Navigation Tests
- Navigate to Profile screen
- Navigate to About screen
- Navigate back to Chat screen
- Navigation state preservation

## Running Integration Tests

**Important:** Integration tests require a connected device or emulator to run.

### Prerequisites
- Flutter SDK installed
- Connected Android device or iOS simulator
- For iOS: Xcode with developer tools installed

### Commands

```bash
# Check for connected devices
flutter devices

# Run all integration tests
flutter test integration_test/

# Run specific test file
flutter test integration_test/app_test.dart
flutter test integration_test/chat_feature_test.dart
flutter test integration_test/navigation_test.dart

# Run with verbose output
flutter test integration_test/ --verbose
```

### Running on Specific Platforms

```bash
# Android
flutter test integration_test/ -d android

# iOS
flutter test integration_test/ -d ios

# Chrome (if web support added)
flutter test integration_test/ -d chrome
```

## Dependencies

The following dependency has been added to `pubspec.yaml`:

```yaml
dev_dependencies:
  integration_test:
    sdk: flutter
```

## Test Keys

The integration tests use specific key identifiers to locate widgets. These keys should be added to the corresponding widgets in the app:

- `chat_settings`
- `language_dropdown`
- `level_dropdown`
- `topic_dropdown`
- `new_chat_button`
- `ai_chat`
- `chat_history`
- `message_input`
- `send_button`
- `active_chat_list`
- `profile_screen`
- `about_screen`
- `chat_screen`

## Known Limitations

1. **Device Dependency**: Integration tests require physical devices or emulators
2. **Platform Support**: Currently configured for mobile platforms (iOS/Android)
3. **API Integration**: Tests may need to be updated if backend APIs are added

## Troubleshooting

### No Connected Devices
```
Error: No devices are connected
```
Solution: Connect an Android device via USB or start an iOS simulator

### Xcode Not Found (macOS)
```
Error: Xcode not found
```
Solution: Install Xcode from the App Store and run `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer`

### Test Failures
- Ensure all required key identifiers are added to widgets
- Verify app builds successfully before running integration tests
- Check that target widgets exist and are properly rendered