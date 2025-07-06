import Foundation
import UIKit

protocol LoadingCoordinatorProtocol: AnyObject {
    func finish(_ completion: @escaping () -> Void)
}

final class LoadingCoordinator: LoadingCoordinatorProtocol {
    public weak var controller: UIViewController?
    
    public init() { }

    func finish(_ completion: @escaping () -> Void) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.controller?.view.alpha = 0
            }, completion: { [weak self] _ in
                self?.controller?.view.removeFromSuperview()
                self?.controller?.removeFromParent()
                completion()
            })
        }
    }
}
