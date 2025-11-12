import UIKit
import SilverguardCAM

final class CustomFonts: FontsProtocol {
    var button: UIFont = .systemFont(ofSize: 14, weight: .semibold)
    var body: UIFont = .systemFont(ofSize: 14)

    var headline2: UIFont = .systemFont(ofSize: 24, weight: .bold)
    var headline3: UIFont = .systemFont(ofSize: 20, weight: .bold)
}

final class DefaultFonts: FontsProtocol {
    var button: UIFont = UIFont(name: "Figtree-SemiBold", size: 14) ?? .systemFont(ofSize: 14, weight: .semibold)
    var body: UIFont = UIFont(name: "Figtree-Regular", size: 14) ?? .systemFont(ofSize: 14)

    var headline2: UIFont = UIFont(name: "Figtree-Bold", size: 24) ?? .boldSystemFont(ofSize: 24)
    var headline3: UIFont = UIFont(name: "Figtree-Bold", size: 20) ?? .boldSystemFont(ofSize: 20)
}

