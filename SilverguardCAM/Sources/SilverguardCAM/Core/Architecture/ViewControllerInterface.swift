import UIKit

protocol ViewControllerConfiguration: AnyObject {
    func buildViews()
    func configureViews()
    func configureConstraints()
    func configureBindings()
    func configureAccessibility()
}
