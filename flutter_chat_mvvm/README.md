# Flutter Chat MVVM

This is a simple chat application built using Flutter, following the MVVM (Model-View-ViewModel) architecture and utilizing Riverpod for state management.

## Project Structure

```
flutter_chat_mvvm
├── lib
│   ├── main.dart               # Entry point of the application
│   ├── models
│   │   └── message.dart        # Defines the Message model
│   ├── viewmodels
│   │   └── chat_viewmodel.dart  # Manages chat state and logic
│   ├── views
│   │   └── chat_view.dart      # Main UI for the chat application
│   ├── providers
│   │   └── chat_provider.dart   # Provides access to the ChatViewModel
│   └── widgets
│       └── message_bubble.dart  # Displays individual chat messages
├── pubspec.yaml                # Project configuration and dependencies
└── README.md                   # Project documentation
```

## Setup Instructions

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd flutter_chat_mvvm
   ```

2. **Install dependencies:**
   ```
   flutter pub get
   ```

3. **Run the application:**
   ```
   flutter run
   ```

## Usage Guidelines

- The application allows users to send and receive chat messages.
- Messages are displayed in a bubble format, enhancing the chat experience.
- The state management is handled using Riverpod, ensuring a reactive and efficient UI.

## Features

- Real-time chat interface
- Message bubbles for better readability
- MVVM architecture for clean code separation

Feel free to contribute to the project by submitting issues or pull requests!