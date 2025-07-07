import UIKit
import CoreText

enum FontLoader {
    static func loadFonts() {
        registerFont("Figtree-Regular", ext: "ttf")
        registerFont("Figtree-Medium", ext: "ttf")
        registerFont("Figtree-SemiBold", ext: "ttf")
        registerFont("Figtree-Bold", ext: "ttf")
    }

    private static func registerFont(_ name: String, ext: String) {
        let bundle: Bundle = {
            #if SWIFT_PACKAGE
                return .module
            #else
                return Bundle(for: BundleToken.self)
            #endif
        }()

        guard let url = bundle.url(forResource: name, withExtension: ext) else {
            print("Could not find font: \(name).\(ext)")
            return
        }

        guard let dataProvider = CGDataProvider(url: url as CFURL),
              let font = CGFont(dataProvider) else {
            print("Could not load font: \(name)")
            return
        }

        var error: Unmanaged<CFError>?
        if !CTFontManagerRegisterGraphicsFont(font, &error) {
            print("Failed to register font \(name): \(error?.takeUnretainedValue().localizedDescription ?? "unknown error")")
        }
    }
}
