enum JSCommand: String, CaseIterable {
    case back
    case askForMicrophone = "requestMicrophonePermission"
    case askForLibrary = "requestLibraryPermission"
    case askForCamera = "requestCameraPermission"
    case openSettings
}

enum JSAnswer: String, CaseIterable {
    case microphonePermission
    case libraryPermission
    case cameraPermission
}
