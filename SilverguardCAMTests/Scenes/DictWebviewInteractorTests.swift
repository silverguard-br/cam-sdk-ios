import Foundation
import Testing
@testable import SilverguardCAM

@Suite("DictWebviewInteractor")
struct DictWebviewInteractorTests {
    private func makeSUT(
        serviceResult: Result<DICTResponse, NetworkError>? = nil
    ) -> (DictWebviewInteractor, DictWebviewPresenterSpy, DictWebviewServiceSpy, PermissionServiceSpy) {
        let presenter = DictWebviewPresenterSpy()
        let service = DictWebviewServiceSpy()
        service.resultToReturn = serviceResult
        let permission = PermissionServiceSpy()
        permission.currentStatusResponses[.microphone] = .notDetermined
        permission.currentStatusResponses[.library] = .notDetermined
        let repository = DictRepository.list(
            .init(reporterClientId: "id")
        )
        let sut = DictWebviewInteractor(
            presenter: presenter,
            service: service,
            permissionService: permission,
            repository: repository
        )
        return (sut, presenter, service, permission)
    }

    @Test
    func load_success_notifiesPresenter() {
        let response = DICTResponse(data: .init(url: "https://cam.sosgolpe.com.br"))
        let (sut, presenter, service, _) = makeSUT(serviceResult: .success(response))

        sut.load()

        #expect(service.requestedEndpoints.count == 1)
        #expect(presenter.loadingStates == [true])
        #expect(presenter.loadedURLs.first?.absoluteString == response.data.url)
    }

    @Test
    func load_failure_notifiesPresenter() {
        let (sut, presenter, service, _) = makeSUT(serviceResult: .failure(.unauthorized))

        sut.load()

        #expect(service.requestedEndpoints.count == 1)
        #expect(presenter.loadingStates == [true, false])
        #expect(presenter.receivedErrors.count == 1)
    }

    @Test
    func stopLoading_forwardsToPresenter() {
        let (sut, presenter, _, _) = makeSUT()

        sut.stopLoading()

        #expect(presenter.loadingStates == [false])
    }

    @Test
    func error_triggersUnauthorizedFlow() {
        let (sut, presenter, _, _) = makeSUT()

        sut.error()

        #expect(presenter.loadingStates == [false])
        #expect(presenter.receivedErrors.count == 1)
    }

    @Test
    func resolve_back_callsPresenter() {
        let (sut, presenter, _, _) = makeSUT()

        sut.resolve(command: .back, data: ["origin": "screen"])

        #expect(presenter.backOrigins == ["screen"])
    }

    @Test
    func resolve_permissions_requestsService() {
        let (sut, presenter, _, permission) = makeSUT()
        permission.nextRequestStatuses = [.authorized, .denied]

        sut.resolve(command: .askForMicrophone, data: nil)
        sut.resolve(command: .askForLibrary, data: nil)

        #expect(permission.requestedTypes == [.microphone, .library])
        #expect(presenter.sentCommands.count == 2)
        #expect(presenter.sentCommands.first?.0 == .microphonePermission)
        #expect(presenter.sentCommands.last?.1?["status"] == PermissionStatus.denied.rawValue)
    }

    @Test
    func resolve_openSettings_invokesPermissionService() {
        let (sut, _, _, permission) = makeSUT()

        sut.resolve(command: .openSettings, data: nil)

        #expect(permission.didOpenSettings)
    }
}


