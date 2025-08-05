import UIKit

public typealias SilverguardCAMProtocol = SilverguardCAMConfiguring & SilverguardCAMFactory

public protocol SilverguardCAMConfiguring {
    @discardableResult
    static func configure(with apiKey: APIKey) -> SilverguardCAMProtocol.Type
    @discardableResult
    static func setStyle(colors: any ColorsProtocol) -> SilverguardCAMProtocol.Type
    @discardableResult
    static func setFonts(fonts: any FontsProtocol) -> SilverguardCAMProtocol.Type
}

public protocol SilverguardCAMFactory {
    static func start(with dto: DICTModel, navigationHandler: SilverguardNavigationHandlerDelegate) -> UIViewController
    static func start(for dictList: DICTListModel, navigationHandler: SilverguardNavigationHandlerDelegate) -> UIViewController
}

public final class SilverguardCAM: SilverguardCAMConfiguring, SilverguardCAMFactory {
    static let storage: SecureStoraging = SecureStorage.shared
    
    private init() {}
    
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
    public static func setFonts(fonts: any FontsProtocol) -> SilverguardCAMProtocol.Type {
        Stylesheet.setFonts(fonts: fonts)
        return SilverguardCAM.self
    }
    
    @discardableResult
    public static func start(
        with dto: DICTModel,
        navigationHandler: SilverguardNavigationHandlerDelegate
    ) -> UIViewController {
        DictWebviewFactory.create(dict: dto, navigationHandler: navigationHandler)
    }
    
    @discardableResult
    public static func start(
        for dictList: DICTListModel,
        navigationHandler: SilverguardNavigationHandlerDelegate
    ) -> UIViewController {
        DictWebviewFactory.create(list: dictList, navigationHandler: navigationHandler)
    }
}
