```markdown
# Pocket Tasks

**Pocket Tasks** is a clean, modern, and responsive Flutter task manager app.  
It allows users to create, edit, and manage tasks with features like due dates, notes, filtering, sorting, and completion tracking — all with persistent local storage.

---

## Features

- Add, Edit, and Delete Tasks  
- Mark Tasks as Completed  
- Assign Due Dates  
- Filter by All, Completed, or Active  
- Sort Tasks by Creation or Due Date  
- Real-Time Search for Tasks by Title  
- Notes per Task with Ellipsis Preview  
- Undo Task Deletion via SnackBar  
- Dynamic Empty State Messaging  
- Light/Dark Mode Toggle  
- Splash Screen with Catchy Text  
- Local Storage using Hive  
- State Management via Riverpod  
- Smooth UI Animations and Transitions  

---

## Tech Stack

- **Flutter** 3.22 or higher  
- **Dart** with null safety  
- **Hive** for local storage  
- **Flutter Riverpod** for state management  
- **Intl** for date formatting  
- **Shared Preferences** for theme persistence

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

````

---

## Getting Started

```bash
flutter pub get
flutter run
````

---

## Author

**Built by:**  Joseph Uzor