# Meme Editor App 🖼️🔥

A simple, offline-first Flutter application that lets users edit memes by adding custom text or stickers (emoji), reposition them freely, and export the result to local storage or share it using native Android intent.

---

## ✨ Features

- ✅ Fetches memes from API and caches them offline using Hive
- ✅ Add draggable text overlays
- ✅ Add emoji stickers
- ✅ Undo/Redo support
- ✅ Export meme as image
- ✅ Save image to internal storage
- ✅ Share edited meme via native Android intent
- ✅ Offline support

---

## 📦 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/meme_editor_app.git
   cd meme_editor_app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate Hive TypeAdapters (if needed):**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📱 Build APK

To generate a release APK:
```bash
flutter build apk --release
```

---

## 🧪 Running Unit Tests

To run the unit test:
```bash
flutter test test/detail_viewmodel_test.dart
```

---


## 📂 Saved Image Location

Saved memes are stored in:

```
/Android/data/com.example.meme_editor_app/files/MyImages
```

Note: This folder is **not visible in the gallery by default**. You can view the images using a file manager app.

---

## 🎥 Showcase Video
 
Link: https://drive.google.com/file/d/1P1AqUBxpGAVRf3NHaZc3qcJ3GEUosc7Y/view?usp=drivesdk

---

## 🔒 Permissions Required

This app may request the following permissions at runtime:
- `READ_EXTERNAL_STORAGE`
- `WRITE_EXTERNAL_STORAGE`  

---

## 💡 Notes

- Tested for Android
- iOS has not been tested due to device unavailability

---

## 📄 License

MIT License  
© 2025 Irfan Ramadhiya
