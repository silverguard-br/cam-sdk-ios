protocol DictWebviewServiceProtocol: AnyObject {
    func request(endpoint: DictRepository, completion: @escaping (Result<DICTResponse, NetworkError>) -> Void)
}

final class DictWebviewService: DictWebviewServiceProtocol {
    private let network: NetworkManager<DictRepository>
    
    init(network: NetworkManager<DictRepository> = NetworkManager()) {
        self.network = network
    }
    
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
