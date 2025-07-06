import AVFoundation

final class MicrophonePermissionProvider: PermissionProviding {
    
    init() {}
    
    func requestPermission(completion: @escaping (PermissionStatus) -> Void) {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            completion(.authorized)
        case .denied:
            completion(.denied)
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    completion(granted ? .authorized : .denied)
                }
            }
        @unknown default:
            completion(.notDetermined)
        }
    }
    
    func currentStatus() -> PermissionStatus {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            return .authorized
        case .denied:
            return .denied
        case .undetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }
}
