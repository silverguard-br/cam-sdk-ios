import UIKit

protocol DictWebviewViewControllerProtocol: AnyObject {
    func load(webview: URL)
    func sendCommand(_ command: JSAnswer, payload: [String: String]?)
}

final class DictWebviewViewController: ViewController<DictWebviewInteractorProtocol> {
    private lazy var webviewManager: WebViewManager = {
        let webview = WebViewManager()
        webview.view.translatesAutoresizingMaskIntoConstraints = false
        return webview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func configureViews() {
        view.backgroundColor = Stylesheet.colors.background
        view.addSubview(webviewManager.view)
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate(
            [
                webviewManager.view.topAnchor.constraint(equalTo: view.topAnchor),
                webviewManager.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webviewManager.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                webviewManager.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
    
    override func configureBindings() {
        resolveCommands()
    }
}

extension DictWebviewViewController: DictWebviewViewControllerProtocol {
    func load(webview: URL) {
        DispatchQueue.main.async { [weak self] in
            self?.webviewManager
                .configure(
                    start: {},
                    stop: { [weak self] in
                        self?.interactor.stopLoading()
                    },
                    error: { [weak self] in
                        self?.interactor.error()
                    }
                )
                .load(url: webview)
        }
    }
}

extension DictWebviewViewController {
    private func resolveCommands() {
        webviewManager.resolveAction { [weak self] command, data in
            self?.interactor.resolve(command: command, data: data)
        }
    }
    
    func sendCommand(_ command: JSAnswer, payload: [String: String]? = nil) {
        webviewManager.sendAction(
            command,
            payload: payload
        )
    }
}
