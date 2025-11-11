import Foundation
import Testing
@testable import SilverguardCAM

@Suite("PermissionService")
struct PermissionServiceTests {
    @Test
    func requestPermission_shortCircuitsDenied() async {
        let microphone = PermissionProviderStub(currentStatus: .denied)
        let library = PermissionProviderStub()
        let sut = PermissionService(
            microphoneService: microphone,
            libraryService: library
        )

        let status: PermissionStatus = await awaitResult { continuation in
            sut.requestPermission(for: .microphone) { continuation($0) }
        }

        #expect(status == .denied)
        #expect(microphone.requestCallCount == 0)
    }

    @Test
    func requestPermission_forwardedToProviders() async {
        let microphone = PermissionProviderStub(
            currentStatus: .notDetermined,
            requestStatuses: [.authorized]
        )
        let library = PermissionProviderStub()
        let sut = PermissionService(
            microphoneService: microphone,
            libraryService: library
        )

        let status: PermissionStatus = await awaitResult { continuation in
            sut.requestPermission(for: .microphone) { continuation($0) }
        }

        #expect(status == .authorized)
        #expect(microphone.requestCallCount == 1)
    }

    @Test
    func currentStatus_returnsProviderValue() {
        let microphone = PermissionProviderStub(currentStatus: .authorized)
        let library = PermissionProviderStub(currentStatus: .denied)
        let sut = PermissionService(
            microphoneService: microphone,
            libraryService: library
        )

        #expect(sut.currentStatus(for: .microphone) == .authorized)
        #expect(sut.currentStatus(for: .library) == .denied)
    }
}


