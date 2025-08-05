import Foundation

public struct DICTModel: BodyEncodable {
    let transactionId: String
    let transactionAmount: Double
    let transactionTim: String
    let transactionDescription: String
    let reporterClientName: String
    let reporterClientId: Int
    let contestedParticipantId: String
    let counterpartyClientName: String
    let counterpartyClientId: Int
    let counterpartyClientKey: String
    let protocolId: String
    let pixAuto: Bool
    let clientId: String
    let clientSince: String
    let clientBirth: String
    let autofraudRisk: Bool

    init(
        transactionId: String,
        transactionAmount: Double,
        transactionTim: String,
        transactionDescription: String,
        reporterClientName: String,
        reporterClientId: Int,
        contestedParticipantId: String,
        counterpartyClientName: String,
        counterpartyClientId: Int,
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
        self.transactionTim = transactionTim
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
