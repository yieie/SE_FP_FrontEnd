@echo off
echo Installing dependencies...
flutter pub get

echo Running build_runner...
flutter pub run build_runner build --delete-conflicting-outputs

echo.
echo ✅ Setup completed successfully!
pause