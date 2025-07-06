final class WebViewCommandRegistry {
    static func registerAllCommands() {
        let commands: [JSCommand] = JSCommand.allCases
        
        for command in commands {
            WebViewCommandCenter.shared.register(command: command)
        }
    }
}
