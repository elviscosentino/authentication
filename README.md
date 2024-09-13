# authentication

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

Para gerar o sha1 e sha256 key: (necessários para autenticação pelo Google ou Phone) (email/senha não precisa)
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Autenticação Google no iPhone:
Navegue até o arquivo ios/Runner/Info.plist.
Adicione o REVERSED_CLIENT_ID ao arquivo conforme abaixo: (pegar no GoogleService-Info.plist)
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>YOUR_REVERSED_CLIENT_ID</string>
    </array>
  </dict>
</array>
