# News App

## 📱 Project Description

A Flutter news application that fetches articles from the News API, displaying them in a clean, responsive interface. The app features:

- News article listing with titles, images, and dates
- Article detail view with full content
- Search functionality to filter news
- Offline caching using Hive for persistent storage
- Error handling and loading states
- Clean, modern UI with responsive design

The app is built following Clean Architecture principles and SOLID design patterns for maintainability, scalability, and testability.

## 📁 Folder Structure Explanation

```
lib/
├── core/                     # Core functionality used across the app
│   ├── constants/            # Application-wide constants
│   ├── errors/               # Custom error types and exceptions
│   ├── network/              # Network-related utilities
│   ├── usecases/             # Base use case abstraction
│   └── utils/                # Helper functions and utilities
│
├── features/                 # Feature-specific code
│   └── news/                 # News feature module
│       ├── data/             # Data layer implementation
│       │   ├── datasources/  # Data sources (remote and local)
│       │   ├── models/       # Data transfer objects (DTOs)
│       │   └── repositories/ # Repository implementations
│       │
│       ├── domain/           # Domain layer (business logic)
│       │   ├── entities/     # Business entities
│       │   ├── repositories/ # Repository interfaces
│       │   └── usecases/     # Application-specific use cases
│       │
│       └── presentation/     # Presentation layer (UI)
│           ├── bloc/         # State management (BLoC)
│           ├── pages/        # Screen widgets
│           └── widgets/      # Reusable UI components
│
└── injection_container.dart  # Dependency injection setup
```

## 🏗️ Clean Architecture Implementation

The app follows Clean Architecture with three main layers:

### 1. Domain Layer (Business Logic)
- Contains enterprise-wide business rules
- Includes entities (business objects) and use cases
- Defines abstract repository interfaces
- Completely framework-independent

### 2. Data Layer (Implementation Details)
- Implements repository interfaces from Domain layer
- Handles data sources (API, local cache)
- Contains DTOs for data serialization
- Depends only on Domain layer

### 3. Presentation Layer (UI)
- Contains UI components and state management
- Uses BLoC pattern for state management
- Depends on Domain layer (not directly on Data layer)
- Framework-dependent (Flutter-specific)

Dependencies flow inward: Presentation → Domain ← Data

## 🧱 SOLID Principles Application

### 1. Single Responsibility Principle (S)
- Each class has only one reason to change
- Examples:
  - `NewsRepository` handles only news data operations
  - `GetNews` use case only fetches news
  - `ArticleCard` only displays article preview

### 2. Open/Closed Principle (O)
- Classes are open for extension but closed for modification
- Examples:
  - Repository pattern allows adding new data sources without changing existing code
  - Use cases can be extended without modifying core logic

### 3. Liskov Substitution Principle (L)
- Subtypes are substitutable for their base types
- Examples:
  - `NewsRepositoryImpl` can substitute `NewsRepository` interface
  - All state classes implement `NewsState` and can be used interchangeably

### 4. Interface Segregation Principle (I)
- Clients shouldn't depend on interfaces they don't use
- Examples:
  - Separate use cases for different operations (`GetNews`, `SearchNews`)
  - Repository interfaces are specific to their domain

### 5. Dependency Inversion Principle (D)
- Depend on abstractions, not concretions
- Examples:
  - Presentation layer depends on repository interfaces, not implementations
  - Dependency injection through GetIt
  - High-level modules don't depend on low-level details

## 🛠️ Design Patterns Used

1. **Repository Pattern**: Abstracts data sources from business logic
2. **BLoC Pattern**: For state management and business logic separation
3. **Dependency Injection**: For loose coupling and testability
4. **Singleton**: For API service and Hive box instances
5. **Factory Method**: For converting API JSON to entities

## 🚀 Getting Started

1. Clone the repository
2. Add your News API key in `news_remote_data_source.dart`
3. Run `flutter pub get`
4. Run `flutter pub run build_runner build` to generate Hive adapters
5. Run the app with `flutter run`

## 📝 License

This project is open source and available under the [MIT License](LICENSE).