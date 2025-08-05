import Foundation
import UIKit

protocol FeedbackFactoring {
    static func present(_ feedbackDTO: FeedbackDTO, in controller: UIViewController, onClick: ((UIViewController) -> Void)?) -> FeedbackController
}

enum FeedbackFactory: FeedbackFactoring {
    static func create(
        _ feedbackDTO: FeedbackDTO,
        onClick: ((UIViewController) -> Void)? = nil
    ) -> FeedbackController {
        let coordinator = FeedbackCoordinator()
        let presenter = FeedbackPresenter(coordinator: coordinator)
        let interactor = FeedbackInteractor(presenter: presenter, feedbackDto: feedbackDTO)
        let viewController = FeedbackViewController(interactor: interactor)
        
        coordinator.completion = onClick
        presenter.controller = viewController
        coordinator.controller = viewController
        
        return viewController
    }
    
    static func present(
        _ feedbackDTO: FeedbackDTO,
        in controller: UIViewController,
        onClick: ((UIViewController) -> Void)? = nil
    ) -> any FeedbackController {
        let feedback = create(feedbackDTO, onClick: onClick)
        controller.addChild(feedback)
        controller.view.addSubview(feedback.view)
        NSLayoutConstraint.activate(
            [
                feedback.view.leadingAnchor.constraint(equalTo: controller.view.leadingAnchor),
                feedback.view.trailingAnchor.constraint(equalTo: controller.view.trailingAnchor),
                feedback.view.topAnchor.constraint(equalTo: controller.view.topAnchor),
                feedback.view.bottomAnchor.constraint(equalTo: controller.view.bottomAnchor)
            ]
        )
        return feedback
    }
}
