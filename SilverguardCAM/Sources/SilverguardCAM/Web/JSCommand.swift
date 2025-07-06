enum JSCommand: String, CaseIterable {
    case back
    case askForMicrophone
    case askForLibrary
}

enum JSAnswer: String, CaseIterable {
    case microphonePermission
    case libraryPermission
}
