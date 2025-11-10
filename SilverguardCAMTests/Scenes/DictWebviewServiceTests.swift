import Foundation
import Testing
@testable import SilverguardCAM

@Suite("DictWebviewService")
struct DictWebviewServiceTests {
    @Test
    func request_forwardsToNetworkManager_success() async {
        let network = NetworkManagerSpy()
        network.resultToReturn = .success(.init(data: .init(url: "https://cam.sosgolpe.com.br")))
        let sut = DictWebviewService(network: network)
        let repository = DictRepository.list(.init(reporterClientId: "id"))

        let result: Result<DICTResponse, NetworkError> = await awaitResult { continuation in
            sut.request(endpoint: repository) { continuation($0) }
        }

        #expect(network.requested.count == 1)

        switch result {
        case .success(let response):
            #expect(response.data.url == "https://cam.sosgolpe.com.br")
        case .failure(let error):
            Issue.record("Unexpected failure: \(error)")
        }
    }

    @Test
    func request_forwardsFailure() async {
        let network = NetworkManagerSpy()
        network.resultToReturn = .failure(.unauthorized)
        let sut = DictWebviewService(network: network)
        let repository = DictRepository.list(.init(reporterClientId: "id"))

        let result: Result<DICTResponse, NetworkError> = await awaitResult { continuation in
            sut.request(endpoint: repository) { continuation($0) }
        }

        switch result {
        case .success:
            Issue.record("Expected failure")
        case .failure(let error):
            guard case .unauthorized = error else {
                Issue.record("Expected unauthorized, got \(error)")
                return
            }
        }
    }
}

private final class NetworkManagerSpy: NetworkManager<DictRepository> {
    private(set) var requested: [DictRepository] = []
    var resultToReturn: Result<DICTResponse, NetworkError>?

    override func request<T>(
        _ network: DictRepository,
        map: T.Type,
        session: URLSession = URLSession.shared,
        result: @escaping ((Result<T, NetworkError>) -> Void)
    ) where T : Decodable {
        requested.append(network)
        guard let resultToReturn else {
            return
        }
        switch resultToReturn {
        case .success(let response):
            if let casted = response as? T {
                result(.success(casted))
            }
        case .failure(let error):
            result(.failure(error))
        }
    }
}

