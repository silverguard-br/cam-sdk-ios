import Foundation

protocol DictWebviewPresenterProtocol: AnyObject {
    func loading(_ loading: Bool)
    func load(webview: URL)
    func error(_ error: NetworkError)
    func back()
    func sendCommand(_ command: JSAnswer, payload: [String: String]?)
}

final class DictWebviewPresenter: DictWebviewPresenterProtocol {
    public var coordinator: DictWebviewCoordinatorProtocol
    public weak var controller: DictWebviewViewControllerProtocol?
    
    public init(coordinator: DictWebviewCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func back() {
        coordinator.back()
    }

    func loading(_ loading: Bool) {
        if loading {
            coordinator.startLoading(
                .init(
                    message: Localizable.Loading.message
                )
            )
        } else {
            coordinator.stopLoading(nil)
        }
    }
    
    func load(webview: URL) {
        controller?.load(webview: webview)
    }
    
    func error(_ error: NetworkError) {
        coordinator.presentFeedback(
            .common()
        )
    }
    
    func sendCommand(_ command: JSAnswer, payload: [String : String]?) {
        controller?.sendCommand(command, payload: payload)
    }
}
