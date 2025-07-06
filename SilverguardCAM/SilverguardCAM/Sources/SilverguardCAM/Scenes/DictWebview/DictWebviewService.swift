protocol DictWebviewServiceProtocol: AnyObject {
    func request(med: DICTModel, completion: @escaping (Result<DICTResponse, NetworkError>) -> Void)
}

final class DictWebviewService: DictWebviewServiceProtocol {
    lazy var network = NetworkManager<DictRepository>()
    
    init() {}
    
    func request(
        med: DICTModel,
        completion: @escaping (Result<DICTResponse, NetworkError>) -> Void
    ) {
        network.request(
            .med(med),
            map: DICTResponse.self,
            result: completion
        )
    }
}
