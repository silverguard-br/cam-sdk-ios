import Foundation

protocol BodyEncodable: Codable {
    func body() -> [String: Any]
}

extension BodyEncodable {
    func body() -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        do {
            let data = try encoder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])

            guard let dict = jsonObject as? [String: Any] else {
                throw NSError(domain: "Invalid JSON structure", code: 0, userInfo: nil)
            }
            
            return dict
        } catch {
            return [:]
        }
    }
}
