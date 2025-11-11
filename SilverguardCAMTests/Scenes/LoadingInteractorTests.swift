import Foundation
import Testing
@testable import SilverguardCAM

@Suite("LoadingInteractor")
struct LoadingInteractorTests {
    @Test
    func didLoad_configuresPresenter() {
        let presenter = LoadingPresenterSpy()
        let dto = LoadingDTO(message: "Loading")
        let sut = LoadingInteractor(presenter: presenter, loadingDTO: dto)

        sut.didLoad()

        #expect(presenter.configuredDTOs == [dto])
    }

    @Test
    func finish_forwardsToPresenter() {
        let presenter = LoadingPresenterSpy()
        let sut = LoadingInteractor(presenter: presenter, loadingDTO: .init(message: "Loading"))

        var completionCalled = false
        sut.finish {
            completionCalled = true
        }

        #expect(presenter.finishHandlers.count == 1)
        presenter.finishHandlers.first?()
        #expect(completionCalled)
    }
}


