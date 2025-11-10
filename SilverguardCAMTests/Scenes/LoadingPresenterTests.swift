import Foundation
import Testing
@testable import SilverguardCAM

@Suite("LoadingPresenter")
struct LoadingPresenterTests {
    @Test
    func configure_updatesController() {
        let coordinator = LoadingCoordinatorSpy()
        let controller = LoadingViewControllerSpy()
        let sut = LoadingPresenter(coordinator: coordinator)
        sut.controller = controller
        let dto = LoadingDTO(message: "Loading")

        sut.configure(dto)

        #expect(controller.configuredDTOs == [dto])
    }

    @Test
    func finish_routesToCoordinator() {
        let coordinator = LoadingCoordinatorSpy()
        let sut = LoadingPresenter(coordinator: coordinator)

        var completionCalled = false
        sut.finish {
            completionCalled = true
        }

        #expect(coordinator.finishHandlers.count == 1)
        coordinator.finishHandlers.first?()
        #expect(completionCalled)
    }
}


