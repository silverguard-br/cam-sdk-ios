import Foundation
import Testing
@testable import SilverguardCAM

@Suite("FeedbackPresenter")
struct FeedbackPresenterTests {
    @Test
    func configure_updatesController() {
        let coordinator = FeedbackCoordinatorSpy()
        let controller = FeedbackViewControllerSpy()
        let sut = FeedbackPresenter(coordinator: coordinator)
        sut.controller = controller
        let dto = FeedbackDTO.common()

        sut.configure(dto)

        #expect(controller.configuredDTO == dto)
    }

    @Test
    func onClick_triggersCoordinator() {
        let coordinator = FeedbackCoordinatorSpy()
        let sut = FeedbackPresenter(coordinator: coordinator)

        sut.onClick()

        #expect(coordinator.onClickCount == 1)
    }
}


