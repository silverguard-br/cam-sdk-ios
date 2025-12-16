import Foundation

public protocol SilverguardNavigationHandlerDelegate: AnyObject {
    func onPopViewController(with command: String?)
    func navigateToTransactionsList()
}

public extension SilverguardNavigationHandlerDelegate {
    func navigateToTransactionsList() { }
}
