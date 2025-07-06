import Foundation

internal enum DictRepository: NetworkTask {
    case med(DICTModel)
}

extension DictRepository {
    var baseURL: NetworkBaseURL {
        guard let url = URL(string: BaseURL.debug.rawValue) else {
            fatalError("Base URL Invalid")
        }
        return .url(url)
    }
    
    var path: String {
        switch self {
        case .med:
            return "api/v1/med-requests"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .med:
            return .post
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .med(let dict):
            return dict.body()
        }
    }
    
    var encoding: EncodingMethod {
        switch self {
        case .med:
            return .body
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .med:
            let apiKey = SecureStorage.shared.get(key: .apiKey) ?? ""
            return [
                "Authorization": "Bearer \(apiKey)",
                "Content-Type": "application/json",
                "Accept": "application/json",
                "platform": "iOS"
            ]
        }
    }
}
