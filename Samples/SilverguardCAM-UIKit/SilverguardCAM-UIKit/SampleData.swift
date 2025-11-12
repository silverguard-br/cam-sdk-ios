import Foundation
import SilverguardCAM

enum SampleDataFactory {
    static func makeFullModel() -> DICTModel {
        DICTModel(
            transactionId: UUID().uuidString,
            transactionAmount: 100,
            transactionTime: currentDateString() ?? "2025-07-10 11:10:00",
            transactionDescription: "Pagamento via PIX",
            reporterClientName: "Fulano de Tal",
            reporterClientId: "12345678901234",
            contestedParticipantId: "123456",
            counterpartyClientName: "John Doe",
            counterpartyClientId: "12345678901",
            counterpartyClientKey: "cpf",
            protocolId: UUID().uuidString,
            pixAuto: true,
            clientId: "CLI_456789",
            clientSince: "2020-01-15",
            clientBirth: "1985-03-22",
            autofraudRisk: true,
            reporterBranchNumber: nil,
            reporterAccountNumber: nil
        )
    }

    static func makeMinimalModel() -> DICTModel {
        DICTModel(
            transactionId: UUID().uuidString,
            transactionAmount: 100,
            transactionTime: currentDateString() ?? "2025-07-10 11:10:00",
            reporterClientName: "Fulano de Tal",
            reporterClientId: "12345678901234",
            contestedParticipantId: "123456",
            counterpartyClientName: "John Doe",
            counterpartyClientId: "12345678901"
        )
    }

    private static func currentDateString() -> String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.timeZone = TimeZone(identifier: "America/Sao_Paulo")
        return formatter.string(from: Date())
    }
}

