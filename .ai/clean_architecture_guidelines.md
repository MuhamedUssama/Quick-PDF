# Clean Architecture Guidelines (Data, Domain & Presentation Layers)

This document establishes the official technical architecture standards for the **Domain**, **Data**, and **Presentation** layers of the mobile application. All developers and AI agents working on this codebase **MUST** strictly adhere to this structure when building new features.

---

## 📁 Layer Directories Structure

For any feature, the file tree under `lib/features/[feature_name]/` must follow this structure:

```text
lib/features/[feature_name]/
├── data/
│   ├── data_sources/
│   │   ├── [feature]_remote_data_source.dart      <-- Pure Interface (abstract interface class)
│   │   └── [feature]_remote_data_source_impl.dart <-- Implementation (DI annotated)
│   ├── mappers/
│   │   └── [feature]_mappers.dart                 <-- Model to Entity Mapping Extensions
│   ├── models/
│   │   ├── request/
│   │   │   └── [action]_request_model.dart        <-- json_serializable Request Model
│   │   └── response/
│   │       └── [action]_response_model.dart       <-- json_serializable Response Model
│   └── repositories/
│       └── [feature]_repository_impl.dart         <-- Implements Domain Repository Interface
├── domain/
│   ├── entities/
│   │   └── [feature]_entity.dart                  <-- Lightweight Domain Objects
│   ├── repositories/
│   │   └── [feature]_repository.dart              <-- Pure Interface (abstract interface class)
│   └── usecases/
│       └── [action]_usecase.dart                  <-- Dedicated UseCase class
└── presentation/
    ├── cubit/
    │   ├── [feature]_cubit.dart                   <-- Manages screen business logic & state transitions
    │   └── [feature]_state.dart                   <-- Extends BaseState with customized fields and copyWith
    ├── screens/
    │   └── [feature]_screen.dart                  <-- Lightweight container/scaffold
    └── widgets/
        └── [component]_widget.dart                <-- Specialized UI sub-components
```

---

## 🛠️ Implementation Rules & Coding Patterns

### 1. Modern Interface Class Declarations (Dart 3)
*   All interface files (e.g. data source contracts and domain repository contracts) **MUST** use the Dart 3 **`abstract interface class`** syntax.
*   Do **NOT** append the word "Interface" to the class name. The Dart 3 `interface` keyword is the native and official way to establish contracts in the system.
*   Example:
    ```dart
    abstract interface class FeatureRepository {
      Future<FeatureEntity> fetchFeatureData({
        required String id,
      });
    }
    ```

### 2. File-Level Separation for Data Sources
*   Contracts and implementations **MUST** reside in two separate files inside the `data_sources` folder:
    *   `[feature]_remote_data_source.dart` contains the `abstract interface class`.
    *   `[feature]_remote_data_source_impl.dart` contains the implementation.
*   The implementation class name should append `Impl` to the contract interface name.

### 3. Centralized Constants & Zero Hardcoded Keys
*   **NEVER** hardcode key strings (such as Hive box names, AI prompt strings, model names, or mime types) directly inside data sources or repositories.
*   All constants **MUST** be referenced from `AppConstants` inside `lib/core/utils/app_constants.dart`.

### 4. Semantic Entity Mapping (Mappers)
*   Data models **MUST NEVER** bleed into the domain or presentation layers.
*   All data models are mapped to domain entities inside `data/mappers/` using explicit extension methods.
*   Example:
    ```dart
    extension FeatureResponseModelMapper on FeatureResponseModel {
      FeatureEntity toEntity() {
        return FeatureEntity(
          id: data?.id ?? '',
          title: data?.title ?? '',
          // ...
        );
      }
    }
    ```

### 5. Production Error Handling with `ErrorHandler` & `Failure`
*   Do **NOT** use generic `ApiResponse` wrappers for local database or repository operations.
*   Repository implementations in `data/repositories/` **MUST** handle exceptions gracefully by delegating error mapping to `ErrorHandler.handle(e)` located in `lib/core/errors/error_handler.dart`.
*   All thrown or returned errors **MUST** be mapped to domain `Failure` instances (such as `DatabaseFailure`, `OcrFailure`, `ServerFailure`, `FileNotFoundFailure`) carrying user-friendly Arabic error messages.
*   Example:
    ```dart
    @Injectable(as: FeatureRepository)
    class FeatureRepositoryImpl implements FeatureRepository {
      final FeatureRemoteDataSource _remoteDataSource;

      const FeatureRepositoryImpl(this._remoteDataSource);

      @override
      Future<FeatureEntity> fetchFeatureData({required String id}) async {
        try {
          final model = await _remoteDataSource.fetchFeatureData(id);
          return model.toEntity();
        } catch (e) {
          throw ErrorHandler.handle(e);
        }
      }
    }
    ```

### 6. Dependency Injection with Injectable
*   Bind interfaces to their respective implementations using `@Injectable(as: InterfaceName)`.
*   Do **NOT** use `@singleton` or `@lazySingleton` for new feature data sources, repositories, or use cases. Use standard `@injectable` annotations.
*   All use cases must be annotated with `@injectable`.

### 7. Performance & Const Constructors
*   Ensure that all domain entities, use cases, data sources, and repositories declare explicit **`const`** constructors:
    ```dart
    const GetFeatureUseCase(this._repository);
    ```

---

## 🎨 Presentation Layer Guidelines

This section defines the architectural patterns, state management standards, and widget structures to be used in the **Presentation Layer**.

### 📁 Presentation Directory Structure

For any feature, the presentation layer under `lib/features/[feature_name]/presentation/` follows the structure defined in the main directory layout.

> [!IMPORTANT]
> The Cubit and its state classes **MUST** reside under a dedicated `cubit/` folder (not `logic/` or anything else) inside the presentation layer of the feature.

---

### 🧠 State Management with Cubit & `copyWith`

To ensure clean state tracking and UI separation:
1. **Inheriting Base States**: All presentation states **MUST** extend from the unified `BaseState` structure (`lib/core/services/base_states.dart`).
2. **Standard State Properties**: The state class should contain fields representing the screen inputs, visibility toggles, and a dedicated `actionState` (or `processState`) of type `BaseState` to handle `InitialState`, `LoadingState`, `SuccessState`, and `ErrorState`.
3. **The `copyWith` Method**: Every state class **MUST** implement `copyWith` to facilitate immutable state updates, allowing subsequent UI updates to only modify specific parts of the state.
4. **Cubit Responsibilities**:
   * All business logic, input validation orchestration, API call triggers, and state transitions **MUST** be handled solely within the Cubit.
   * All controllers (e.g., `TextEditingController`, `ScrollController`) **MUST** live in the Cubit, not in the Screen or Widget.
   * All controllers **MUST** be properly disposed of by overriding the `close()` method in the Cubit.
   * **Injectable**: Cubits must be annotated with `@injectable` for proper dependency injection.

---

### 🖥️ Lightweight & High-Performance Screens

To maximize rendering performance and keep code highly readable:
1. **Minimalist Screen Files**: The main Screen class (e.g. `FeatureScreen`) **MUST** be kept as small as possible. It should only contain structural `Scaffold` and delegate to sub-widgets.
2. **Strict Size Limits**: Screen files **MUST NOT** exceed 200 to 250 lines of code under any circumstances.
3. **No Helper Widget Functions**: Extract sub-components into standalone `StatelessWidget` or `StatefulWidget` classes under `widgets/`.
4. **Preventing Unnecessary Rebuilds**: Wrap `BlocBuilder` around minimal UI boundaries.

---

### 🧱 Dynamic Design & Core Sharing

1. **Shared Widgets in `core`**: Share widgets across features under `lib/core/widgets/`.
2. **Unified Dialogs & Toasts**: Trigger alerts using `AppDialogs` in `lib/core/dialog_utils/app_dialogs.dart`.
3. **Centralized Asset Management**: Store image/icon constants in `lib/core/utils/app_assets.dart`.

---

### 🌐 Localization & Zero Hardcoded Strings

1. **Zero Tolerance for Hardcoded Strings**: Store translations in `assets/translations/ar.json` and `assets/translations/en.json`.
2. **Fetching Translations**: Use `.tr()` from `easy_localization`.

---

### 🎨 Global Theme Customization & Direct Dependency

1. **Direct Theme Dependency**: Rely directly on `Theme.of(context)`.
2. **Zero Screen-Level Component Custom Styling**: Configure components globally in `lib/core/theme/app_theme.dart`.

---

### 🎬 Staggered Micro-Animations with `flutter_animate`

1. **Subtle Transitions**: Use `.animate().fade().slideY()` with staggered delays for entrance transitions.
