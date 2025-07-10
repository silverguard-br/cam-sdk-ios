import WebKit

final class NativeWebView: WKWebView {
    private var actionHandler: ((JSCommand, [String: String]?) -> Void)?
    
    override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        let config = configuration
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        if #available(iOS 14.0, *) {
            let webpagePreferences = WKWebpagePreferences()
            webpagePreferences.allowsContentJavaScript = true
            config.defaultWebpagePreferences = webpagePreferences
        } else {
            preferences.javaScriptEnabled = true
        }
        
        config.preferences = preferences
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        if #available(iOS 15.0, *) {
            config.defaultWebpagePreferences.allowsContentJavaScript = true
        }

        let userContentController = config.userContentController
        userContentController.addUserScript(NativeWebView.injectViewportScript())
        userContentController.addUserScript(NativeWebView.injectNativeStyleScript())
        config.userContentController = userContentController

        super.init(frame: .zero, configuration: config)
        userContentController.add(self, name: "bridge")

        configureNativeLook()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureNativeLook() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .clear
        isOpaque = false
        scrollView.backgroundColor = .clear
        scrollView.isScrollEnabled = true
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }
    
    func setActionHandler(_ completion: @escaping ((JSCommand, [String: String]?) -> Void)) {
        actionHandler = completion
    }
}

extension NativeWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        Helper.print(message)
        guard
            message.name == "bridge",
            let body = message.body as? [String: Any],
            let commandString = body["command"] as? String,
            let command = JSCommand(rawValue: commandString),
            WebViewCommandCenter.shared.isRegistered(command)
        else {
            Helper.print("⚠️ Comando inválido, não registrado ou payload inválido")
            return
        }
        let payload = body["payload"] as? [String: String]

        actionHandler?(command, payload)
    }
}

extension NativeWebView {
    private static func injectViewportScript() -> WKUserScript {
        let source: String = """
        var meta = document.createElement('meta');
        meta.name = 'viewport';
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
        var head = document.getElementsByTagName('head')[0];
        head.appendChild(meta);
        """
        return WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
    
    private static func injectNativeStyleScript() -> WKUserScript {
        let css = """
        * {
            -webkit-touch-callout: none;
            -webkit-user-select: none;
            user-select: none;
        }

        body {
            margin: 0;
            padding: 0;
            background-color: transparent;
        }
        """
        let js = """
        var style = document.createElement('style');
        style.innerHTML = `\(css)`;
        document.head.appendChild(style);
        """
        return WKUserScript(source: js, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
    }
}
