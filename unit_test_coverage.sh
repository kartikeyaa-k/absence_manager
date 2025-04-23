
#!/bin/bash

# All logic is covered in unit tests with 100% coverage
flutter test --coverage

# However, Currently ignoring widget and extension tests
# core/utility/
# data/model/
# presentation/component/

lcov --remove coverage/lcov.info \
  '**/core/utility/**' \
  '**/data/model/**' \
  '**/presentation/component/**' \
  -o coverage/lcov_filtered.info

genhtml coverage/lcov_filtered.info --output-directory=coverage/html

open coverage/html/index.html
