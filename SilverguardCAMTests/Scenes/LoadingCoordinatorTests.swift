import UIKit
import Testing
@testable import SilverguardCAM

@Suite("LoadingCoordinator")
struct LoadingCoordinatorTests {
    @MainActor
    @Test
    func finish_removesControllerAndCallsCompletion() async {
        let sut = LoadingCoordinator()
        let parent = UIViewController()
        let controller = UIViewController()
        parent.addChild(controller)
        parent.view.addSubview(controller.view)
        controller.didMove(toParent: parent)
        sut.controller = controller

        await awaitResult { continuation in
            sut.finish {
                continuation(())
            }
        }

        #expect(controller.view.superview == nil)
        #expect(controller.parent == nil)
        #expect(controller.view.alpha == 0)
    }
}


