import Foundation
import Testing
@testable import SilverguardCAM

@Suite("NetworkManager")
struct NetworkManagerTests {
    private let baseURL = URL(string: "https://example.com")!

    @Test("Builds request and maps success")
    func request_success() async {
        let session = URLSessionStub()
        session.nextData = """
        {"message":"ok"}
        """.data(using: .utf8)
        session.nextResponse = HTTPURLResponse(
            url: baseURL,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil
        )

        let task = NetworkTaskStub(
            baseURL: .url(baseURL),
            path: "api/test",
            method: .post,
            params: ["foo": "bar"],
            encoding: .body,
            headers: ["Authorization": "Bearer token"]
        )
        let sut = NetworkManager<NetworkTaskStub>()

        let result: Result<MockResponse, NetworkError> = await awaitResult { continuation in
            sut.request(
                task,
                map: MockResponse.self,
                session: session,
                result: { continuation($0) }
            )
        }

        #expect(session.requested.count == 1)
        #expect(session.resumeCallCount == 1)

        let request = session.requested.first
        #expect(request?.url?.absoluteString == "https://example.com/api/test")
        #expect(request?.httpMethod == NetworkMethod.post.httpMethod)
        #expect(request?.allHTTPHeaderFields?["Authorization"] == "Bearer token")

        if let body = request?.httpBody,
           let json = try? JSONSerialization.jsonObject(with: body) as? [String: String] {
            #expect(json["foo"] == "bar")
        } else {
            Issue.record("Expected HTTP body with params")
        }

        switch result {
        case .success(let response):
            #expect(response == .init(message: "ok"))
        case .failure(let error):
            Issue.record("Unexpected failure: \(error)")
        }
    }

    @Test("Propagates bad request")
    func request_badRequest() async {
        let session = URLSessionStub()
        session.nextData = """
        {"error":"invalid"}
        """.data(using: .utf8)
        session.nextResponse = HTTPURLResponse(
            url: baseURL,
            statusCode: 400,
            httpVersion: nil,
            headerFields: nil
        )

        let task = NetworkTaskStub(
            baseURL: .url(baseURL),
            path: "api/test",
            method: .post,
            params: [:],
            encoding: .body,
            headers: nil
        )
        let sut = NetworkManager<NetworkTaskStub>()

        let result: Result<MockResponse, NetworkError> = await awaitResult { continuation in
            sut.request(
                task,
                map: MockResponse.self,
                session: session,
                result: { continuation($0) }
            )
        }

        switch result {
        case .success:
            Issue.record("Expected failure")
        case .failure(let error):
            guard case .badRequest = error else {
                Issue.record("Expected badRequest, got \(error)")
                return
            }
        }
    }
}

private struct MockResponse: Decodable, Equatable {
    let message: String
}


