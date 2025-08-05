protocol DictWebviewServiceProtocol: AnyObject {
    func request(endpoint: DictRepository, completion: @escaping (Result<DICTResponse, NetworkError>) -> Void)
}

final class DictWebviewService: DictWebviewServiceProtocol {
    lazy var network = NetworkManager<DictRepository>()
    
    init() {}
    
    func request(
        endpoint: DictRepository,
        completion: @escaping (Result<DICTResponse, NetworkError>) -> Void
    ) {
        network.request(
            endpoint,
            map: DICTResponse.self,
            result: completion
        )
    }
}
