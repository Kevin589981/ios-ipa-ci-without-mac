# Flutter IPA CI Example

这是一个最小 Flutter 项目骨架，用于展示如何组织 GitHub Actions 以构建 iOS IPA。

实际使用时建议：

1. 用 `flutter create your_app` 生成完整项目。
2. 复制 `.github/workflows/` 中的 workflow。
3. 按需参考本目录中的 `pubspec.yaml`、`.gitignore` 和 `lib/main.dart`。
4. 不要直接把本示例当成完整可运行 iOS 工程，因为这里没有提交完整 `ios/Runner.xcodeproj`。

如果你希望示例项目完整可编译，请在本目录运行：

```bash
flutter create --platforms=ios .
```

然后提交 Flutter 生成的 iOS 工程文件。
