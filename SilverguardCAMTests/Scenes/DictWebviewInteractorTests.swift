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
        permission.currentStatusResponses[.camera] = .notDetermined
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
        permission.nextRequestStatuses = [.authorized, .denied, .authorized]

        sut.resolve(command: .askForMicrophone, data: nil)
        sut.resolve(command: .askForLibrary, data: nil)
        sut.resolve(command: .askForCamera, data: nil)

        #expect(permission.requestedTypes == [.microphone, .library, .camera])
        #expect(presenter.sentCommands.count == 3)
        #expect(presenter.sentCommands.first?.0 == .microphonePermission)
        #expect(presenter.sentCommands[1].0 == .libraryPermission)
        #expect(presenter.sentCommands.last?.0 == .cameraPermission)
        #expect(presenter.sentCommands[1].1?["status"] == PermissionStatus.denied.rawValue)
    }

    @Test
    func resolve_openSettings_invokesPermissionService() {
        let (sut, _, _, permission) = makeSUT()

        sut.resolve(command: .openSettings, data: nil)

        #expect(permission.didOpenSettings)
    }

    @Test
    func resolve_askForCamera_requestsCameraPermission() {
        let (sut, presenter, _, permission) = makeSUT()
        permission.nextRequestStatuses = [.authorized]

        sut.resolve(command: .askForCamera, data: nil)

        #expect(permission.requestedTypes == [.camera])
        #expect(presenter.sentCommands.count == 1)
        #expect(presenter.sentCommands.first?.0 == .cameraPermission)
        #expect(presenter.sentCommands.first?.1?["status"] == PermissionStatus.authorized.rawValue)
    }

    @Test
    func load_successWithInvalidURL_notifiesPresenterWithError() {
        let response = DICTResponse(data: .init(url: "invalid url"))
        let (sut, presenter, service, _) = makeSUT(serviceResult: .success(response))

        sut.load()

        #expect(service.requestedEndpoints.count == 1)
        #expect(presenter.loadingStates == [true])
    }

    @Test
    func resolve_back_withNilOrigin_callsPresenterWithNil() {
        let (sut, presenter, _, _) = makeSUT()

        sut.resolve(command: .back, data: nil)

        #expect(presenter.backOrigins.count == 1)
    }

    @Test
    func resolve_permissions_sendsCorrectStatusInPayload() {
        let (sut, presenter, _, permission) = makeSUT()
        permission.nextRequestStatuses = [.authorized, .denied, .notDetermined]

        sut.resolve(command: .askForMicrophone, data: nil)
        sut.resolve(command: .askForLibrary, data: nil)
        sut.resolve(command: .askForCamera, data: nil)

        #expect(presenter.sentCommands.count == 3)
        #expect(presenter.sentCommands[0].1?["status"] == PermissionStatus.authorized.rawValue)
        #expect(presenter.sentCommands[1].1?["status"] == PermissionStatus.denied.rawValue)
        #expect(presenter.sentCommands[2].1?["status"] == PermissionStatus.notDetermined.rawValue)
    }

    @Test
    func resolve_navigateToTransactionsList_callsPresenter() {
        let (sut, presenter, _, _) = makeSUT()

        sut.resolve(command: .navigateToTransactionsList, data: nil)

        #expect(presenter.navigateToTransactionsListCallCount == 1)
    }
}


