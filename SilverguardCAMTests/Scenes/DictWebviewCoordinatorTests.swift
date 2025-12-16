import UIKit
import Testing
@testable import SilverguardCAM

@Suite("DictWebviewCoordinator")
struct DictWebviewCoordinatorTests {
    @Test
    func back_dismissesWhenPresented() async {
        let navigationHandler = NavigationHandlerSpy()
        let sut = DictWebviewCoordinator(navigationHandler: navigationHandler)
        let controller = PresentedController()
        controller.presentingController = UIViewController()
        sut.controller = controller

        await awaitResult { continuation in
            controller.onDismiss = {
                continuation(())
            }
            sut.back(from: "origin")
        }

        #expect(controller.dismissCallCount == 1)
        #expect(navigationHandler.popCommands == ["origin"])
    }

    @Test
    func back_popsNavigationController() async {
        await MainActor.run {
            let navigationHandler = NavigationHandlerSpy()
            let sut = DictWebviewCoordinator(navigationHandler: navigationHandler)
            let controller = UIViewController()
            let navigation = NavigationControllerSpy(rootViewController: controller)
            sut.controller = controller

            sut.back(from: "origin")

            #expect(navigation.popCallCount == 1)
            #expect(navigationHandler.popCommands == ["origin"])
        }
    }

    @Test
    func navigateToTransactionsList_dismissesWhenPresented() async {
        let navigationHandler = NavigationHandlerSpy()
        let sut = DictWebviewCoordinator(navigationHandler: navigationHandler)
        let controller = PresentedController()
        controller.presentingController = UIViewController()
        sut.controller = controller

        await awaitResult { continuation in
            controller.onDismiss = {
                continuation(())
            }
            sut.navigateToTransactionsList()
        }

        #expect(controller.dismissCallCount == 1)
        #expect(navigationHandler.navigateToTransactionsListCallCount == 1)
    }

    @Test
    func navigateToTransactionsList_popsNavigationController() async {
        await MainActor.run {
            let navigationHandler = NavigationHandlerSpy()
            let sut = DictWebviewCoordinator(navigationHandler: navigationHandler)
            let controller = UIViewController()
            let navigation = NavigationControllerSpy(rootViewController: controller)
            sut.controller = controller

            sut.navigateToTransactionsList()

            #expect(navigation.popCallCount == 1)
            #expect(navigationHandler.navigateToTransactionsListCallCount == 1)
        }
    }
}

private final class PresentedController: UIViewController {
    var dismissCallCount = 0
    var presentingController: UIViewController?
    var onDismiss: (() -> Void)?

    override var presentingViewController: UIViewController? {
        presentingController
    }

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
        completion?()
        onDismiss?()
    }
}

private final class NavigationControllerSpy: UINavigationController {
    private(set) var popCallCount = 0

    override func popViewController(animated: Bool) -> UIViewController? {
        popCallCount += 1
        return super.popViewController(animated: animated)
    }
}


