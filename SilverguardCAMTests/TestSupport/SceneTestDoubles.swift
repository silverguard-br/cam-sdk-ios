import Foundation
import UIKit
@testable import SilverguardCAM

// MARK: - DictWebview

final class DictWebviewPresenterSpy: DictWebviewPresenterProtocol {
    var loadingStates: [Bool] = []
    var loadedURLs: [URL] = []
    var receivedErrors: [NetworkError] = []
    var backOrigins: [String?] = []
    var sentCommands: [(JSAnswer, [String: String]?)] = []
    var navigateToTransactionsListCallCount = 0

    func loading(_ loading: Bool) {
        loadingStates.append(loading)
    }

    func load(webview: URL) {
        loadedURLs.append(webview)
    }

    func error(_ error: NetworkError) {
        receivedErrors.append(error)
    }

    func back(from origin: String?) {
        backOrigins.append(origin)
    }

    func navigateToTransactionsList() {
        navigateToTransactionsListCallCount += 1
    }

    func sendCommand(_ command: JSAnswer, payload: [String: String]?) {
        sentCommands.append((command, payload))
    }
}

final class DictWebviewServiceSpy: DictWebviewServiceProtocol {
    var requestedEndpoints: [DictRepository] = []
    var resultToReturn: Result<DICTResponse, NetworkError>?

    func request(
        endpoint: DictRepository,
        completion: @escaping (Result<DICTResponse, NetworkError>) -> Void
    ) {
        requestedEndpoints.append(endpoint)
        if let resultToReturn {
            completion(resultToReturn)
        }
    }
}

final class PermissionServiceSpy: PermissionServicing {
    var requestedTypes: [PermissionType] = []
    var currentStatusResponses: [PermissionType: PermissionStatus] = [:]
    var didOpenSettings = false
    var nextRequestStatuses: [PermissionStatus] = []

    func requestPermission(
        for type: PermissionType,
        completion: @escaping (PermissionStatus) -> Void
    ) {
        requestedTypes.append(type)
        if !nextRequestStatuses.isEmpty {
            completion(nextRequestStatuses.removeFirst())
        }
    }

    func currentStatus(for type: PermissionType) -> PermissionStatus {
        currentStatusResponses[type] ?? .notDetermined
    }

    func openSettings() {
        didOpenSettings = true
    }
}

final class DictWebviewCoordinatorSpy: DictWebviewCoordinatorProtocol {
    var startedLoading: [LoadingDTO] = []
    var stoppedLoadingCount = 0
    var presentedFeedback: [FeedbackDTO] = []
    var backOrigins: [String?] = []
    var navigateToTransactionsListCallCount = 0

    func startLoading(_ dto: LoadingDTO) {
        startedLoading.append(dto)
    }

    func stopLoading(_ completion: (() -> Void)?) {
        stoppedLoadingCount += 1
        completion?()
    }

    func presentFeedback(_ dto: FeedbackDTO) {
        presentedFeedback.append(dto)
    }

    func back(from origin: String?) {
        backOrigins.append(origin)
    }

    func navigateToTransactionsList() {
        navigateToTransactionsListCallCount += 1
    }
}

final class DictWebviewViewControllerSpy: DictWebviewViewControllerProtocol {
    var sentCommands: [(JSAnswer, [String: String]?)] = []
    var loadedURLs: [URL] = []

    func load(webview: URL) {
        loadedURLs.append(webview)
    }

    func sendCommand(_ command: JSAnswer, payload: [String : String]?) {
        sentCommands.append((command, payload))
    }
}

final class NavigationHandlerSpy: SilverguardNavigationHandlerDelegate {
    var popCommands: [String?] = []
    var navigateToTransactionsListCallCount = 0

    func onPopViewController(with command: String?) {
        popCommands.append(command)
    }

    func navigateToTransactionsList() {
        navigateToTransactionsListCallCount += 1
    }
}

// MARK: - Feedback

final class FeedbackPresenterSpy: FeedbackPresenterProtocol {
    var configuredDTOs: [FeedbackDTO] = []
    var didTapCount = 0

    func configure(_ feedbackDTO: FeedbackDTO) {
        configuredDTOs.append(feedbackDTO)
    }

    func onClick() {
        didTapCount += 1
    }
}

final class FeedbackCoordinatorSpy: FeedbackCoordinatorProtocol {
    var onClickCount = 0

    func onClick() {
        onClickCount += 1
    }
}

final class FeedbackViewControllerSpy: FeedbackViewControllerProtocol {
    var configuredDTO: FeedbackDTO?

    func configure(_ dto: FeedbackDTO) {
        configuredDTO = dto
    }
}

// MARK: - Loading

final class LoadingPresenterSpy: LoadingPresenterProtocol {
    var configuredDTOs: [LoadingDTO] = []
    var finishHandlers: [() -> Void] = []

    func configure(_ loadingDTO: LoadingDTO) {
        configuredDTOs.append(loadingDTO)
    }

    func finish(_ completion: @escaping () -> Void) {
        finishHandlers.append(completion)
    }
}

final class LoadingCoordinatorSpy: LoadingCoordinatorProtocol {
    var finishHandlers: [() -> Void] = []

    func finish(_ completion: @escaping () -> Void) {
        finishHandlers.append(completion)
        completion()
    }
}

final class LoadingViewControllerSpy: LoadingViewControllerProtocol {
    var configuredDTOs: [LoadingDTO] = []

    func configure(_ dto: LoadingDTO) {
        configuredDTOs.append(dto)
    }
}


