import Foundation

internal enum DictRepository: NetworkTask {
    case med(DICTModel)
    case list(DICTListModel)
}

extension DictRepository {
    var baseURL: NetworkBaseURL {
        guard let url = URL(string: Environment.base.rawValue) else {
            fatalError("Base URL Invalid")
        }
        return .url(url)
    }
    
    var path: String {
        switch self {
        case .med:
            return "api/v1/med-requests"
        case .list:
            return "api/v1/med-requests/list-url"
        }
    }
    
    var method: NetworkMethod {
        switch self {
        case .med, .list:
            return .post
        }
    }
    
    var params: [String : Any] {
        switch self {
        case .med(let dict):
            return dict.body()
        case .list(let dto):
            return dto.body()
        }
    }
    
    var encoding: EncodingMethod {
        switch self {
        case .med, .list:
            return .body
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .med, .list:
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
