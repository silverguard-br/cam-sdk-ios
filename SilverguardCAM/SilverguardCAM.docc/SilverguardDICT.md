# 📡 Comunicação JavaScript ⇄ Swift

Este documento descreve como ocorre a integração entre o JavaScript executado dentro do `WKWebView` e o código nativo Swift no SDK **SilverguardCAM**.

---

## 🔼 Comandos JavaScript → Swift (`JSCommand`)

O JavaScript pode enviar comandos para o app nativo usando:

```js
window.webkit.messageHandlers.bridge.postMessage({
  command: "comando",
  payload: { ... }
});
```

| Comando             | Payload  | Descrição                              |
|---------------------|----------|----------------------------------------|
| `back`              | nenhum   | Retorna para a tela anterior. Ao retornar, o app enviará também a origem do fluxo (ver **Swift → JavaScript** abaixo). |
| `askForMicrophone`  | nenhum   | Solicita permissão de microfone.       |
| `askForLibrary`     | nenhum   | Solicita permissão de biblioteca.      |

**Exemplo:**

```js
window.webkit.messageHandlers.bridge.postMessage({
  command: "askForMicrophone",
  payload: null
});
```

---

## 🔽 Comandos Swift → JavaScript (`JSAnswer`)

O app nativo envia respostas e notificações de status de permissões ou de navegação.

| Comando                | Payload                                                                                             | Descrição                                                                 |
|------------------------|-----------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------|
| `microphonePermission` | `{ status: "authorized" / "denied" / "notDetermined" }`                                             | Status da permissão do microfone.                                         |
| `libraryPermission`    | `{ status: "authorized" / "denied" / "notDetermined" }`                                             | Status da permissão da biblioteca.                                        |
| `back`                 | `{ payload: { origin: "ORIGIN DE ONDE RETORNOU" } }`                                                | Informa que o usuário retornou para a tela anterior, incluindo a origem do fluxo. |

**Exemplo para receber mensagens no JavaScript:**

```js
window.nativeBridge = {
  onMessage: function(message) {
    if (message.command === "microphonePermission") {
      console.log("Microphone status:", message.payload.status);
    }
    
    if (message.command === "back") {
      console.log("Usuário voltou do fluxo:", message.payload.origin);
    }
  }
};
```

---

## 📜 Status possíveis (`PermissionStatus`)

- `authorized`
- `denied`
- `notDetermined`

---
