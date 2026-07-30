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
      Future<ApiResponse<FeatureEntity>> fetchFeatureData({
        required String id,
      });
    }
    ```

### 2. File-Level Separation for Data Sources
*   Contracts and implementations **MUST** reside in two separate files inside the `data_sources` folder:
    *   `[feature]_remote_data_source.dart` contains the `abstract interface class`.
    *   `[feature]_remote_data_source_impl.dart` contains the implementation.
*   The implementation class name should append `Impl` to the contract interface name.

### 3. Model Serialization & Build Runner
*   Request and Response models under the `models/` subdirectories must be annotated with `@JsonSerializable()`.
*   They must include a `part '[filename].g.dart';` statement and standard `fromJson` / `toJson` mappings.
*   Always trigger code generation after model modification:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

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

### 5. Repository Implementations & Safe API Execution
*   Repository implementations in `data/repositories/` **MUST** call Remote Data Sources and handle HTTP request execution safely using `ApiResponse.executeApiCall`.
*   **Internet Connectivity Check**: Before initiating any remote API/network requests, the repository implementation **MUST** verify the connection using the `NetworkInfo` service (`NetworkInfo.isConnected`). If the device is offline, it **MUST NOT** make the request and should instead return `ApiResponse.error('network_error'.tr())` (or serve cache/fallback data when applicable).
*   Inside `executeApiCall`, parse the responses to models, synchronize state (e.g. updating tokens or cache headers when needed), and return mapped entities.
*   Example:
    ```dart
    @Injectable(as: FeatureRepository)
    class FeatureRepositoryImpl implements FeatureRepository {
      final FeatureRemoteDataSource _remoteDataSource;

      const FeatureRepositoryImpl(this._remoteDataSource);

      @override
      Future<ApiResponse<FeatureEntity>> fetchFeatureData({
        required String id,
      }) async {
        final request = FeatureRequestModel(id: id);

        return ApiResponse.executeApiCall<FeatureEntity>(
          apiCall: () => _remoteDataSource.fetchFeatureData(request),
          fromJson: (json, response) {
            final model = FeatureResponseModel.fromJson(json);
            return model.toEntity();
          },
        );
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

Example of a standard state:
```dart
class FeatureState extends Equatable {
  final BaseState actionState;
  final String query;

  const FeatureState({
    required this.actionState,
    this.query = '',
  });

  FeatureState copyWith({
    BaseState? actionState,
    String? query,
  }) {
    return FeatureState(
      actionState: actionState ?? this.actionState,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [actionState, query];
}
```

---

### 🖥️ Lightweight & High-Performance Screens

To maximize rendering performance and keep code highly readable:
1. **Minimalist Screen Files**: The main Screen class (e.g. `FeatureScreen`) **MUST** be kept as small as possible. It should only contain the structural `Scaffold`, register/listen blocks, and delegate to specialized sub-widgets.
2. **Strict Size Limits**: Screen files **MUST NOT** exceed 200 to 250 lines of code under any circumstances. Keep them as compact and focused as possible.
3. **No Helper Widget Functions**: Do **NOT** declare helper functions inside the screen class that return widgets (e.g. `Widget _buildHeader()`). You **MUST** instead extract these sub-components into standalone `StatelessWidget` or `StatefulWidget` classes placed in the feature's dedicated `widgets/` folder.
4. **Preventing Unnecessary Rebuilds**:
   * Do **NOT** call `BlocBuilder` globally at the root of a large Widget tree.
   * Use granular `BlocBuilder` calls wrapped around *only* the specific widgets that depend on a state change (e.g., wrap form fields or action buttons independently).
   * Utilize `buildWhen` filters to prevent the widget from rebuilding unless the relevant state property changes.
   * Use `BlocListener` to handle one-time side-effects (e.g. displaying error/success alerts, navigating, or popping routes).
5. **Dedicated Sub-widgets**: Split the Screen layout into focused widgets under the `widgets/` folder of the presentation layer (e.g. `feature_header.dart`, `feature_content.dart`).

---

### 🧱 Dynamic Design & Core Sharing

1. **Shared Widgets in `core`**: Any widget or component designed to be shared across more than one feature or screen **MUST** reside under the `core` package (e.g., custom text fields, premium buttons).
   * Example: Use shared components located under `lib/core/widgets/`.
2. **Unified Dialogs & Toasts**:
   * All screens **MUST NEVER** invoke native `SnackBar`s or direct alert wrappers.
   * They **MUST** trigger alerts and notifications using the unified dialog utilities located under `lib/core/dialog_utils/app_dialogs.dart`:
     * Use `AppDialogs.showSuccessMessage(message, context)` or `showFailMessage(message, context)` for dynamic toast/alert overlays.
     * Use `AppDialogs.showSuccessToast(message)` or `showErrorToast(message)` for standard overlay toasts.
     * These dialogs automatically adapt their fonts and color schemes dynamically to the current app theme mode (Light & Dark theme), conforming to the strict golden rule of centralized theme customization.
3. **Centralized Asset Management**:
   * **NEVER** write literal asset path strings directly inside UI widgets (e.g., `'assets/images/logo.png'`).
   * All assets (images, icons, vectors, animations) **MUST** be defined as static constants inside `lib/core/utils/app_assets.dart` (under classes like `AppImages` or `AppIcons`) and imported from there to ensure central manageability.

---

### 🌐 Localization & Zero Hardcoded Strings

1. **Zero Tolerance for Hardcoded Strings**:
   * **NEVER** write literal strings directly inside UI widgets or Cubit logic (e.g., `"Welcome Back"`, `"Submit"`).
   * All UI text, placeholder labels, hints, toast messages, and validation errors **MUST** be declared inside localized JSON resources:
     * Arabic localizations: `assets/translations/ar.json`
     * English localizations: `assets/translations/en.json`
2. **Fetching Translations**:
   * Retrieve all localized text within screens or widgets using the `.tr()` extension method from the `easy_localization` package (e.g., `'app_title'.tr()`).

---

### 🎨 Global Theme Customization & Direct Dependency

We strictly enforce centralized styling based on design system specifications:
1. **Direct Theme Dependency**:
   * Any AI agent or developer working on this codebase **MUST** rely directly on the global `Theme.of(context)` configuration.
   * **NEVER** write local, inline, or ad-hoc custom styles (such as hardcoded `TextStyle` colors, background colors, custom borders, or manual container rounded curves) inside individual screen/feature files.
2. **Zero Screen-Level Component Custom Styling**:
   * If a widget requires styling that is not currently defined or needs adjustments (e.g., custom card decoration, text styles, chip outlines, bottom sheet backgrounds), **do NOT code a custom override on the screen level**.
   * Instead, you **MUST** open `lib/core/theme/app_theme.dart` and configure or modify that specific component's widget theme globally inside both `lightTheme` and `darkTheme`. This ensures that all components remain 100% consistent across the entire application and automatically adapt to light/dark modes.

---

### 🎬 Staggered Micro-Animations with `flutter_animate`

To deliver a high-quality, fluid, and premium user experience:
1. **Purpose & Philosophy**:
   * Animations should look subtle, elegant, and enhance visual feedback without distracting the user.
   * Staggered animations should be used when a screen loads to smoothly introduce elements (headers, cards, action buttons) sequentially.
2. **Implementation Rules**:
   * Use the chainable API from the `flutter_animate` package: `.animate().fade().slideY()`.
   * **Keep it Simple & Subtle**: Avoid excessive spin, shake, or huge zoom effects. Prefer soft transitions (`fade()`, `scale()` with elastic curves, or gentle offset slides (`slideY(begin: 0.2, end: 0)`)).
   * **Staggered Delays**: Start entrance animations at different time offsets (e.g., `200.ms`, `350.ms`, `500.ms`, `600.ms`) to create a pleasing sequential cascade entrance that makes the UI feel alive and responsive.

