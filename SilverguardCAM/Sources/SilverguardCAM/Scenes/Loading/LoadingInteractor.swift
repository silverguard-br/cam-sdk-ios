import Foundation

protocol LoadingInteractorProtocol: AnyObject {
    func didLoad()
    func finish(_ completion: @escaping () -> Void)
}

final class LoadingInteractor: LoadingInteractorProtocol {
    public let presenter: LoadingPresenterProtocol
    private let loadingDTO: LoadingDTO
    
    public init(
        presenter: LoadingPresenterProtocol,
        loadingDTO: LoadingDTO
    ) {
        self.presenter = presenter
        self.loadingDTO = loadingDTO
    }

    func didLoad() {
        presenter.configure(loadingDTO)
    }
    
    func finish(_ completion: @escaping () -> Void) {
        presenter.finish(completion)
    }
}
