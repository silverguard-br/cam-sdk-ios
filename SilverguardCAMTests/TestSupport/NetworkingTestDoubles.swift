import Foundation
@testable import SilverguardCAM

final class URLSessionStub: URLSession, @unchecked Sendable {
    private let queue: DispatchQueue

    var requested: [URLRequest] = []
    var nextData: Data?
    var nextResponse: URLResponse?
    var nextError: Error?
    private(set) var resumeCallCount = 0

    override init() {
        queue = DispatchQueue(label: "URLSessionStub.queue")
        super.init()
    }

    override func dataTask(
        with request: URLRequest,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        requested.append(request)
        let data = nextData
        let response = nextResponse
        let error = nextError
        return URLSessionDataTaskStub { [weak self] in
            self?.resumeCallCount += 1
            self?.queue.async {
                completionHandler(data, response, error)
            }
        }
    }

    final class URLSessionDataTaskStub: URLSessionDataTask {
        private let onResume: () -> Void

        init(onResume: @escaping () -> Void) {
            self.onResume = onResume
        }

        override func resume() {
            onResume()
        }
    }
}

struct NetworkTaskStub: NetworkTask {
    var baseURL: NetworkBaseURL
    var path: String
    var method: NetworkMethod
    var params: [String: Any]
    var encoding: EncodingMethod
    var headers: [String: String]?
}

