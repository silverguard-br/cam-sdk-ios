import UIKit

struct BundleAssets {
    static func configure() {
        FontLoader.loadFonts()
    }
    
    private static var bundle: Bundle {
        return Bundle(for: BundleToken.self)
    }
    
    public static func image(_ asset: Images) -> UIImage? {
        return UIImage(named: asset.rawValue, in: bundle, compatibleWith: nil)
    }
}
