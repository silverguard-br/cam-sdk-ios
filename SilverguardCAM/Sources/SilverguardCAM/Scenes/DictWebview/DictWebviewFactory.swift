import UIKit

enum DictWebviewFactory {
    static func create(dict: DICTModel, navigationHandler: SilverguardNavigationHandlerDelegate) -> UIViewController {
        let coordinator = DictWebviewCoordinator(
            navigationHandler: navigationHandler
        )
        let service = DictWebviewService()
        let presenter = DictWebviewPresenter(coordinator: coordinator)
        let permissionService = PermissionService()
        let interactor = DictWebviewInteractor(
            presenter: presenter,
            service: service,
            permissionService: permissionService,
            repository: .med(dict)
        )
        let viewController = DictWebviewViewController(interactor: interactor)
        
        presenter.controller = viewController
        coordinator.controller = viewController
        
        return viewController
    }
    
    static func create(list: DICTListModel, navigationHandler: SilverguardNavigationHandlerDelegate) -> UIViewController {
        let coordinator = DictWebviewCoordinator(
            navigationHandler: navigationHandler
        )
        let service = DictWebviewService()
        let presenter = DictWebviewPresenter(coordinator: coordinator)
        let permissionService = PermissionService()
        let interactor = DictWebviewInteractor(
            presenter: presenter,
            service: service,
            permissionService: permissionService,
            repository: .list(list)
        )
        let viewController = DictWebviewViewController(interactor: interactor)
        
        presenter.controller = viewController
        coordinator.controller = viewController
        
        return viewController
    }
}
