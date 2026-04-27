# 📱 Bal Sanskar Varga Pune App

A Flutter-based mobile application developed for **Bal Sanskar Varga Pune** to manage announcements, activities, and online class links for students in a simple and automated way.

---

## 🚀 Features

* 📢 **Real-time Announcements** using Firebase Firestore
* 🖼 **Activity Gallery** with dynamic image updates
* 🔗 **Google Meet Links** for online classes
* 🔔 **Notification System** for new updates
* 🌈 **Animated Dashboard UI** for better user experience

---

## 🧠 System Flow

```
Google Form → Google Apps Script → Firebase Firestore → Flutter App
```

* Teachers submit updates via Google Form
* Apps Script sends data to Firestore
* App fetches data in real-time and displays it

---

## 🛠 Tech Stack

* **Frontend:** Flutter (Dart)
* **Backend:** Firebase Firestore
* **Automation:** Google Apps Script
* **Other Packages:**

  * firebase_core
  * cloud_firestore
  * firebase_messaging
  * cached_network_image
  * url_launcher

---

## ⚙️ Setup Instructions

1. Clone the repository:

```
git clone https://github.com/your-username/sanskar-varga-app.git
```

2. Navigate to the project:

```
cd sanskar-varga-app
```

3. Install dependencies:

```
flutter pub get
```

4. Add Firebase configuration:

* Place your `google-services.json` inside:

```
android/app/
```

5. Run the app:

```
flutter run
```

---

## 🔐 Note

Firebase configuration files are not included for security reasons.
Please add your own Firebase project credentials.

---

## 📦 Build APK

To generate APK:

```
flutter build apk
```

APK location:

```
build/app/outputs/flutter-apk/app-release.apk
```

---

## 🎯 Future Improvements

* 📹 Video support in activities
* 🔔 Background push notifications
* 🖼 Fullscreen image viewer
* 👤 Admin panel for teachers

---


## 📜 License

This project is licensed under the MIT License.
