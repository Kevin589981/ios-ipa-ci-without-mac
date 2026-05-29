# iOS IPA CI Without Mac

[English README](README.en.md)

这是一份从实际 Flutter iOS CI 项目经验中抽象出来的指南：在**没有个人 Mac 电脑**的前提下，使用 GitHub Actions 的 `macos-*` runner，把 Flutter 源代码项目编译成 `.ipa`。

本仓库只包含通用文档和可复用范例，不包含任何原项目业务源码、证书、私钥或真实 Bundle ID。

## 你能得到什么

- 一套从 Windows/Linux 开发到 GitHub Actions 编译 IPA 的完整流程。
- 一个最小 Flutter 示例项目结构。
- 未签名 IPA workflow：适合先验证“项目是否能在云端编译”。
- 签名 IPA workflow：适合需要真机安装、Ad Hoc、TestFlight 或 App Store 发布的路径。
- 常见文件范例：`pubspec.yaml`、`release-ios.yml`、`ExportOptions.plist`、`Info.plist` 片段、`.gitignore`、构建脚本。
- 常见坑排查：证书、Provisioning Profile、Bundle ID、Flutter/iOS 版本、Artifact 下载等。

## 推荐阅读顺序

1. [核心原理](docs/01-core-concepts.md)
2. [无 Mac 创建 Flutter iOS 项目](docs/02-create-project-without-mac.md)
3. [未签名 IPA 构建](docs/03-unsigned-ipa-workflow.md)
4. [签名 IPA 构建](docs/04-signed-ipa-workflow.md)
5. [项目文件范例说明](docs/05-file-examples.md)
6. [排错清单](docs/06-troubleshooting.md)

## 最短路径

如果你只是想先产出一个 `.ipa` 文件验证流程：

1. 准备一个 Flutter 项目，确保仓库里存在 `ios/` 目录。
2. 把 [`examples/flutter_ipa_ci/.github/workflows/release-ios-unsigned.yml`](examples/flutter_ipa_ci/.github/workflows/release-ios-unsigned.yml) 复制到你的项目 `.github/workflows/`。
3. 推送 tag：

```powershell
git tag v0.1.0
git push origin v0.1.0
```

4. 在 GitHub Actions 的构建结果里下载 `ios_unsigned_ipa` artifact。

## 重要限制

- GitHub Actions 的 macOS runner 等价于“临时云端 Mac”，不是绕过 Apple 工具链。
- `flutter build ios --no-codesign` 可以生成未签名 `.app`，并打包成未签名 `.ipa`。
- 未签名 IPA 通常不能直接安装到普通 iPhone；真机安装通常需要 Apple Developer 账号、证书和 Provisioning Profile。
- 不要把 `.p12`、`.mobileprovision`、API key、私钥明文提交到仓库。请使用 GitHub Secrets。

## 仓库定位

这个仓库更像“方法库 + 可复制骨架”，不是一个完整业务 App。你应该把 `examples/` 中的文件迁移到自己的项目，再替换包名、应用名、签名信息和业务代码。
