import UIKit

open class ViewController<Interactor>: UIViewController, ViewControllerConfiguration {
    public var interactor: Interactor
    
    public init(interactor: Interactor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Should start from `init(interactor: Interactor)`")
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        build()
    }
    
    private func build() {
        buildViews()
        configureViews()
        configureConstraints()
        configureBindings()
        configureAccessibility()
    }
    
    open func buildViews() { }
    
    open func configureViews() { }
    
    open func configureConstraints() { }
    
    open func configureBindings() { }
    
    open func configureAccessibility() { }
}
