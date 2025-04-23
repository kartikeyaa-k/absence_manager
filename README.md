# 🧱 absence_manager

A feature module for Crewmeister App, `absence_manager` encapsulates the complete absence tracking functionality. Built for modularity, it follows a plug-and-play structure and integrates cleanly with the host app and the shared core layer.

---

## 📂 Folder Structure

```txt
absence_manager/
├── absence_manager.dart           # Public API for importing the package
├── barrel.dart                    # Internal exports
├── src/
│   ├── core/                      # Constants, enums, extensions
│   │   ├── constant/
│   │   ├── enum/
│   │   │   └── absence_type_enum.dart
│   │   └── utility/
│   │       ├── absence_type_extension.dart
│   │       └── date_format_extension.dart
│   │
│   ├── domain/                    # Clean architecture: repository, usecase, entities
│   │   ├── entity/
│   │   │   ├── absence_entity.dart
│   │   │   └── absence_paginated_response_entity.dart
│   │   ├── repository/
│   │   │   └── absence_repository.dart
│   │   └── usecase/
│   │       └── get_absences_usecase.dart
│   │
│   ├── data/                      # Remote integration & data layer
│   │   ├── datasource/
│   │   │   ├── absence_remote_datasource.dart
│   │   │   └── absence_remote_datasource_impl.dart
│   │   ├── model/
│   │   │   ├── absence_model.dart
│   │   │   ├── absence_model.g.dart
│   │   │   ├── absence_paginated_response_model.dart
│   │   │   └── absence_paginated_response_model.g.dart
│   │   ├── helper/
│   │   │   └── to_entity_mixin.dart
│   │   └── repository/
│   │       └── absence_repository_impl.dart
│   │
│   ├── presentation/              # UI, state management, and component layer
│   │   ├── page/
│   │   │   └── absence_list_page.dart
│   │   ├── component/
│   │   │   ├── absence_filter_bar_component.dart
│   │   │   ├── absence_summary_label_component.dart
│   │   │   └── absence_tile_component.dart
│   │   └── cubit/
│   │       ├── absence_cubit.dart
│   │       ├── absence_state.dart
│   │       ├── absence_filter_cubit.dart
│   │       └── absence_filter_state.dart
```

---

🧪 Tests

```
test/
├── domain/
│   └── usecase/
│       └── absence_usecase_test.dart
├── data/
│   ├── datasource/
│   │   └── absence_remote_datasource_impl_test.dart
│   └── repository/
│       └── absence_repository_impl_test.dart
├── presentation/
│   └── cubit/
│       ├── absence_cubit_test.dart
│       └── absence_filter_cubit_test.dart
```
✅ Coverage: 100% unit test coverage for cubits and business logic.

## 🧩 Integration

This package is locally imported in crewmeister_app and only exposes absence_manager.dart as its public API.
To use: 
```dart
import 'package:absence_manager/absence_manager.dart';
```

## ✨ Highlights

- Built as a modular feature package
- Implements clean architecture: domain, data, and presentation layers
- bloc for state management
- 100% unit test coverage for business logic
- Testable components and API layer
- Absence filtering by type and date range
- Paginated fetching via API
- Mock data updated to 2025 for realistic testing
- Member name mapping handled server-side
- Designed for plug-and-play integration with shared crewmeister_core