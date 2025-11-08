# Pocket Tasks

A clean, modern, and responsive Flutter task manager app.  
Users can create, edit, and manage tasks with due dates, notes, filtering, sorting, and completion tracking — all backed by persistent local storage.

---

## Features

- Add, edit, and delete tasks  
- Mark tasks as completed  
- Assign due dates  
- Filter tasks by: All, Completed, or Active  
- Sort tasks by creation date or due date  
- Real-time search by task title  
- Attach notes to tasks (with truncated preview)  
- Undo task deletion via SnackBar  
- Dynamic empty state messages  
- Light/dark mode toggle  
- Splash screen with animated text  
- Local storage using Hive  
- State management via Riverpod  
- Smooth UI animations and transitions  

---

## Tech Stack

- **Flutter**: 3.22 or higher  
- **Dart**: Null-safe  
- **Hive**: Local NoSQL storage  
- **Flutter Riverpod**: State management  
- **intl**: Date formatting utilities  
- **shared_preferences**: Theme mode persistence  

---

## Project Structure

```
lib/
├── core/
│   └── theme.dart
├── data/
│   └── local_storage.dart
├── models/
│   └── task_model.dart
├── providers/
│   ├── task_provider.dart
│   └── theme_provider.dart
├── screens/
│   ├── splash_screen.dart
│   ├── add_edit_screen.dart
│   └── task_list_screen.dart
├── utils/
│   └── enums.dart
├── widgets/
│   ├── filter_buttons.dart
│   └── task_tile.dart
└── main.dart
```

---

## Getting Started

1. Clone the repository  
2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

Ensure you have Flutter 3.22+ and Dart SDK ≥ 3.0 installed.

---

## Author

Built by Joseph Uzor
```