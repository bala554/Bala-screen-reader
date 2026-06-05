# Download and Integrate TalkBack Source Code

## Quick Setup

This document provides step-by-step instructions to download the complete Google TalkBack source code and integrate it into your Bala Screen Reader project.

## Prerequisites

- Git installed
- Bash shell (Linux, macOS, or WSL for Windows)
- At least 2GB free disk space
- GitHub account (optional, for authentication)

## Method 1: Using Git Clone + Copy (Recommended)

### Step 1: Clone Google TalkBack Repository

```bash
cd ~
git clone --depth 1 https://github.com/google/talkback.git temp-talkback
```

**Note:** `--depth 1` reduces download size by only getting the latest commit.

### Step 2: Navigate to Your Project

```bash
cd /path/to/Bala-screen-reader
```

### Step 3: Create Missing Directories

```bash
mkdir -p braille/{common,interfaces,brailleime,brailledisplay,brailleimeanalytics,translate,brltty}
mkdir -p material/{flags,preference,theme}
mkdir -p proguard/src/main/java
mkdir -p utils/src/main/java
```

### Step 4: Copy Core Modules

```bash
# Copy braille modules
cp -r ~/temp-talkback/braille/common ~/temp-talkback/braille/common/src braille/common/ 2>/dev/null
cp -r ~/temp-talkback/braille/interfaces/build.gradle ~/temp-talkback/braille/interfaces/src braille/interfaces/ 2>/dev/null
cp -r ~/temp-talkback/braille/brailleime/build.gradle ~/temp-talkback/braille/brailleime/src braille/brailleime/ 2>/dev/null
cp -r ~/temp-talkback/braille/brailledisplay/build.gradle ~/temp-talkback/braille/brailledisplay/src braille/brailledisplay/ 2>/dev/null
cp -r ~/temp-talkback/braille/brailleimeanalytics/build.gradle ~/temp-talkback/braille/brailleimeanalytics/src braille/brailleimeanalytics/ 2>/dev/null
cp -r ~/temp-talkback/braille/translate/build.gradle ~/temp-talkback/braille/translate/src braille/translate/ 2>/dev/null
cp -r ~/temp-talkback/braille/brltty/build.gradle ~/temp-talkback/braille/brltty/src braille/brltty/ 2>/dev/null

# Copy material modules
cp -r ~/temp-talkback/material/flags/build.gradle ~/temp-talkback/material/flags/src material/flags/ 2>/dev/null
cp -r ~/temp-talkback/material/preference/build.gradle ~/temp-talkback/material/preference/src material/preference/ 2>/dev/null
cp -r ~/temp-talkback/material/preference/compose ~/temp-talkback/material/preference/compose/src material/preference/ 2>/dev/null
cp -r ~/temp-talkback/material/theme/build.gradle ~/temp-talkback/material/theme/src material/theme/ 2>/dev/null

# Copy utils and proguard
cp -r ~/temp-talkback/utils/build.gradle ~/temp-talkback/utils/src utils/ 2>/dev/null
cp -r ~/temp-talkback/proguard/build.gradle ~/temp-talkback/proguard/src proguard/ 2>/dev/null
```

### Step 5: Copy TalkBack Main Module (Already Done)

The main talkback module was already integrated. If needed:

```bash
cp -r ~/temp-talkback/talkback/build.gradle talkback/ 2>/dev/null
cp -r ~/temp-talkback/talkback/src talkback/ 2>/dev/null
cp -r ~/temp-talkback/talkback/res talkback/ 2>/dev/null
```

### Step 6: Clean Up

```bash
rm -rf ~/temp-talkback
```

### Step 7: Sync Gradle

```bash
# Make gradlew executable
chmod +x gradlew

# Sync Gradle
./gradlew clean
./gradlew build --info
```

---

## Method 2: Download as ZIP

### Step 1: Download ZIP

```bash
cd /tmp
wget https://github.com/google/talkback/archive/refs/heads/master.zip
unzip master.zip
cd talkback-master
```

### Step 2: Copy to Your Project

Follow steps 2-7 from Method 1 above.

---

## Method 3: Git Subtree (Advanced)

### Add as Subtree

```bash
cd /path/to/Bala-screen-reader
git subtree add --prefix talkback-source https://github.com/google/talkback.git master --squash
```

### Copy from Subtree

```bash
cp -r talkback-source/braille/* braille/
cp -r talkback-source/material/* material/
cp -r talkback-source/utils/* utils/
cp -r talkback-source/proguard/* proguard/
```

### Clean Up Subtree

```bash
rm -rf talkback-source
```

---

## Troubleshooting

### Error: "Module 'braille' not found"

**Solution:** Ensure all braille subdirectories have `build.gradle` files:

```bash
for dir in braille/*; do
  if [ -d "$dir" ] && [ ! -f "$dir/build.gradle" ]; then
    echo "apply plugin: 'com.android.library'" > "$dir/build.gradle"
    echo "apply from: \"../shared.gradle\"" >> "$dir/build.gradle"
  fi
done
```

### Error: "Gradle sync failed"

**Solution:** Clear Gradle cache:

```bash
./gradlew clean
rm -rf .gradle/
./gradlew build --refresh-dependencies
```

### Error: "Cannot resolve symbol"

**Solution:** Ensure Android SDK is installed:

```bash
# Check Android SDK version
ls $ANDROID_HOME/platforms/

# Install missing SDK version
$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;android-36"
```

### Error: "Build directory structure missing"

**Solution:** Create standard Android project structure:

```bash
for module in utils proguard braille/* material/*; do
  mkdir -p "$module/src/main/java"
  mkdir -p "$module/src/main/res/values"
  mkdir -p "$module/src/main/res/drawable"
  mkdir -p "$module/src/test/java"
  mkdir -p "$module/src/androidTest/java"
done
```

---

## Verification

### Check Directory Structure

```bash
tree -L 2 -d
```

Expected output:

```
.
├── braille
│   ├── brailledisplay
│   ├── brailledisplayanalytics
│   ├── brailleime
│   ├── brailleimeanalytics
│   ├── brltty
│   ├── common
│   ├── interfaces
│   └── translate
├── material
│   ├── flags
│   ├── preference
│   └── theme
├── proguard
├── talkback
├── utils
├── build.gradle
├── settings.gradle
├── shared.gradle
├── version.gradle
└── gradle.properties
```

### Verify Gradle Configuration

```bash
./gradlew clean
./gradlew tasks
```

### Build Debug APK

```bash
./gradlew assembleDebug
```

Success! Look for:
```
Build completed successfully
```

---

## Next Steps

1. ✅ Download the TalkBack source code
2. ✅ Integrate modules into your project
3. ✅ Build your first APK
4. ✅ Test on Android device
5. ✅ Customize for Bala Screen Reader

---

## Support

- **Google TalkBack Issues:** https://github.com/google/talkback/issues
- **Android Accessibility Docs:** https://developer.android.com/guide/topics/ui/accessibility
- **Gradle Documentation:** https://docs.gradle.org

---

**Happy Building! 🚀**
