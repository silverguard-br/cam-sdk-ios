import UIKit

protocol LoadingController: UIViewController {
    func finish(_ completion: (() -> Void)?)
}

protocol LoadingViewControllerProtocol: AnyObject {
    func configure(_ dto: LoadingDTO)
}

final class LoadingViewController: ViewController<LoadingInteractorProtocol> {
    enum Anatomy {
        static let spacing: CGFloat = 48
        static let stackPadding: CGFloat = 20
    }
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Anatomy.spacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.color = Stylesheet.colors.primary
        activity.style = .large
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = Stylesheet.fonts.headline2
        label.textColor = Stylesheet.colors.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.didLoad()
    }
    
    override func buildViews() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(activity)
        stackView.addArrangedSubview(label)
    }
    
    override func configureViews() {
        view.backgroundColor = Stylesheet.colors.background
    }
    
    override func configureConstraints() {
        NSLayoutConstraint.activate(
            [
                stackView.leadingAnchor.constraint(
                    equalTo: view.leadingAnchor,
                    constant: Anatomy.stackPadding
                ),
                stackView.trailingAnchor.constraint(
                    equalTo: view.trailingAnchor,
                    constant: -Anatomy.stackPadding
                ),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }
}

extension LoadingViewController: LoadingViewControllerProtocol {
    func configure(_ dto: LoadingDTO) {
        label.text = dto.message
        activity.startAnimating()
    }
}

extension LoadingViewController: LoadingController {
    func finish(_ completion: (() -> Void)?) {
        interactor.finish(completion ?? {})
    }
}
