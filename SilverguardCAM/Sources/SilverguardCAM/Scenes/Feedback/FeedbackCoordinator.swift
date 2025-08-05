import Foundation
import UIKit

protocol FeedbackCoordinatorProtocol: AnyObject {
    func onClick()
}

final class FeedbackCoordinator: FeedbackCoordinatorProtocol {
    public weak var controller: UIViewController?
    var completion: ((UIViewController) -> Void)? = nil
    
    public init() { }

    func onClick() {
        guard let controller else { return }
        controller.dismiss(animated: false) { [weak self] in
            self?.completion?(controller)
        }
    }
}
