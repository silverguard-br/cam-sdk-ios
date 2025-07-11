import WebKit

final class WebViewManager: NSObject {
    private lazy var webView: NativeWebView = {
        let webView = NativeWebView()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        return webView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        spinner.color = Stylesheet.colors.primary
        return spinner
    }()
    
    private(set) lazy var view: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var onStartLoading: (() -> Void)?
    private var onStopLoading: (() -> Void)?

    override init() {
        super.init()
        configureViews()
    }
    
    private func configureViews() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        view.addSubview(spinner)
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func resolveAction(_ handler: @escaping (JSCommand, [String: String]?) -> Void) {
        webView.setActionHandler(handler)
    }

    func sendAction(_ command: JSAnswer, payload: [String: String]? = nil) {
        let message: [String: Any] = [
            "command": command.rawValue,
            "payload": payload ?? [:]
        ]

        guard
            let data = try? JSONSerialization.data(withJSONObject: message),
            let json = String(data: data, encoding: .utf8)
        else {
            Helper.print("❌ Falha ao serializar comando para JSON")
            return
        }

        let js = "window.nativeBridge?.onMessage(\(json));"
        Helper.print(json)
        webView.evaluateJavaScript(js, completionHandler: nil)
    }
    
    @discardableResult
    func load(url: URL) -> Self {
        let request = URLRequest(url: url)
        webView.load(request)
        return self
    }
    
    @discardableResult
    func configure(
        start: @escaping () -> Void,
        stop: @escaping () -> Void
    ) -> Self {
        onStartLoading = start
        onStopLoading = stop
        spinner.isHidden = true
        return self
    }
}

extension WebViewManager: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        if let onStartLoading = onStartLoading {
            onStartLoading()
        } else {
            spinner.startAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if let onStopLoading = onStopLoading {
            onStopLoading()
        } else {
            spinner.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if let onStopLoading = onStopLoading {
            onStopLoading()
        } else {
            spinner.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if let onStopLoading = onStopLoading {
            onStopLoading()
        } else {
            spinner.stopAnimating()
        }
    }
}

extension WebViewManager: WKUIDelegate {
    @available(iOS 15.0, *)
    func webView(_ webView: WKWebView,
                 requestMediaCapturePermissionFor origin: WKSecurityOrigin,
                 initiatedByFrame frame: WKFrameInfo,
                 type: WKMediaCaptureType,
                 decisionHandler: @escaping (WKPermissionDecision) -> Void) {
        decisionHandler(.grant)
    }
}
