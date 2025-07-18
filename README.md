# authentication

Para gerar o sha1 e sha256 key: (necessários para autenticação pelo Google ou Phone) (email/senha não precisa)  
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android

Pelo menos nos métodos de autenticação, precisa ser feito o ajuste abaixo.

No Android:  
OnBackInvokedCallback is not enabled for the application.  
Set 'android:enableOnBackInvokedCallback="true"' in the application manifest.  
```xml
<application
android:label="MyApp"
android:icon="@mipmap/ic_launcher"
android:enableOnBackInvokedCallback="true"> <!-- Aqui você adiciona -->
```

Autenticação Google ou Celular no iPhone:  
Navegue até o arquivo ios/Runner/Info.plist.  
Adicione o REVERSED_CLIENT_ID ao arquivo conforme abaixo: (pegar no GoogleService-Info.plist)  
```xml
<key>CFBundleURLTypes</key>
<array>
  <dict>
    <key>CFBundleTypeRole</key>
    <string>Editor</string>
    <key>CFBundleURLSchemes</key>
    <array>
      <string>YOUR_REVERSED_CLIENT_ID</string>
    </array>
  </dict>
</array>
<key>LSApplicationQueriesSchemes</key>
<array>
<string>googlechrome</string>
<string>googlechrome-universal-links</string>
<string>googlechrome-x-callback</string>
</array>
```

No arquivo Podfile na raiz do ios, precisa estar assim no início:  
```text
# Uncomment this line to define a global platform for your project  
platform :ios, '15.6'  
```

Depois dos packages já importados no pubspec.yaml, rodar o comando no terminal  
de dentro da pasta ios:  
pod install --repo-update  
se der algum erro tentar:  
pod update Firebase/CoreOnly  

-------------

No Firebase, além de ativar os respectivos tipos de Autenticação, ajustar a linguagem dos textos  
tanto de redefinição de senha de email quanto mensagens sms com o código.  
Visão geral do projeto -> Configurações do projeto  
Em Geral, alterar o "Nome exibido ao publico" para o nome que vai aparecer em %APP_NAME%.  
Para a linguagem, vá em Authentication -> Modelos  
E altere o idioma do modelo.

---------------
Informações sobre o Get:

Get.to(): Navega para uma nova página, adicionando-a à pilha de navegação.  
Get.to(NewPage());

Get.off(): Navega para uma nova página e remove a página anterior da pilha.  
Get.off(NewPage());

Get.offAll(): Navega para uma nova página e remove todas as páginas anteriores da pilha.  
Get.offAll(NewPage());

Get.back(): Retorna para a página anterior.

Get.offNamed(): Navega para uma nova página com base no nome da rota, removendo a página anterior da pilha.  
Get.offNamed('/newPage');

Get.offAllNamed(): Navega para uma nova página com base no nome da rota e remove todas as páginas anteriores da pilha.  
Get.offAllNamed('/home');

Get.toNamed(): Navega para uma nova página usando o nome da rota.  
Get.toNamed('/newPage');

Get.backUntil(): Volta até encontrar uma página específica na pilha.  
Get.backUntil((route) => route.isFirst);

Get.offUntil(): Navega para uma nova página e remove todas as páginas até uma condição específica.  
Get.offUntil(MaterialPageRoute(builder: (_) => NewPage()), (route) => route.isFirst);
