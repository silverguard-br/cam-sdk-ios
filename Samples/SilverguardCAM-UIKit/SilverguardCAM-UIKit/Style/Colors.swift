import UIKit
import SilverguardCAM

final class CustomColors: ColorsProtocol {
    let background: UIColor = UIColor(hex: "#FFFFFF") ?? .white

    let primary: UIColor = UIColor(hex: "#9E0031") ?? .systemBlue
    let primary04: UIColor = UIColor(hex: "#9E0031")?.withAlphaComponent(0.2) ?? .systemBlue.withAlphaComponent(0.8)

    let label: UIColor = UIColor(hex: "#282828") ?? .label

    var buttonTitle: UIColor = UIColor(hex: "#FFFFFF") ?? .white

    let surface: UIColor = UIColor(hex: "#212121") ?? .label

    let buttonEnabled: UIColor = UIColor(hex: "#9E0031") ?? .systemBlue
    let buttonDisabled: UIColor = UIColor(hex: "#F9B9B7") ?? .systemBlue
}

final class DefaultColors: ColorsProtocol {
    let background: UIColor = UIColor(hex: "#FFFFFF") ?? .white

    let primary: UIColor = UIColor(hex: "#1B264F") ?? .systemBlue
    let primary04: UIColor = UIColor(hex: "#F0F3FB") ?? .systemBlue.withAlphaComponent(0.8)

    let label: UIColor = UIColor(hex: "#282828") ?? .label

    var buttonTitle: UIColor = UIColor(hex: "#FEFEFE") ?? .white

    let surface: UIColor = UIColor(hex: "#212121") ?? .label

    let buttonEnabled: UIColor = UIColor(hex: "#1B264F") ?? .systemBlue
    let buttonDisabled: UIColor = UIColor(hex: "#767D95") ?? .systemBlue
}

