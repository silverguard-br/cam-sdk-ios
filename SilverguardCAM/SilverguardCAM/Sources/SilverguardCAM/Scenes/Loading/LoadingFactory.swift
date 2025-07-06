import Foundation
import UIKit

protocol LoadingFactoring {
    static func present(_ loadingDTO: LoadingDTO, in controller: UIViewController) -> LoadingController
}

enum LoadingFactory: LoadingFactoring {
    private static func create(_ loadingDTO: LoadingDTO) -> LoadingController {
        let coordinator = LoadingCoordinator()
        let presenter = LoadingPresenter(coordinator: coordinator)
        let interactor = LoadingInteractor(presenter: presenter, loadingDTO: loadingDTO)
        let viewController = LoadingViewController(interactor: interactor)
        
        presenter.controller = viewController
        coordinator.controller = viewController
        
        return viewController
    }
    
    static func present(_ loadingDTO: LoadingDTO, in controller: UIViewController) -> LoadingController {
        let loading = create(loadingDTO)
        controller.addChild(loading)
        controller.view.addSubview(loading.view)
        NSLayoutConstraint.activate(
            [
                loading.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
                loading.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
                loading.view.topAnchor.constraint(equalTo: controller.view.topAnchor),
                loading.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
            ]
        )
        return loading
    }
}
