
# ☕ Brew Crew (Flutter + Firebase)

A reactive Flutter application demonstrating **Firebase Authentication**, **Cloud Firestore**, and **Provider-based state management using streams**.

This project is designed to showcase **clean architecture**, **real-time updates**, and **efficient Flutter patterns** — not just UI.

---

## 🚀 Features

- 🔐 Firebase Authentication (Anonymous / Email)
- 🔄 Real-time Firestore updates using Streams
- 🧠 Provider & StreamProvider for state management
- 🎨 Dynamic UI updates without manual refresh
- ⚙️ User-specific settings (name, sugars, strength)
- ⭐ Highlight current user’s brew efficiently

---

## 🧱 Architecture Overview

The app follows a **reactive, layered architecture**:

```

UI (Widgets)
↓
State Management (Provider / StreamProvider)
↓
Firebase (Auth + Firestore)

````

### Why this matters

- No manual state syncing
- No `setState()` for backend data
- UI always reflects backend truth

---

## 🔐 Authentication Flow

### AuthService

```dart
Stream<AppUser?> get user {
  return _auth.authStateChanges().map(_userFromFirebaseUser);
}
````

- Firebase emits auth state changes as a **stream**
- Converts Firebase `User` → custom `AppUser`

---

### Global Auth State (main.dart)

```dart
StreamProvider<AppUser?>.value(
  value: AuthService().user,
  initialData: null,
  child: MaterialApp(...)
)
```

- Makes authentication state available across the entire app

---

### Wrapper Logic

```dart
final user = Provider.of<AppUser?>(context);
return user == null ? Authenticate() : Home();
```

✔ Automatically navigates based on auth state
✔ No manual routing logic needed

---

## ☕ Brew Data Flow (Firestore → UI)

### Firestore Stream

```dart
Stream<List<Brew>> get brews {
  return brewCollections.snapshots().map(_brewListFromSnapshot);
}
```

- `snapshots()` provides **real-time updates**
- Any Firestore change → UI rebuilds instantly

---

### Injecting Brew Stream

```dart
StreamProvider<List<Brew>>.value(
  value: DatabaseService().brews,
  initialData: [],
  child: Scaffold(...)
)
```

- Brew data is now accessible anywhere under `Home`

---

### Consuming Brew Data

```dart
final brews = Provider.of<List<Brew>>(context);
```

✔ List updates automatically
✔ No refresh button
✔ No `setState()`

---

## ⚙️ User Settings (Per-user Stream)

### Firestore Document Stream

```dart
Stream<UserData> get userData {
  return brewCollections.doc(uid).snapshots().map(_userDataFromSnapshot);
}
```

- Listens only to the **current user’s document**

---

### SettingsForm

```dart
StreamBuilder<UserData>(
  stream: DatabaseService(uid: user.uid).userData,
```

- Form fields update live
- Pressing **Update**:

  - Firestore document updates
  - Stream emits new value
  - UI rebuilds automatically

---

## 🧠 How Streams Work (Mental Model)

```
Firebase emits data
      ↓
Stream (Auth / Brews / UserData)
      ↓
StreamProvider / StreamBuilder
      ↓
Provider.of<T>(context)
      ↓
Widget rebuilds automatically
```

### Key Principles

- Streams **push** data
- Widgets **react**
- Flutter rebuilds **only what depends on that data**

---

## 🛠 Tech Stack

- Flutter
- Firebase Authentication
- Cloud Firestore
- Provider
- Material UI

---

## 📌 What This Project Demonstrates

- Real-world Flutter architecture
- Reactive programming mindset
- Efficient Firebase usage
- Scalable UI patterns

---

## 🚀 Future Improvements

- Firestore query optimization
- Animations for list updates
- Offline persistence
- Unit & widget tests

---

## 👨‍💻 Author

**Vaibhav Kumar**

> Learning Flutter with a focus on *architecture, not just UI*.

---

⭐ If you like this project, consider starring the repository!