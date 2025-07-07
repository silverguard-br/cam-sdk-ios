# SilverguardCAM

## 📦 Instalação

### CocoaPods

```ruby
pod 'SilverguardCAM', :git => 'https://github.com/silverguard-br/cam-sdk-ios.git', :tag => '1.0.0'
```

```bash
pod install
```

### Swift Package Manager (SPM)

1. Xcode > File > Add Packages...
2. Use a URL:

```
https://github.com/silverguard-br/cam-sdk-ios.git
```

3. Selecione versão `1.0.0` ou superior.  
4. Adicione ao seu target.

---

## 🚀 Uso

### 1. Importação

```swift
import SilverguardCAM
```

### 2. Configuração (AppDelegate ou SceneDelegate)

```swift
SilverguardCAM.configure(with: "SUA_API_KEY")
```

#### Opcional: Estilo customizado

```swift
class MyColors: ColorsProtocol {
    var background: UIColor = .white
    var primary: UIColor = .blue
    var primary04: UIColor = .blue.withAlphaComponent(0.4)
    var buttonTitle: UIColor = .white
    var label: UIColor = .black
    var surface: UIColor = .gray
    var buttonEnabled: UIColor = .green
    var buttonDisabled: UIColor = .lightGray
}
```

```swift
SilverguardCAM.configure(with: "SUA_API_KEY", colors: MyColors())
```

### 3. Inicialização do fluxo

```swift
let controller = SilverguardCAM.start(with: model)
navigationController?.pushViewController(controller, animated: true)
```

### 4. Modelos obrigatórios

```swift
let model = DICTModel(
    transaction: DICTTransaction(e2e: "abc", amount: 100, date: "2025-04-16 11:10:00"),
    destinationBank: DICTBank(name: "Banco A", ispb: 123456, compe: 1),
    originBankCustomer: DICTBankCustomer(name: "Cliente A", document: "12345678901", documentType: "cpf"),
    destinationBankCustomer: DICTBankCustomer(name: "Cliente B", document: "98765432100", documentType: "cpf")
)
```

---

## 🌐 Comunicação JavaScript ⇄ Swift

A comunicação entre o JS e o app nativo é feita via `WKWebView` usando `window.webkit.messageHandlers.bridge.postMessage`.

### 🔼 Comandos do JavaScript → Swift (`JSCommand`)

| Comando          | Payload           | Descrição                        |
|------------------|-------------------|---------------------------------|
| `back`           | *nenhum*          | Navega para a tela anterior.    |
| `askForMicrophone`| *nenhum*          | Solicita permissão do microfone.|
| `askForLibrary`   | *nenhum*          | Solicita permissão da biblioteca.|

**Exemplo JavaScript:**

```js
window.webkit.messageHandlers.bridge.postMessage({
  command: "askForMicrophone",
  payload: null
});
```

### 🔽 Comandos do Swift → JavaScript (`JSAnswer`)

Swift responde enviando comandos com payload contendo o status da permissão, usando o enum `PermissionStatus`:

| Comando               | Payload                                | Descrição                             |
|-----------------------|--------------------------------------|-------------------------------------|
| `microphonePermission` | `{ status: "authorized" | "denied" | "notDetermined" }` | Retorna status da permissão do microfone. |
| `libraryPermission`    | `{ status: "authorized" | "denied" | "notDetermined" }` | Retorna status da permissão da biblioteca. |

**Exemplo JavaScript para receber:**

```js
window.nativeBridge = {
  onMessage: function(message) {
    if (message.command === "microphonePermission") {
      const status = message.payload.status; // "authorized", "denied", "notDetermined"
      console.log("Microphone permission status:", status);
    }
  }
};
```

---

**Status possíveis (`PermissionStatus`):**

- `authorized`
- `denied`
- `notDetermined`

---

Essa estrutura garante um fluxo simples e seguro para comunicação bidirecional entre JavaScript e Swift no SilverguardCAM.
