import UIKit

enum Fonts {
    public static func regular(size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Regular", size: size) ?? .systemFont(ofSize: size)
    }

    public static func medium(size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }

    public static func semiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }

    public static func bold(size: CGFloat) -> UIFont {
        return UIFont(name: "Figtree-Bold", size: size) ?? .boldSystemFont(ofSize: size)
    }
}
