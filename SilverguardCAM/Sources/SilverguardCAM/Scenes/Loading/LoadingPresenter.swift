import Foundation

protocol LoadingPresenterProtocol: AnyObject {
    func configure(_ loadingDTO: LoadingDTO)
    func finish(_ completion: @escaping () -> Void)
}

final class LoadingPresenter: LoadingPresenterProtocol {
    public var coordinator: LoadingCoordinatorProtocol
    public weak var controller: LoadingViewControllerProtocol?
    
    public init(coordinator: LoadingCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func configure(_ loadingDTO: LoadingDTO) {
        controller?.configure(loadingDTO)
    }
    
    func finish(_ completion: @escaping () -> Void) {
        coordinator.finish(completion)
    }
}
