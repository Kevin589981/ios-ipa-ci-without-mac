# iOS IPA CI Without Mac

[中文 README](README_zh.md)

This guide explains how to build an iOS `.ipa` from source code with GitHub Actions, even when you do **not** own a Mac. It is based on a real Flutter iOS CI setup, but the examples here are generalized and reusable.

This repository contains only documentation and reusable examples. It does not include any private project source code, certificates, private keys, real Bundle IDs, or production secrets.

## What You Get

- A complete workflow from Windows/Linux development to iOS IPA builds on GitHub Actions.
- A minimal Flutter example project structure.
- An unsigned IPA workflow, useful for validating that your project can compile on a cloud macOS runner.
- A signed IPA workflow, useful for device installation, Ad Hoc distribution, TestFlight, or App Store release paths.
- Practical file examples: `pubspec.yaml`, `release-ios.yml`, `ExportOptions.plist`, `Info.plist` snippets, `.gitignore`, and packaging scripts.
- Troubleshooting notes for certificates, provisioning profiles, Bundle IDs, Flutter/iOS versions, and artifact downloads.

## Recommended Reading Order

1. [Core Concepts](docs/01-core-concepts.md)
2. [Create a Flutter iOS Project Without a Mac](docs/02-create-project-without-mac.md)
3. [Build an Unsigned IPA](docs/03-unsigned-ipa-workflow.md)
4. [Build a Signed IPA](docs/04-signed-ipa-workflow.md)
5. [File Examples](docs/05-file-examples.md)
6. [Troubleshooting](docs/06-troubleshooting.md)

> Note: the detailed documents are currently written in Chinese. The workflows and examples are language-neutral and can be copied into your own project.

## Quick Start

If you only want to produce an `.ipa` and validate the CI flow:

1. Prepare a Flutter project and make sure the repository contains an `ios/` directory.
2. Copy [`examples/flutter_ipa_ci/.github/workflows/release-ios-unsigned.yml`](examples/flutter_ipa_ci/.github/workflows/release-ios-unsigned.yml) into your project's `.github/workflows/` directory.
3. Push a tag:

```powershell
git tag v0.1.0
git push origin v0.1.0
```

4. Open the GitHub Actions run and download the `ios_unsigned_ipa` artifact.

## Important Limitations

- GitHub Actions macOS runners are temporary cloud Macs. This does not bypass Apple's iOS toolchain requirements.
- `flutter build ios --no-codesign` can build an unsigned `.app`, which can then be packaged into an unsigned `.ipa`.
- An unsigned IPA usually cannot be installed directly on a normal iPhone.
- Real device installation usually requires an Apple Developer account, a signing certificate, and a provisioning profile.
- Never commit `.p12`, `.mobileprovision`, API keys, private keys, or other secrets. Use GitHub Secrets instead.

## Repository Scope

Think of this repository as a method library and copyable skeleton, not a complete production app.

You should copy the files under `examples/` into your own project, then replace the placeholder Bundle ID, app name, signing configuration, and application code with your own values.

## Unsigned vs Signed IPA

### Unsigned IPA

Use this first when you want to confirm that the project compiles on GitHub Actions:

```bash
flutter build ios --release --no-codesign
mkdir -p Payload
cp -R build/ios/iphoneos/Runner.app Payload/Runner.app
zip -q -r app_no_sign.ipa Payload
```

This is ideal for CI validation, but not enough for normal device installation.

### Signed IPA

Use this when you need distribution:

- Development device installation
- Ad Hoc distribution
- TestFlight
- App Store upload
- Enterprise distribution, depending on your Apple account type

The signed workflow expects signing materials to be stored as GitHub Secrets:

```text
IOS_CERTIFICATE_P12_BASE64
IOS_CERTIFICATE_PASSWORD
IOS_PROVISION_PROFILE_BASE64
IOS_KEYCHAIN_PASSWORD
IOS_EXPORT_METHOD
IOS_TEAM_ID
```

## Example Workflows

- [Unsigned IPA workflow](examples/flutter_ipa_ci/.github/workflows/release-ios-unsigned.yml)
- [Signed IPA workflow](examples/flutter_ipa_ci/.github/workflows/release-ios-signed.yml)

The unsigned workflow is the safest starting point. Once it works, move to the signed workflow and configure your Apple Developer signing assets.
