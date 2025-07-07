public protocol Styling {
    static func setStyle(color: ColorsProtocol)
    static func setFonts(fonts: FontsProtocol)
}

public final class Stylesheet: Styling {
    static var colors: ColorsProtocol = DefaultColors()
    static var fonts: FontsProtocol = DefaultFonts()
    
    public static func setStyle(color: ColorsProtocol) {
        Stylesheet.colors = color
    }
    
    public static func setFonts(fonts: FontsProtocol) {
        Stylesheet.fonts = fonts
    }
}
