enum JSCommand: String, CaseIterable {
    case back
    case askForMicrophone = "requestMicrophonePermission"
    case askForLibrary = "requestLibraryPermission"
}

enum JSAnswer: String, CaseIterable {
    case microphonePermission
    case libraryPermission
}
