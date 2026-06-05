# Bala Screen Reader - Project Structure

Complete guide to the project structure and modules.

## Directory Structure

```
Bala-screen-reader/
├── talkback/                          # Main screen reader module
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/
│   │   │   │   └── com/bala/screenreader/
│   │   │   │       ├── BalaScreenReaderService.java       # Main accessibility service
│   │   │   │       ├── gesture/                           # Gesture detection
│   │   │   │       ├── tts/                               # Text-to-speech
│   │   │   │       ├── navigation/                        # Navigation logic
│   │   │   │       ├── feedback/                          # Haptic/audio feedback
│   │   │   │       ├── labeling/                          # Custom labels
│   │   │   │       ├── ipc/                               # Inter-process communication
│   │   │   │       └── preference/                        # Settings management
│   │   │   ├── res/
│   │   │   │   ├── values/
│   │   │   │   │   └── strings.xml                        # UI strings
│   │   │   │   ├── drawable/                             # App icons/drawables
│   │   │   │   ├── layout/                               # Activity layouts
│   │   │   │   ├── xml/
│   │   │   │   │   ├── accessibilityservice.xml          # Accessibility config
│   │   │   │   │   └── preferences.xml                   # Preferences layout
│   │   │   │   └── anim/                                 # Animations
│   │   │   └── AndroidManifest.xml                       # App manifest
│   │   ├── test/                                         # Unit tests
│   │   └── androidTest/                                  # Integration tests
│   └── build.gradle
│
├── utils/                             # Utility library
│   ├── src/main/java/
│   │   └── com/bala/screenreader/utils/
│   │       ├── logger/                # Logging utilities
│   │       ├── helpers/               # Helper functions
│   │       ├── preferences/           # Preference helpers
│   │       └── constants/             # Constants
│   └── build.gradle
│
├── braille/                           # Braille support modules
│   ├── common/                        # Common braille code
│   ├── interfaces/                    # Braille interface definitions
│   ├── brailleime/                   # Braille input method editor
│   ├── brailleimeanalytics/          # Analytics for braille IME
│   ├── translate/                    # Braille translation
│   ├── brailledisplay/               # Braille display driver
│   ├── brailledisplayanalytics/      # Analytics for display
│   └── brltty/                       # BRLTTY library integration
│
├── material/                          # Material Design components
│   ├── flags/                         # Feature flags
│   ├── theme/                         # Material theme
│   ├── preference/                    # Material preferences
│   │   ├── compose/                  # Jetpack Compose preferences
│   │   └── build.gradle
│   └── build.gradle
│
├── proguard/                          # ProGuard configuration
│   ├── src/main/java/                # ProGuard rules
│   └── build.gradle
│
├── build.gradle                       # Main build configuration
├── settings.gradle                    # Module includes
├── shared.gradle                      # Shared build settings
├── version.gradle                     # Version definitions
├── build.sh                           # Build script
├── gradlew                            # Gradle wrapper
├── gradlew.bat                        # Gradle wrapper (Windows)
├── gradle.properties                  # Gradle properties
├── .gitignore                         # Git ignore rules
├── README.md                          # Project overview
├── SETUP.md                           # Setup guide
├── CONTRIBUTING.md                    # Contribution guidelines
├── GETTING_STARTED.md                 # Quick start guide
├── LICENSE                            # Apache 2.0 License
└── PROJECT_STRUCTURE.md              # This file
```

## Module Descriptions

### Core Modules

#### `talkback/`
**Main Screen Reader Implementation**

- **BalaScreenReaderService**: Extends `AccessibilityService` to intercept system events
- **Gesture Detection**: Interprets touch gestures (swipes, taps, long-press)
- **Navigation**: Manages focus and navigation through UI elements
- **Feedback**: Provides audio (TTS) and haptic feedback
- **Settings**: User preferences and configuration

Key Classes:
```
talkback/src/main/java/com/bala/screenreader/
├── BalaScreenReaderService.java       # Main service
├── gesture/
│   ├── GestureDetector.java          # Gesture detection
│   ├── GestureMapping.java           # Gesture to action mapping
│   └── GestureHandler.java           # Gesture handling logic
├── tts/
│   ├── TextToSpeechManager.java      # TTS management
│   └── SpeechController.java         # Speech control
├── navigation/
│   ├── Navigator.java                # Navigation controller
│   ├── FocusManager.java             # Focus management
│   └── TreeNavigator.java            # UI tree navigation
└── feedback/
    ├── FeedbackManager.java          # Feedback coordination
    ├── HapticFeedback.java           # Vibration feedback
    └── AudioFeedback.java            # Audio cues
```

#### `utils/`
**Shared Utilities**

- Logger utilities
- Preference helpers
- Constants definitions
- Helper functions

#### `braille/`
**Braille Support**

Multiple modules for complete braille support:
- `brailleime/` - Braille input method
- `brailledisplay/` - Display driver for braille devices
- `translate/` - Braille translation engine
- `brltty/` - BRLTTY library integration

#### `material/`
**Material Design Components**

- `theme/` - Material Design theme
- `preference/` - Preference UI components
- `preference/compose/` - Jetpack Compose implementation
- `flags/` - Feature flags UI

## Build System

### Gradle Configuration Files

1. **build.gradle** - Main build configuration
2. **settings.gradle** - Module includes and paths
3. **shared.gradle** - Shared settings for all modules
4. **version.gradle** - Version definitions
5. **gradle.properties** - Gradle system properties

### Build Flavors

```gradle
productFlavors {
    phone {              // Regular Android
        dimension "target"
    }
    wear {               // Android Wear
        dimension "target"
        versionNameSuffix "-wear"
    }
}
```

## Resource Structure

### Drawable Resources
```
res/drawable/
├── icon.png                # App icon
├── ic_accessibility.png    # Accessibility icon
└── [other app icons]
```

### Layout Resources
```
res/layout/
├── activity_main.xml
├── activity_settings.xml
├── dialog_preferences.xml
└── [other layouts]
```

### String Resources
```
res/values/
├── strings.xml             # English strings
├── strings-es.xml          # Spanish strings (if added)
└── [other languages]
```

### Configuration
```
res/xml/
├── accessibilityservice.xml     # Accessibility service config
├── preferences.xml              # Preference screen layout
└── file_paths.xml              # File provider paths
```

## Data Flow

```
Android System Events
        ↓
AccessibilityService (BalaScreenReaderService)
        ↓
GestureDetector + EventProcessor
        ↓
Navigator (handles focus)
        ↓
UI Tree Traversal
        ↓
FeedbackManager
        ├→ TextToSpeech (audio feedback)
        ├→ HapticFeedback (vibration)
        └→ SoundPool (audio cues)
        ↓
User receives feedback
```

## Dependencies

### Major Libraries

- **AndroidX** - Modern Android libraries
- **Material Design** - UI components
- **Kotlin** - Language and coroutines
- **Braille** - Braille input/display support
- **Google AI/ML** - AI features

## Testing Structure

```
talkback/
├── src/test/           # Unit tests
│   └── java/
│       └── com/bala/screenreader/
│           └── [test classes]
│
└── src/androidTest/    # Integration tests
    └── java/
        └── com/bala/screenreader/
            └── [instrumentation tests]
```

## Development Workflow

1. **Choose a module** to work on
2. **Make changes** in Java/Kotlin code
3. **Update resources** if needed (strings, layouts, etc.)
4. **Add tests** in test directories
5. **Build and test** using `./build.sh`
6. **Commit and push** changes

## Important Files

| File | Purpose |
|------|----------|
| `AndroidManifest.xml` | App permissions, services, activities |
| `BalaScreenReaderService.java` | Main service class |
| `build.gradle` | Build configuration |
| `settings.gradle` | Module configuration |
| `shared.gradle` | Common build settings |
| `version.gradle` | Version numbers |

## Building

### Debug Build
```bash
./gradlew assembleDebug
```

### Release Build
```bash
./gradlew assembleRelease
```

### Complete Build
```bash
./build.sh
```

## Next Steps

1. Explore each module
2. Understand the data flow
3. Review accessibility service documentation
4. Start developing features
5. Run tests regularly

---

For more information, see [README.md](README.md) and [GETTING_STARTED.md](GETTING_STARTED.md).
