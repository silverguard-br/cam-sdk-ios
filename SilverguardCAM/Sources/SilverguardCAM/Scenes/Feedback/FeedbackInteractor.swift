import Foundation

protocol FeedbackInteractorProtocol: AnyObject {
    func didLoad()
    func onClick()
}

final class FeedbackInteractor: FeedbackInteractorProtocol {
    public let presenter: FeedbackPresenterProtocol
    private let feedbackDto: FeedbackDTO
    
    public init(
        presenter: FeedbackPresenterProtocol,
        feedbackDto: FeedbackDTO
    ) {
        self.presenter = presenter
        self.feedbackDto = feedbackDto
    }

    func didLoad() {
        presenter.configure(feedbackDto)
    }
    
    func onClick() {
        presenter.onClick()
    }
}
