import UIKit

protocol DictWebviewCoordinatorProtocol: AnyObject {
    func startLoading(_ dto: LoadingDTO)
    func stopLoading(_ completion: (() -> Void)?)
    func presentFeedback(_ dto: FeedbackDTO)
    func back(from origin: String?)
    func navigateToTransactionsList()
}

final class DictWebviewCoordinator: DictWebviewCoordinatorProtocol {
    public weak var controller: UIViewController?
    private weak var loadingController: LoadingController?
    private weak var feedbackController: FeedbackController?
    private weak var navigationHandler: SilverguardNavigationHandlerDelegate?
    
    public init(navigationHandler: SilverguardNavigationHandlerDelegate) {
        self.navigationHandler = navigationHandler
    }
    
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
                onClick: { [weak self] feedbackController in
                    feedbackController.view.removeFromSuperview()
                    feedbackController.removeFromParent()
                    self?.back(from: nil)
                }
            )
        }
    }
    
    func back(from origin: String?) {
        if controller?.presentingViewController != nil {
            controller?.dismiss(animated: true) {
                self.navigationHandler?.onPopViewController(with: origin)
            }
            return
        }
        controller?.navigationController?.popViewController(animated: true)
        navigationHandler?.onPopViewController(with: origin)
    }
    
    func navigateToTransactionsList() {
        if controller?.presentingViewController != nil {
            controller?.dismiss(animated: false) {
                self.navigationHandler?.navigateToTransactionsList()
            }
            return
        }
        controller?.navigationController?.popViewController(animated: false)
        navigationHandler?.navigateToTransactionsList()
    }
}
