import UIKit

enum DictWebviewFactory {
    static func create(dict: DICTModel) -> UIViewController {
        let coordinator = DictWebviewCoordinator()
        let service = DictWebviewService()
        let presenter = DictWebviewPresenter(coordinator: coordinator)
        let permissionService = PermissionService()
        let interactor = DictWebviewInteractor(
            presenter: presenter,
            service: service,
            permissionService: permissionService,
            model: dict
        )
        let viewController = DictWebviewViewController(interactor: interactor)
        
        presenter.controller = viewController
        coordinator.controller = viewController
        
        return viewController
    }
}
