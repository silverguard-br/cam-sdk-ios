import Photos

final class LibraryPermissionProvider: PermissionProviding {
    
    init() {}

    func requestPermission(completion: @escaping (PermissionStatus) -> Void) {
        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch status {
            case .authorized, .limited:
                completion(.authorized)
            case .denied, .restricted:
                completion(.denied)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                    DispatchQueue.main.async {
                        switch newStatus {
                        case .authorized, .limited:
                            completion(.authorized)
                        case .denied, .restricted:
                            completion(.denied)
                        case .notDetermined:
                            completion(.notDetermined)
                        @unknown default:
                            completion(.notDetermined)
                        }
                    }
                }
            @unknown default:
                completion(.notDetermined)
            }
        }
        
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            completion(.authorized)
        case .denied, .restricted:
            completion(.denied)
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { newStatus in
                DispatchQueue.main.async {
                    switch newStatus {
                    case .authorized:
                        completion(.authorized)
                    case .denied, .restricted:
                        completion(.denied)
                    case .notDetermined:
                        completion(.notDetermined)
                    @unknown default:
                        completion(.notDetermined)
                    }
                }
            }
        @unknown default:
            completion(.notDetermined)
        }
    }

    func currentStatus() -> PermissionStatus {
        if #available(iOS 14, *) {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            switch status {
            case .authorized, .limited:
                return .authorized
            case .denied, .restricted:
                return .denied
            case .notDetermined:
                return .notDetermined
            @unknown default:
                return .notDetermined
            }
        }
        
        let legacyStatus = PHPhotoLibrary.authorizationStatus()
        switch legacyStatus {
        case .authorized:
            return .authorized
        case .denied, .restricted:
            return .denied
        case .notDetermined:
            return .notDetermined
        @unknown default:
            return .notDetermined
        }
    }
}
