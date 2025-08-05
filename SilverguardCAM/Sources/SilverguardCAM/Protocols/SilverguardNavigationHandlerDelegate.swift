import Foundation

public protocol SilverguardNavigationHandlerDelegate: AnyObject {
    func onPopViewController(with command: String?)
}
