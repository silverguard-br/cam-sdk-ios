final class WebViewCommandCenter {
    static let shared = WebViewCommandCenter()

    private var allowedCommands: Set<JSCommand> = []

    private init() {}

    func register(command: JSCommand) {
        allowedCommands.insert(command)
    }

    func isRegistered(_ command: JSCommand) -> Bool {
        allowedCommands.contains(command)
    }
}
