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

## 📂 Saved Image Location

Saved memes are stored in:

```
/storage/emulated/0/Android/data/<your.package.name>/files/MyImages/
```

This is **not the Gallery** by default. You can access it via:
- A file explorer app
- Connecting your device to a PC
- Or programmatically adding it to the MediaStore (planned feature)

---

## 🎥 Showcase Video

Coming soon!  
🚧 Link: [YouTube - Meme Editor App Demo](https://youtu.be/YOUR_VIDEO_ID) *(Replace with actual link when ready)*

---

## 🔒 Permissions Required

This app may request the following permissions at runtime:
- `READ_EXTERNAL_STORAGE`
- `WRITE_EXTERNAL_STORAGE`  
(Only on Android; used for saving images to local storage)

---

## 💡 Notes

- Designed and tested for Android
- iOS support not tested (may require additional configuration for file saving/sharing)

---

## 🤝 Contributions

Pull requests are welcome! If you have ideas or want to extend the app (e.g. GIF support, cloud export), feel free to fork and submit PRs.

---

## 📄 License

MIT License  
© 2025 [Your Name or Organization]
