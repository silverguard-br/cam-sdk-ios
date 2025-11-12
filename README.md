# SilverguardCAM

SDK iOS para integração com o fluxo de **Contestação CAM** da Silverguard.

---

## 📦 Instalação

### 1. CocoaPods

Se ainda não tiver o CocoaPods instalado, siga as instruções em: [https://cocoapods.org/](https://cocoapods.org/)

Adicione no seu `Podfile`:

```ruby
pod 'SilverguardCAM', :git => 'https://github.com/silverguard-br/cam-sdk-ios.git', :tag => '1.2.0'
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

3. Escolha a versão **`1.2.0` ou superior**  
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
SilverguardCAM
    .configure(with: "SUA_API_KEY")
    .setEnvironment(.production) // .debug (padrão), .staging ou .production
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
    .setEnvironment(.production)
    .setStyle(colors: CustomColors())
    .setFonts(fonts: CustomFonts())
```

---

### 4. Inicialização dos fluxos

O SDK oferece **dois fluxos principais**:

#### a) Criar uma nova contestação

```swift
let controller = SilverguardCAM.start(
    with: DICTModel,
    navigationHandler: self // Delegate para eventos de navegação
)
navigationController?.pushViewController(controller, animated: true)
```

#### b) Visualizar lista de contestações

```swift
let controller = SilverguardCAM.start(
    for: DICTListModel,
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
    autofraudRisk: true,
    reporterBranchNumber: 1234, // Opcional
    reporterAccountNumber: 567890 // Opcional
)
```

#### `DICTListModel` (lista de contestações)

```swift
let listModel = DICTListModel(
    reporterClientId: "12345678901234",
    reporterBranchNumber: 1234, // Opcional
    reporterAccountNumber: 567890 // Opcional
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

---

## 🧪 Samples

Explore os exemplos incluídos para ver integrações prontas com UIKit e SwiftUI.

### Requisitos

- Xcode 15 ou superior
- Dispositivo ou simulador iOS 13+

### Passo a passo

1. Abra o projeto desejado no Xcode:  
   - UIKit: `Samples/SilverguardCAM-UIKit/SilverguardCAM-UIKit.xcodeproj`  
   - SwiftUI: `Samples/SilverguardCAM-SwiftUI/SilverguardCAM-SwiftUI.xcodeproj`
2. No arquivo `Samples/SilverguardCAM-UIKit/SilverguardCAM-UIKit/ViewController.swift` (UIKit) ou `Samples/SilverguardCAM-SwiftUI/SilverguardCAM-SwiftUI/ContentView.swift` (SwiftUI), ajuste a chamada `configure(with: "SUA_API_KEY")` para utilizar a sua API Key.
3. Se necessário, personalize os dados de exemplo em `SampleData.swift`.
4. Selecione o esquema padrão do projeto aberto e execute com `Cmd + R`.
5. Se a dependência `SilverguardCAM` apresentar erro ao resolver via SPM, abra **File > Packages > Update to Latest Package Versions** no Xcode ou remova e adicione novamente o pacote (`File > Packages > Reset Package Caches`) para forçar a atualização.

Os projetos já estão configurados para consumir o pacote `SilverguardCAM` via Swift Package Manager, não sendo necessário nenhum passo adicional de instalação.

---

### 7. Permissões de privacidade (Obrigatório)

Adicione no `Info.plist` do seu projeto as chaves abaixo com a mensagem utilizada na sua aplicação. Sem elas, o app encerra ao solicitar as permissões.

- `NSMicrophoneUsageDescription`
- `NSPhotoLibraryUsageDescription`

O SDK solicita as permissões de microfone e biblioteca ao receber os comandos correspondentes do fluxo web. Caso o usuário negue, utilize o comando `openSettings` (veja a seção de integração) para direcioná-lo às configurações do aplicativo.

---

## ✅ Requisitos

- iOS 13 ou superior
- Conexão HTTPS com os domínios `test.cam.sosgolpe.com.br` e `cam.sosgolpe.com.br`

## 📄 Licença

Este SDK é distribuído sob a licença proprietária da **Silverguard**. O uso é restrito a clientes autorizados.
