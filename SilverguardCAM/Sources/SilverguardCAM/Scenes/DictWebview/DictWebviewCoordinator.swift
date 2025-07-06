import UIKit

protocol DictWebviewCoordinatorProtocol: AnyObject {
    func startLoading(_ dto: LoadingDTO)
    func stopLoading(_ completion: (() -> Void)?)
    func presentFeedback(_ dto: FeedbackDTO)
    func back()
}

final class DictWebviewCoordinator: DictWebviewCoordinatorProtocol {
    public weak var controller: UIViewController?
    private weak var loadingController: LoadingController?
    private weak var feedbackController: FeedbackController?
    
    public init() { }
    
    func startLoading(_ dto: LoadingDTO) {
        guard let controller else { return }
        loadingController = LoadingFactory.present(
            dto,
            in: controller
        )
    }
    
    func stopLoading(_ completion: (() -> Void)?) {
        loadingController?.finish(completion)
        loadingController = nil
    }
    
    func presentFeedback(_ dto: FeedbackDTO) {
        guard let controller else { return }
        DispatchQueue.main.async { [weak self] in
            self?.feedbackController = FeedbackFactory.present(
                dto,
                in: controller,
                onClick: { [weak self] in
                    self?.controller?.navigationController?.popViewController(animated: true)
                }
            )
        }
    }
    
    func back() {
        controller?.navigationController?.popViewController(animated: true)
    }
}
