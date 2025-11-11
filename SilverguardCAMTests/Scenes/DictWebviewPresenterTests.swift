import Foundation
import Testing
@testable import SilverguardCAM

@Suite("DictWebviewPresenter")
struct DictWebviewPresenterTests {
    @Test
    func loading_start_showsLoading() {
        let coordinator = DictWebviewCoordinatorSpy()
        let controller = DictWebviewViewControllerSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)
        sut.controller = controller

        sut.loading(true)

        #expect(coordinator.startedLoading.count == 1)
        #expect(coordinator.startedLoading.first?.message == Localizable.Loading.message)
    }

    @Test
    func loading_stop_hidesLoading() {
        let coordinator = DictWebviewCoordinatorSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)

        sut.loading(false)

        #expect(coordinator.stoppedLoadingCount == 1)
    }

    @Test
    func load_forwardsToController() {
        let coordinator = DictWebviewCoordinatorSpy()
        let controller = DictWebviewViewControllerSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)
        sut.controller = controller

        sut.load(webview: URL(string: "https://cam.sosgolpe.com.br")!)

        #expect(controller.loadedURLs.count == 1)
    }

    @Test
    func error_presentsFeedback() {
        let coordinator = DictWebviewCoordinatorSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)

        sut.error(.unauthorized)

        #expect(coordinator.presentedFeedback.count == 1)
    }

    @Test
    func back_notifiesCoordinator() {
        let coordinator = DictWebviewCoordinatorSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)

        sut.back(from: "origin")

        #expect(coordinator.backOrigins == ["origin"])
    }

    @Test
    func sendCommand_routesToController() {
        let coordinator = DictWebviewCoordinatorSpy()
        let controller = DictWebviewViewControllerSpy()
        let sut = DictWebviewPresenter(coordinator: coordinator)
        sut.controller = controller

        sut.sendCommand(.microphonePermission, payload: ["status": "authorized"])

        #expect(controller.sentCommands.count == 1)
        #expect(controller.sentCommands.first?.1?["status"] == "authorized")
    }
}


