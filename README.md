# 🚀 QR Create - A Modern QR Code Generator

QR Create is a powerful **QR Code Generator** built with **Flutter**. It provides a seamless experience for creating, storing, and managing QR codes efficiently.

## 📌 Features

👉 Generate QR codes for **text, Wifi password, URLs, emails, contacts, and more**\
👉 Save & organize **QR code history**\
👉 **Dark & Light Mode** with a modern UI\
👉 Securely **store QR codes offline**\
👉 **Share QR codes** effortlessly\
👉 Built with **clean architecture** for scalability

---

## 📁 Folder Structure

```
lib/
│── config/          # App-wide configurations
│   ├── theme.dart   # Light & Dark mode themes
│
│── presentation/    # UI & state management
│   ├── pages/       # Screens (Home, History, Settings)
│   ├── widgets/     # Reusable UI components
│
│── providers/       # Hooks Riverpod state management
│
│── main.dart        # Entry point

assets/
│── images/         # App icons & assets
│── fonts/          # Custom fonts (Montserrat)
```

---

## ⚡ State Management

QR Create is powered by **Hooks Riverpod**, ensuring:\
📌 **Scalability & performance optimization**\
📌 **Efficient dependency injection**\
📌 **Separation of concerns (clean architecture)**

```dart
final qrProvider = StateProvider<String?>((ref) => null);
```

---

## 🛠️ Dependencies

| **Dependency**   | **Purpose**         |
| ---------------- | ------------------- |
| `hooks_riverpod` | State management    |
| `flutter_hooks`  | React-style hooks   |
| `qr_flutter`     | QR code generation  |
| `path_provider`  | Local storage       |
| `share_plus`     | Sharing QR codes    |
| `screenshot`     | QR code screenshots |

---

## 🎨 Theming

🌙 **Dark Mode**: Black & Purple\
🌞 **Light Mode**: White & Purple\
🎨 **Primary Colors**: `#6B4B94`, `#1E2B6F`

```dart
ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF6B4B94),
);
```

---

## 🚀 Getting Started

### 1️⃣ Clone the repo

```sh
git clone https://github.com/xDAREY/qr_create.git
cd qr_create
```

### 2️⃣ Install dependencies

```sh
flutter pub get
```

### 3️⃣ Run the app

```sh
flutter run
```

---

## 📷 Screenshot
![Homepage](https://github.com/user-attachments/assets/e28b98c1-efe7-4fe2-853f-6b0f984aeecc)
![QR Code History](https://github.com/user-attachments/assets/bfefe938-8fa7-40ab-bfb4-3fc91019e78f)

---

## 🤝 Contributing

Pull requests are welcome!

1. **Fork the repo**
2. Create a feature branch:
   ```sh
   git checkout -b feature/new-feature
   ```
3. Commit changes:
   ```sh
   git commit -m "Added new feature"
   ```
4. Push to your branch:
   ```sh
   git push origin feature/new-feature
   ```
5. Open a **pull request**

---

## 📝 License

This project is licensed under the **MIT License**.

