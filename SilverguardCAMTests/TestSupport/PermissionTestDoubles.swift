import Foundation
@testable import SilverguardCAM

final class PermissionProviderStub: PermissionProviding {
    private(set) var requestCallCount = 0
    var currentStatusResult: PermissionStatus
    var requestStatuses: [PermissionStatus]

    init(
        currentStatus: PermissionStatus = .notDetermined,
        requestStatuses: [PermissionStatus] = []
    ) {
        self.currentStatusResult = currentStatus
        self.requestStatuses = requestStatuses
    }

    func requestPermission(completion: @escaping (PermissionStatus) -> Void) {
        requestCallCount += 1
        let status = requestStatuses.isEmpty ? currentStatusResult : requestStatuses.removeFirst()
        completion(status)
    }

    func currentStatus() -> PermissionStatus {
        currentStatusResult
    }
}


