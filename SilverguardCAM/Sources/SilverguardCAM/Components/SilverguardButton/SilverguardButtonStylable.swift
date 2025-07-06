import UIKit

protocol SilverguardButtonStylable {
    var enabledBackgroundColor: UIColor { get set }
    var disabledBackgroundColor: UIColor { get set }
    var titleColor: UIColor { get set }
    var cornerRadius: CGFloat { get set }
    var titleFont: UIFont { get set }

    func applyStyle()
}

protocol SilverguardButtonLoadable {
    func setLoading(_ loading: Bool)
    func showLoading()
    func hideLoading()
}

protocol SilverguardButtonConfigurable {
    func updateButton()
}
