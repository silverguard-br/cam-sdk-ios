import Foundation

final class AllowList {
    private static func getHosts() -> [String] {
        [
            "test.cam.sosgolpe.com.br",
            "cam.sosgolpe.com.br"
        ]
    }
    
    private static func getSchemes() -> [String] {
        [
            "https"
        ]
    }
    
    static func check(_ url: URL) -> Bool {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        let host = components?.host
        let scheme = components?.scheme
        
        let allowHost = getHosts().contains(host)
        let allowScheme = getSchemes().contains(scheme)
        return allowHost && allowScheme
    }
}

private extension Array where Element == String {
    func contains(_ element: Element?) -> Bool {
        guard let element else { return false }
        return self.contains(element)
    }
}
