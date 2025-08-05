import Foundation

public struct DICTModel: BodyEncodable {
    let transactionId: String
    let transactionAmount: Double
    let transactionTime: String
    let transactionDescription: String
    let reporterClientName: String
    let reporterClientId: String
    let contestedParticipantId: String
    let counterpartyClientName: String
    let counterpartyClientId: String
    let counterpartyClientKey: String
    let protocolId: String
    let pixAuto: Bool
    let clientId: String
    let clientSince: String
    let clientBirth: String
    let autofraudRisk: Bool

    public init(
        transactionId: String,
        transactionAmount: Double,
        transactionTime: String,
        transactionDescription: String,
        reporterClientName: String,
        reporterClientId: String,
        contestedParticipantId: String,
        counterpartyClientName: String,
        counterpartyClientId: String,
        counterpartyClientKey: String,
        protocolId: String,
        pixAuto: Bool,
        clientId: String,
        clientSince: String,
        clientBirth: String,
        autofraudRisk: Bool
    ) {
        self.transactionId = transactionId
        self.transactionAmount = transactionAmount
        self.transactionTime = transactionTime
        self.transactionDescription = transactionDescription
        self.reporterClientName = reporterClientName
        self.reporterClientId = reporterClientId
        self.contestedParticipantId = contestedParticipantId
        self.counterpartyClientName = counterpartyClientName
        self.counterpartyClientId = counterpartyClientId
        self.counterpartyClientKey = counterpartyClientKey
        self.protocolId = protocolId
        self.pixAuto = pixAuto
        self.clientId = clientId
        self.clientSince = clientSince
        self.clientBirth = clientBirth
        self.autofraudRisk = autofraudRisk
    }
}
