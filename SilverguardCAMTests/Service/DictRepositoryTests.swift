import Foundation
import Testing
@testable import SilverguardCAM

@Suite("DictRepository")
struct DictRepositoryTests {
    @Test
    func med_buildsRequest() {
        Environment.setEnvironment(.staging)

        let model = DICTModel(
            transactionId: "123",
            transactionAmount: 10,
            transactionTime: "2023-12-01",
            transactionDescription: "Test",
            reporterClientName: "Reporter",
            reporterClientId: "ReporterId",
            contestedParticipantId: "Contest",
            counterpartyClientName: "Counter",
            counterpartyClientId: "CounterId",
            counterpartyClientKey: "Key",
            protocolId: "Protocol",
            pixAuto: false,
            clientId: "Client",
            clientSince: "2020-01-01",
            clientBirth: "1990-01-01",
            autofraudRisk: true,
            reporterBranchNumber: 1,
            reporterAccountNumber: 2
        )

        let repository = DictRepository.med(model)

        guard case .url(let url) = repository.baseURL else {
            Issue.record("Expected base URL")
            return
        }
        #expect(url.absoluteString == BaseURL.staging.rawValue)
        #expect(repository.path == "api/v1/med-requests")
        #expect(repository.method == .post)
        #expect(repository.encoding == .body)
        #expect(repository.params["transaction_id"] as? String == "123")
        #expect(repository.params["client_id"] as? String == "Client")

        let headers = repository.headers
        #expect(headers?["Authorization"] == "Bearer ")
        #expect(headers?["Content-Type"] == "application/json")
        #expect(headers?["platform"] == "iOS")
    }

    @Test
    func list_buildsRequest() {
        let model = DICTListModel(
            reporterClientId: "ReporterId",
            reporterBranchNumber: 1,
            reporterAccountNumber: 2
        )

        let repository = DictRepository.list(model)

        #expect(repository.path == "api/v1/med-requests/list-url")
        #expect(repository.method == .post)
        #expect(repository.encoding == .body)
        #expect(repository.params["reporter_client_id"] as? String == "ReporterId")
        #expect(repository.params["reporter_branch_number"] as? Int == 1)
    }
}


