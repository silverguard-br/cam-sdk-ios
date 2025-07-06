import Foundation

internal protocol SecureStoraging {
    @discardableResult
    func get(key: SecureKeys) -> String?
    @discardableResult
    func set(key: SecureKeys, value: String) -> Bool
    @discardableResult
    func delete(key: SecureKeys) -> Bool
}

internal final class SecureStorage: SecureStoraging {
    static let shared = SecureStorage()
    
    private init () {}
    
    @discardableResult
    func get(key: SecureKeys) -> String? {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecReturnData as String  : true,
            kSecMatchLimit as String  : kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard
            status == errSecSuccess,
            let data = item as? Data,
            let string = String(data: data, encoding: .utf8)
        else {
            return nil
        }
        
        return string
    }
    
    @discardableResult
    func set(key: SecureKeys, value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        
        let queryDelete: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue
        ]
        SecItemDelete(queryDelete as CFDictionary)
        
        let queryAdd: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue,
            kSecValueData as String   : data
        ]
        
        let status = SecItemAdd(queryAdd as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    @discardableResult
    func delete(key: SecureKeys) -> Bool {
        let query: [String: Any] = [
            kSecClass as String       : kSecClassGenericPassword,
            kSecAttrAccount as String : key.rawValue
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
