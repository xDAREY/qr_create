🚀 QR Create - A Modern QR Code Generator



📖 About
QR Create is a powerful QR Code Generator built with Flutter. It provides a seamless experience for creating, storing, and managing QR codes efficiently.

✅ Generate QR codes for text, URLs, emails, contacts, and more
✅ Save & organize QR code history
✅ Dark & Light Mode with a modern UI
✅ Securely store QR codes offline
✅ Share QR codes effortlessly
✅ Built with clean architecture for scalability

🏗️ Folder Structure
bash
Copy
Edit
lib/
│── config/                # App-wide configurations  
│   ├── theme.dart         # Light & Dark mode themes  
│── presentation/          # UI & state management  
│   ├── pages/             # Screens (Home, History, Settings)  
│   ├── widgets/           # Reusable UI components  
│── providers/         # Hooks Riverpod state management  
│── main.dart              # Entry point  
assets/  
│── images/                # App icons & assets  
│── fonts/                 # Custom fonts (Montserrat)  
⚡ State Management
QR Create is powered by Hooks Riverpod, ensuring:
📌 Scalability & performance optimization
📌 Efficient dependency injection
📌 Separation of concerns (clean architecture)

dart
Copy
Edit
final qrProvider = StateProvider<String?>((ref) => null);
🛠️ Dependencies
State Management: hooks_riverpod
React-style Hooks: flutter_hooks
QR Code Generation: qr_flutter
Local Storage: path_provider
Sharing QR Codes: share_plus
QR Code Screenshots: screenshot
yaml
Copy
Edit
dependencies:
  flutter_hooks: ^0.21.2
  hooks_riverpod: ^2.6.1
  qr_flutter: ^4.1.0
  path_provider: ^2.1.5
  share_plus: ^10.1.4
  screenshot: ^3.0.0
🎨 Theming
🌙 Dark Mode: Black & Purple
☀️ Light Mode: White & Purple
🎨 Primary Colors: #6B4B94, #1E2B6F

dart
Copy
Edit
ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF6B4B94),
);
🚀 Getting Started
1️⃣ Clone the repo

bash
Copy
Edit
git clone https://github.com/yourusername/qr_create.git
cd qr_create
2️⃣ Install dependencies

bash
Copy
Edit
flutter pub get
3️⃣ Run the app

bash
Copy
Edit
flutter run
📷 Screenshots
Light Mode	Dark Mode
🤝 Contributing
Pull requests are welcome!

Fork the repo
Create a feature branch (git checkout -b feature/new-feature)
Commit changes (git commit -m "Added new feature")
Push to your branch (git push origin feature/new-feature)
Open a pull request
📜 License
This project is licensed under the MIT License.