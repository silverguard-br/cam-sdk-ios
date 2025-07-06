import Foundation
import UIKit

protocol FeedbackCoordinatorProtocol: AnyObject {
    func onClick()
}

final class FeedbackCoordinator: FeedbackCoordinatorProtocol {
    public weak var controller: UIViewController?
    var completion: (() -> Void)? = nil
    
    public init() { }

    func onClick() {
        controller?.dismiss(animated: false) { [weak self] in
            self?.completion?()
        }
    }
}
