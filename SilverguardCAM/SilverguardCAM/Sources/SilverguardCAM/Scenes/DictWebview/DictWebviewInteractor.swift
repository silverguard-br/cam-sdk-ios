import Foundation

protocol DictWebviewInteractorProtocol: AnyObject {
    func load()
    func resolve(command: JSCommand, data: [String: String]?)
    func stopLoading()
}

final class DictWebviewInteractor {
    public let presenter: DictWebviewPresenterProtocol
    public let service: DictWebviewServiceProtocol
    private let permissionService: PermissionServicing
    private let model: DICTModel
    
    public init(
        presenter: DictWebviewPresenterProtocol,
        service: DictWebviewServiceProtocol,
        permissionService: PermissionServicing,
        model: DICTModel
    ) {
        self.presenter = presenter
        self.service = service
        self.model = model
        self.permissionService = permissionService
    }
}

extension DictWebviewInteractor: DictWebviewInteractorProtocol {
    func load() {
        loading(true)
        service.request(med: model) { [weak self] result in
            switch result {
            case .success(let success):
                self?.handleSuccess(success)
            case .failure(let failure):
                self?.handleFailure(failure)
            }
        }
    }
    
    func stopLoading() {
        loading(false)
    }
    
    func resolve(command: JSCommand, data: [String: String]?) {
        switch command {
        case .back:
            presenter.back()
        case .askForMicrophone:
            askPermission(for: .microphone, answering: .microphonePermission)
        case .askForLibrary:
            askPermission(for: .library, answering: .libraryPermission)
        }
    }
}

extension DictWebviewInteractor {
    private func askPermission(for type: PermissionType, answering: JSAnswer) {
        permissionService.requestPermission(
            for: type,
            completion: { [weak self] status in
                self?.presenter.sendCommand(
                    answering,
                    payload: [
                        "status": status.rawValue
                    ]
                )
            }
        )
    }

    private func loading(_ loading: Bool) {
        presenter.loading(loading)
    }
    
    private func handleSuccess(_ dto: DICTResponse) {
        guard let url = URL(string: dto.data.url) else {
            handleFailure(.invalidData)
            return
        }
        presenter.load(webview: url)
    }
    
    private func handleFailure(_ error: NetworkError) {
        stopLoading()
        presenter.error(error)
    }
}
