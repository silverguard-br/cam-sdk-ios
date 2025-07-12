enum JSCommand: String, CaseIterable {
    case back
    case askForMicrophone = "requestMicrophonePermission"
    case askForLibrary = "requestLibraryPermission"
    case openSettings
}

enum JSAnswer: String, CaseIterable {
    case microphonePermission
    case libraryPermission
}
