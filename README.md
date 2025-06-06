### 執行專案前請先執行
```
flutter pub run build_runner build
```

## Dart sdk 版本衝突解決方法

### 方法一

- 請先在終端機(要cd到前端資料夾的跟目錄)輸入以下指令
```
flutter upgrade
```
- 接著再輸入以下指令，確認 Dark SDK 的版本有沒有 >= 3.7.2
```
flutter --version
```

### 方法二

- 先關閉 vscode，然後到電腦的 C:/Users/User 找到 flutter 這個資料夾，然後把它刪除
- 重新用 vscode 打開前端的資料夾，這時候右下角會跳出你的筆電沒有flutter SDK(如果沒跳出來請到 pubspec.yaml 按下 control+s)，會問你要不要下載，請選擇下載
- 等到安裝好之後在終端機輸入以下指令，確認 Dark SDK 的版本有沒有 >= 3.7.2
```
flutter --version
```

### 方法三

- 請直接到官網下載 SDK
https://docs.flutter.dev/get-started/install/windows/web
