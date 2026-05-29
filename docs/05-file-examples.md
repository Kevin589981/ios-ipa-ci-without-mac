# 项目文件范例说明

本目录下的示例文件位于 [`examples/flutter_ipa_ci`](../examples/flutter_ipa_ci)。它们是从真实项目结构中抽象出的“骨架”，不是业务代码。

## `.github/workflows/release-ios-unsigned.yml`

用途：无证书构建未签名 IPA。

特点：

- tag、手动触发均可。
- Ubuntu job 负责检查。
- macOS job 负责 iOS build。
- 使用 `--no-codesign`。
- 上传 `.ipa` artifact。

## `.github/workflows/release-ios-signed.yml`

用途：使用 GitHub Secrets 中的 Apple 签名材料导出签名 IPA。

特点：

- 使用临时 keychain。
- 解码 profile。
- 通过 `flutter build ipa` 或 `xcodebuild -exportArchive` 完成导出。
- 适合 Ad Hoc/TestFlight/App Store 路径。

## `pubspec.yaml`

最小 Flutter App 配置。真实项目可以加入自己的依赖，例如：

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
```

如果项目有 native/Rust 模块，可以保留独立目录，但 CI 里要明确 check/build 路径。

## `lib/main.dart`

最小 UI，仅用于证明项目可编译。

## `ios/Runner/Info.plist.example`

只提供片段说明。真实项目应由 `flutter create` 生成完整 iOS 工程，再按需修改 Display Name、URL Schemes、权限说明等。

## `.gitignore`

核心目标：

- 忽略 build 缓存。
- 忽略 Flutter 生成缓存。
- 忽略证书、私钥、IPA 产物。
- 保留 workflow 和项目配置。
