import Foundation

public struct DICTListModel: BodyEncodable {
    let reporterClientId: String
    let reporterBranchNumber: Int?
    let reporterAccountNumber: Int?
    
    public init(
        reporterClientId: String,
        reporterBranchNumber: Int? = nil,
        reporterAccountNumber: Int? = nil
    ) {
        self.reporterClientId = reporterClientId
        self.reporterAccountNumber = reporterAccountNumber
        self.reporterBranchNumber = reporterBranchNumber
    }
}
