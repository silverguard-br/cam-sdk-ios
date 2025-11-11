import Testing
@testable import SilverguardCAM

@Suite("Web Module", .serialized)
struct WebModuleTests {
    @Test
    func allowList_acceptsWhitelistedHosts() {
        let url = URL(string: "https://cam.sosgolpe.com.br/path")!

        #expect(AllowList.check(url))
    }

    @Test
    func allowList_rejectsUnknownHosts() {
        let url = URL(string: "https://example.com")!

        #expect(AllowList.check(url) == false)
    }

    @Test
    func commandCenter_registersCommand() {
        let command = JSCommand.askForLibrary
        WebViewCommandCenter.shared.register(command: command)

        #expect(WebViewCommandCenter.shared.isRegistered(command))
    }

    @MainActor
    @Test
    func webViewManager_triggersAllowListErrorForInvalidHost() {
        let manager = WebViewManager()
        var errorCount = 0
        var startCount = 0
        var stopCount = 0

        manager.configure(
            start: { startCount += 1 },
            stop: { stopCount += 1 },
            error: { errorCount += 1 }
        )

        _ = manager.load(url: URL(string: "https://invalid.com")!)

        #expect(errorCount == 1)
        #expect(startCount == 0)
        #expect(stopCount == 0)
    }
}

