import UIKit

final class PermissionService: PermissionServicing {
    private let microphoneService: PermissionProviding
    private let libraryService: PermissionProviding
    private let cameraService: PermissionProviding
    
    init(
        microphoneService: PermissionProviding = MicrophonePermissionProvider(),
        libraryService: PermissionProviding = LibraryPermissionProvider(),
        cameraService: PermissionProviding = CameraPermissionProvider()
    ) {
        self.microphoneService = microphoneService
        self.libraryService = libraryService
        self.cameraService = cameraService
    }
    
    func requestPermission(
        for type: PermissionType,
        completion: @escaping (PermissionStatus) -> Void
    ) {
        if currentStatus(for: type) == .denied {
            completion(.denied)
            return
        }
        switch type {
        case .microphone:
            microphoneService.requestPermission(completion: completion)
        case .library:
            libraryService.requestPermission(completion: completion)
        case .camera:
            cameraService.requestPermission(completion: completion)
        }
    }
    
    func currentStatus(
        for type: PermissionType
    ) -> PermissionStatus {
        switch type {
        case .microphone:
            return microphoneService.currentStatus()
        case .library:
            return libraryService.currentStatus()
        case .camera:
            return cameraService.currentStatus()
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
