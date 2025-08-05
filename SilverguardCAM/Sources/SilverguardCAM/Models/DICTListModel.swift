import Foundation

public struct DICTListModel: BodyEncodable {
    let reporterClientId: String
    
    public init(reporterClientId: String) {
        self.reporterClientId = reporterClientId
    }
}
