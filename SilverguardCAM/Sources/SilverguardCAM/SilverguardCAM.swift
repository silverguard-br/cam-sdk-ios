import UIKit

public typealias SilverguardCAMProtocol = SilverguardCAMConfiguring & SilverguardCAMFactory

public protocol SilverguardCAMConfiguring {
    @discardableResult
    static func configure(with apiKey: APIKey) -> SilverguardCAMProtocol.Type
    @discardableResult
    static func setStyle(colors: any ColorsProtocol) -> SilverguardCAMProtocol.Type
}

public protocol SilverguardCAMFactory {
    static func start(with dto: DICTModel) -> UIViewController
}

public final class SilverguardCAM: SilverguardCAMConfiguring, SilverguardCAMFactory {
    static let storage: SecureStoraging = SecureStorage.shared
    
    private init() {
    }
    
    @discardableResult
    public static func configure(
        with apiKey: APIKey
    ) -> SilverguardCAMProtocol.Type {
        storage.set(key: .apiKey, value: apiKey)
        WebViewCommandRegistry.registerAllCommands()
        BundleAssets.configure()
        return SilverguardCAM.self
    }
    
    @discardableResult
    public static func setStyle(colors: any ColorsProtocol) -> SilverguardCAMProtocol.Type {
        Stylesheet.setStyle(color: colors)
        return SilverguardCAM.self
    }
    
    @discardableResult
    public static func start(
        with dto: DICTModel
    ) -> UIViewController {
        DictWebviewFactory.create(dict: dto)
    }
}
