import UIKit

final class DefaultColors: ColorsProtocol {
    let background: UIColor = .init(hex: "#FFFFFF") ?? .white
    
    let primary: UIColor = .init(hex: "#1B264F") ?? .systemBlue
    let primary04: UIColor = .init(hex: "#F0F3FB") ?? .systemBlue.withAlphaComponent(0.8)
    
    let label: UIColor = .init(hex: "#282828") ?? .label
    
    var buttonTitle: UIColor = .init(hex: "#FEFEFE") ?? .white
    
    let surface: UIColor = .init(hex: "#212121") ?? .label
    
    let buttonEnabled: UIColor = .init(hex: "#1B264F") ?? .systemBlue
    let buttonDisabled: UIColor = .init(hex: "#767D95") ?? .systemBlue
}
