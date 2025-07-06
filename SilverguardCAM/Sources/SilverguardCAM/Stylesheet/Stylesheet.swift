public protocol Styling {
    static func setStyle(color: ColorsProtocol)
}

public final class Stylesheet: Styling {
    static var colors: ColorsProtocol = DefaultColors()
    static var fonts: FontsProtocol = DefaultFonts()
    
    public static func setStyle(color: ColorsProtocol) {
        Stylesheet.colors = color
    }
}
