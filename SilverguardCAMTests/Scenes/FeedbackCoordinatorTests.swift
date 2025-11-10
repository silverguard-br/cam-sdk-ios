import UIKit
import Testing
@testable import SilverguardCAM

@Suite("FeedbackCoordinator")
struct FeedbackCoordinatorTests {
    @Test
    func onClick_dismissesControllerAndCallsCompletion() {
        let sut = FeedbackCoordinator()
        let controller = DismissableViewController()
        sut.controller = controller

        var completionController: UIViewController?
        sut.completion = { completionController = $0 }

        sut.onClick()

        #expect(controller.dismissCallCount == 1)
        #expect(completionController === controller)
    }
}

private final class DismissableViewController: UIViewController {
    private(set) var dismissCallCount = 0

    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCallCount += 1
        completion?()
    }
}


