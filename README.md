# mobile_app_standard

## Getting Started

### Generate Database Or Auto Route

```
dart run build_runner build
```

### Run

```
flutter run
```

### Generate i18n

- If new files are added in the future, you’ll need to edit `generate_i18n.sh` and `lib/i18n/i18n.dart` following the examples in those files.
- After that, run `sh generate_i18n.sh`, and every time you add something new, you’ll need to manually import the files yourself.
- Then, stop the app and restart it.
- If you’re adding new words to an existing file, you can just add them directly. But once you’re done, you still need to run `sh generate_i18n.sh`.

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
│   ├── i18n.dart                  # File defining language management (internationalization)
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

### Install Extension Bloc Generator

- `https://marketplace.visualstudio.com/items?itemName=FelixAngelov.bloc`

### Build APK

```
flutter build apk
flutter build apk --target-platform android-arm,android-arm64 --split-per-abi
```
