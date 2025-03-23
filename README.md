# Mobile App Standard

## Getting Started

### Generate Database or Auto Route

- Whenever a new model is added, a migration is written, or a new route is introduced, perform the generation process using the following command:

```bash
dart run build_runner build
```

### Run

```bash
# Generate i18n
sh generate_all.sh

# Open the emulator before running.

# Run the app
flutter run
```

### Generate i18n

- The `generate_all.sh` script automatically generates localization files and updates `lib/i18n/i18n.dart` based on folders in `lib/i18n/locals/`.
- When adding a new page (e.g., `settings_page`), simply create a new folder in `lib/i18n/locals/` (e.g., `lib/i18n/locals/settings_page`) with `en.arb` and `th.arb` files. Then, run:
  ```bash
  sh generate_all.sh
  ```
- The script will:
  1. Generate localization files (e.g., `settings_page_localizations.dart`) using `flutter gen-l10n`.
  2. Update `lib/i18n/i18n.dart` with the new imports, delegates, and getters automatically.
- If you add new words to an existing `.arb` file (e.g., `general/en.arb`), just run `sh generate_all.sh` again to regenerate the affected localization file.
- After running the script, stop the app and restart it with `flutter run` to apply the changes.

## Project Structure

```bash
/lib
├── config
│   └── config.dart                # Basic configuration file for the app
├── domain
│   ├── datasource
│   │   ├── app_database.dart      # File defining the main database structure of the app
│   │   └── app_database.g.dart    # Auto-generated file from app_database.dart (generated)
│   ├── http_client
│   │   ├── ip.dart                # File managing connections via IP or HTTP client
│   │   └── websocket.dart         # File managing WebSocket connections
│   ├── models
│   │   └── todo_table.dart        # Data model for the Todo table in the database
│   └── repositories
│       └── todo_repo.dart         # Repository for handling Todo-related logic (e.g., CRUD)
├── feature
│   ├── home
│   │   ├── bloc
│   │   │   └── websocket
│   │   │       ├── websocket_bloc.dart   # BLoC for managing WebSocket logic
│   │   │       ├── websocket_event.dart  # Events occurring in WebSocket
│   │   │       └── websocket_state.dart  # States of WebSocket
│   │   └── pages
│   │       └── home_page.dart     # Home page of the app
│   └── todo
│       ├── bloc
│       │   ├── todo_bloc.dart     # BLoC for managing Todo logic
│       │   ├── todo_event.dart    # Events occurring in Todo
│       │   └── todo_state.dart    # States of Todo
│       ├── model
│       │   └── todo_model.dart    # Data model for Todo (possibly used in UI)
│       ├── pages
│       │   └── todo_page.dart     # Todo page of the app
│       └── widgets
│           └── dialog
│               └── add_todo_dialog.dart  # Dialog widget for adding a Todo
├── i18n
│   ├── i18n.dart                  # File defining language management (internationalization, auto-generated)
│   └── locals
│       ├── general
│       │   ├── en.arb            # English text for general sections
│       │   └── th.arb            # Thai text for general sections
│       ├── home_page
│       │   ├── en.arb            # English text for the Home page
│       │   └── th.arb            # Thai text for the Home page
│       └── todo_page
│           ├── en.arb            # English text for the Todo page
│           └── th.arb            # Thai text for the Todo page
├── locator.dart                   # File for setting up Dependency Injection (e.g., GetIt)
├── main.dart                      # App entry point file
├── router
│   ├── router.dart                # File defining navigation routes
│   └── router.gr.dart             # Auto-generated file for router (generated)
└── shared
    ├── bloc
    │   └── language
    │       ├── language_bloc.dart    # BLoC for managing language switching
    │       ├── language_event.dart   # Events occurring in the language system
    │       └── language_state.dart   # States of the language system
    ├── styles
    │   ├── p_colors.dart             # File defining colors used in the app
    │   ├── p_size.dart               # File defining sizes used in the app (e.g., font sizes)
    │   └── p_style.dart              # File defining styles used in the app (e.g., TextStyle)
    ├── utils
    │   └── debouncer.dart            # Utility file for managing time delays (debounce)
    └── widgets
        ├── appbar
        │   ├── appbar_custom.dart       # Custom AppBar widget
        │   └── language_dropdown.dart   # Dropdown widget for language selection
        └── toasts
            └── toast_helper.dart         # Utility file for managing Toast alerts
```

## Best Practices

### File Naming

- Use `lowercase_with_underscores`: `home_screen.dart`, `user_model.dart`
- Name files descriptively: `custom_button.dart`, `login_screen.dart`
- Avoid spaces or uppercase letters.

### Variable Naming

- Use `camelCase`: `userName`, `getUserData`
- Be descriptive: `itemCount` instead of `x`
- Use `UPPER_CASE` for constants: `MAX_LOGIN_ATTEMPTS`
- Prefix private variables with `_`: `_userId`

### Install Extension Bloc Generator

- [Bloc Generator Extension](https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc)

### Build APK

```bash
# For a single APK
flutter build apk

# For split APKs by ABI
flutter build apk --target-platform android-arm,android-arm64 --split-per-abi
```

### Export Database

```bash
adb exec-out run-as com.example.mobile_app cat /data/data/com.example.mobile_app/app_flutter/my_database.sqlite > my_database.sqlite
```

### More

- When using an API with a localhost in the Android Studio emulator for Flutter, utilize `http://10.0.2.2` instead of `localhost`.
