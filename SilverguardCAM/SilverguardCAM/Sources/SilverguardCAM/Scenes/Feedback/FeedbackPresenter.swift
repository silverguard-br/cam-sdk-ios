import Foundation

protocol FeedbackPresenterProtocol: AnyObject {
    func configure(_ feedbackDTO: FeedbackDTO)
    func onClick()
}

final class FeedbackPresenter: FeedbackPresenterProtocol {
    public var coordinator: FeedbackCoordinatorProtocol
    public weak var controller: FeedbackViewControllerProtocol?
    
    public init(coordinator: FeedbackCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func configure(_ feedbackDTO: FeedbackDTO) {
        controller?.configure(feedbackDTO)
    }
    
    func onClick() {
        coordinator.onClick()
    }
}
