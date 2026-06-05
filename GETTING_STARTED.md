# Getting Started with Bala Screen Reader

A quick start guide to begin developing on the Bala Screen Reader project.

## Quick Setup (5 minutes)

### 1. Clone the Repository
```bash
git clone https://github.com/bala554/Bala-screen-reader.git
cd Bala-screen-reader
```

### 2. Install Dependencies
```bash
chmod +x gradlew
./gradlew clean build
```

### 3. Build APK
```bash
./build.sh
```

### 4. Install on Device
```bash
adb install -r build/outputs/apk/debug/app-debug.apk
```

### 5. Enable Screen Reader
- Go to **Settings** → **Accessibility** → **Bala Screen Reader** → Toggle **ON**

## Project Structure Overview

```
Bala-screen-reader/
├── talkback/              # 🎯 Main screen reader module
├── utils/                 # 🛠️ Utilities and helpers
├── brailledisplay/        # 📱 Braille display support
├── build.gradle           # Gradle configuration
├── build.sh              # Build script
├── README.md             # Full documentation
├── SETUP.md              # Detailed setup guide
├── CONTRIBUTING.md       # Contribution guidelines
└── GETTING_STARTED.md    # This file
```

## Key Concepts

### AccessibilityService
The foundation of the screen reader. It intercepts system events and provides feedback.

```java
public class ScreenReaderService extends AccessibilityService {
    @Override
    public void onAccessibilityEvent(AccessibilityEvent event) {
        // Process accessibility events here
    }
}
```

### Gesture Navigation
Touch gestures control the screen reader. Common gestures:
- **Single tap:** Focus on item
- **Double tap:** Activate item
- **Swipe right:** Next item
- **Swipe left:** Previous item
- **Swipe up:** Next group
- **Swipe down:** Previous group

### Text-to-Speech (TTS)
Provides audio feedback. Initialized and managed through TextToSpeech engine.

```java
TextToSpeech tts = new TextToSpeech(context, new TextToSpeech.OnInitListener() {
    @Override
    public void onInit(int status) {
        if (status == TextToSpeech.SUCCESS) {
            tts.speak("Text", TextToSpeech.QUEUE_ADD, null);
        }
    }
});
```

## Common Tasks

### Adding a New Feature

1. **Create a branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make changes** in the appropriate module

3. **Test locally:**
   ```bash
   ./gradlew test
   ./build.sh
   ```

4. **Commit and push:**
   ```bash
   git add .
   git commit -m "[feature] Add your feature description"
   git push origin feature/your-feature-name
   ```

5. **Create a Pull Request**

### Debugging

#### View Logs
```bash
adb logcat | grep "ScreenReader"
```

#### Debug APK
```bash
./gradlew assembleDebug
adb install -r build/outputs/apk/debug/app-debug.apk
```

#### Android Studio Debugger
1. Click **Run** → **Debug 'app'**
2. Set breakpoints by clicking line numbers
3. Step through code to debug

### Testing

```bash
# Unit tests
./gradlew test

# Integration tests on device
./gradlew connectedAndroidTest

# Run specific test
./gradlew test --tests "com.bala.screenreader.*"
```

## File Navigation Guide

| File | Purpose |
|------|---------|
| `build.gradle` | Project build configuration |
| `build.sh` | APK build script |
| `talkback/src/main/AndroidManifest.xml` | App permissions & components |
| `talkback/src/main/java/` | Java source code |
| `talkback/src/main/res/` | Resources (strings, layouts, etc.) |

## Useful Commands

```bash
# Clean build
./gradlew clean

# Build without running tests
./gradlew assemble

# Run lint checks
./gradlew lint

# Update gradle
./gradlew wrapper --gradle-version 8.11.1

# View project dependencies
./gradlew dependencies
```

## Android Fundamentals

### Services
Background processes that can run without UI. ScreenReader runs as an AccessibilityService.

### Accessibility Events
Events fired by the system (button clicked, text changed, etc.) that AccessibilityService intercepts.

### Permissions
Required permissions for the screen reader:
- `RECORD_AUDIO` - For voice input
- `INTERNET` - For online features
- `VIBRATE` - For haptic feedback

## Testing on Device

### Setup Device
1. Enable Developer Mode:
   - Settings → About Phone → Tap "Build Number" 7x
   
2. Enable USB Debugging:
   - Settings → Developer Options → USB Debugging

3. Connect via USB and authorize computer

### Install and Test
```bash
# List connected devices
adb devices

# Install APK
adb install build/outputs/apk/debug/app-debug.apk

# View real-time logs
adb logcat

# Uninstall app
adb uninstall com.bala.screenreader
```

## Performance Tips

1. **Use efficient data structures** - HashMap for O(1) lookup
2. **Avoid blocking main thread** - Use background threads/coroutines
3. **Minimize memory usage** - Release resources when done
4. **Test on low-end devices** - Ensure broad compatibility
5. **Monitor battery impact** - Use battery profiler in Android Studio

## Useful Resources

- [Android Accessibility Guide](https://developer.android.com/guide/topics/ui/accessibility)
- [AccessibilityService Documentation](https://developer.android.com/reference/android/accessibilityservice/AccessibilityService)
- [Android Studio User Guide](https://developer.android.com/studio/intro)
- [Kotlin Documentation](https://kotlinlang.org/docs/)
- [Google TalkBack Source](https://github.com/google/talkback)

## Common Issues

### App Crashes Immediately
- Check Android version compatibility
- Verify permissions in AndroidManifest.xml
- Check logcat for error messages

### Screen Reader Not Speaking
- Ensure TTS engine is installed
- Check volume settings
- Verify microphone permissions

### Build Fails
- Run `./gradlew clean`
- Update SDK: `$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --update`
- Check Java version: `java -version` (should be 11+)

### Gesture Navigation Not Working
- Enable accessibility service completely
- Restart device
- Ensure screen is unlocked

## Next Steps

1. ✅ Read the full [README.md](README.md)
2. ✅ Follow [SETUP.md](SETUP.md) for environment setup
3. ✅ Review [CONTRIBUTING.md](CONTRIBUTING.md)
4. ✅ Explore the codebase in `talkback/src/main/java/`
5. ✅ Build your first APK
6. ✅ Start developing!

## Getting Help

- 📚 Check existing documentation
- 🐛 Search [GitHub Issues](../../issues)
- 💬 Ask in PR comments
- 📖 Read Android documentation
- 🔗 Explore Google TalkBack source code

---

**Ready to code? Start with:**
```bash
git checkout -b feature/my-first-feature
```

**Happy developing! 🚀**
