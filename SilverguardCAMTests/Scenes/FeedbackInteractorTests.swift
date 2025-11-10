import Foundation
import Testing
@testable import SilverguardCAM

@Suite("FeedbackInteractor")
struct FeedbackInteractorTests {
    @Test
    func didLoad_configuresPresenter() {
        let presenter = FeedbackPresenterSpy()
        let dto = FeedbackDTO(
            title: "Title",
            message: "Message",
            buttonTitle: "OK",
            image: .warning
        )
        let sut = FeedbackInteractor(presenter: presenter, feedbackDto: dto)

        sut.didLoad()

        #expect(presenter.configuredDTOs == [dto])
    }

    @Test
    func onClick_forwardsToPresenter() {
        let presenter = FeedbackPresenterSpy()
        let sut = FeedbackInteractor(presenter: presenter, feedbackDto: .common())

        sut.onClick()

        #expect(presenter.didTapCount == 1)
    }
}


