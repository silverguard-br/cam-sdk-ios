# SilverguardCAM

SDK iOS para integração com o fluxo de **Contestação CAM** da Silverguard.

---

## 📦 Instalação

### 1. CocoaPods

Se ainda não tiver o CocoaPods instalado, siga as instruções em: [https://cocoapods.org/](https://cocoapods.org/)

Adicione no seu `Podfile`:

```ruby
pod 'SilverguardCAM', :git => 'https://github.com/silverguard-br/cam-sdk-ios.git', :tag => '1.0.0'
```

E execute:

```bash
pod install
```

---

### 2. Swift Package Manager (SPM)

1. No Xcode, vá em **File > Add Packages...**  
2. Use a URL:  

```
https://github.com/silverguard-br/cam-sdk-ios.git
```

3. Escolha a versão **`1.0.0` ou superior**  
4. Adicione ao seu **target**.

---

## 🚀 Uso

### 1. Importação

```swift
import SilverguardCAM
```

---

### 2. Configuração (AppDelegate ou SceneDelegate)

Antes de iniciar qualquer fluxo, configure o SDK com sua **API Key**:

```swift
SilverguardCAM.configure(with: "SUA_API_KEY")
```

---

### 3. Customização de Estilo (Opcional)

Você pode personalizar **cores** e **fontes** do SDK implementando os protocolos `ColorsProtocol` e `FontsProtocol`:

```swift
class CustomColors: ColorsProtocol {
    var background: UIColor = .white
    var primary: UIColor = .blue
    var primary04: UIColor = .blue.withAlphaComponent(0.4)
    var buttonTitle: UIColor = .white
    var label: UIColor = .black
    var surface: UIColor = .gray
    var buttonEnabled: UIColor = .green
    var buttonDisabled: UIColor = .lightGray
}

final class CustomFonts: FontsProtocol {
    var button: UIFont = UIFont.systemFont(ofSize: 14)
    var body: UIFont = UIFont.systemFont(ofSize: 14)
    var headline2: UIFont = UIFont.systemFont(ofSize: 24)
    var headline3: UIFont = UIFont.systemFont(ofSize: 20)
}
```

Aplicando o estilo:

```swift
SilverguardCAM
    .configure(with: "SUA_API_KEY")
    .setStyle(colors: CustomColors())
    .setFonts(fonts: CustomFonts())
```

---

### 4. Inicialização dos fluxos

O SDK oferece **dois fluxos principais**:

#### a) Criar uma nova contestação

```swift
let controller = SilverguardCAM.start(
    with: dictModel, // Instância de DICTModel
    navigationHandler: self // Delegate para eventos de navegação
)
navigationController?.pushViewController(controller, animated: true)
```

#### b) Visualizar lista de contestações

```swift
let controller = SilverguardCAM.start(
    for: dictListModel, // Instância de DICTListModel
    navigationHandler: self
)
navigationController?.pushViewController(controller, animated: true)
```

---

### 5. Modelos obrigatórios

#### `DICTModel` (nova contestação)

```swift
let model = DICTModel(
    transactionId: UUID().uuidString,
    transactionAmount: 100,
    transactionTime: "2025-07-10 11:10:00", // Formato: yyyy-MM-dd HH:mm:ss
    transactionDescription: "Pagamento via PIX",
    reporterClientName: "Fulano de Tal",
    reporterClientId: "12345678901234",
    contestedParticipantId: "123456",
    counterpartyClientName: "John Doe",
    counterpartyClientId: "12345678901",
    counterpartyClientKey: "cpf",
    protocolId: UUID().uuidString,
    pixAuto: true,
    clientId: "CLI_456789",
    clientSince: "2020-01-15",
    clientBirth: "1985-03-22",
    autofraudRisk: true
)
```

#### `DICTListModel` (lista de contestações)

```swift
let listModel = DICTListModel(
    reporterClientId: "12345678901234"
)
```

---

### 6. Captura de retorno com `SilverguardNavigationHandlerDelegate`

Implemente este delegate para capturar quando o usuário retorna do fluxo, com um `command` indicando de qual parte ele saiu:

```swift
extension ViewController: SilverguardNavigationHandlerDelegate {
    func onPopViewController(with command: String?) {
        print("Usuário retornou do fluxo:", command ?? "404")
    }
}
```

## 📄 Licença

Este SDK é distribuído sob a licença proprietária da **Silverguard**. O uso é restrito a clientes autorizados.
