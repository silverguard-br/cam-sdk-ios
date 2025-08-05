import UIKit
import Foundation

protocol FeedbackController: UIViewController {}

protocol FeedbackViewControllerProtocol: AnyObject {
    func configure(_ dto: FeedbackDTO)
}

final class FeedbackViewController: ViewController<FeedbackInteractorProtocol>, FeedbackViewControllerProtocol {
    enum Anatomy {
        static let spacing: CGFloat = 24
        static let bodySpacing: CGFloat = 8
        static let stackPadding: CGFloat = 20
        static let accessoryImageViewRadius: CGFloat = 65
        static let accessoryImageViewSize: CGFloat = 130
        static let imageViewSize: CGFloat = 48
        static let buttonSize: CGFloat = 55
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Anatomy.spacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Anatomy.bodySpacing
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var accessoryImageView: UIView = {
        let view = UIView()
        view.backgroundColor = Stylesheet.colors.primary04
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Anatomy.accessoryImageViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Stylesheet.colors.primary
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Stylesheet.fonts.headline3
        label.textColor = Stylesheet.colors.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = Stylesheet.fonts.body
        label.textColor = Stylesheet.colors.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    private lazy var button: SilverguardButton = {
        let button = SilverguardButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.didLoad()
    }

    override func buildViews() {
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        view.addSubview(button)

        stackView.addArrangedSubview(imageContainer)
        stackView.addArrangedSubview(bodyStackView)

        imageContainer.addSubview(accessoryImageView)
        accessoryImageView.addSubview(imageView)

        bodyStackView.addArrangedSubview(titleLabel)
        bodyStackView.addArrangedSubview(descriptionLabel)
    }
    
    override func configureViews() {
        view.backgroundColor = Stylesheet.colors.background
    }

    override func configureConstraints() {
        NSLayoutConstraint.activate([
            accessoryImageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            accessoryImageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            accessoryImageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor),
            accessoryImageView.widthAnchor.constraint(equalToConstant: Anatomy.accessoryImageViewSize),
            accessoryImageView.heightAnchor.constraint(equalToConstant: Anatomy.accessoryImageViewSize),

            imageView.centerXAnchor.constraint(equalTo: accessoryImageView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: accessoryImageView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: Anatomy.imageViewSize),
            imageView.heightAnchor.constraint(equalToConstant: Anatomy.imageViewSize)
        ])

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -Anatomy.stackPadding),

            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Anatomy.stackPadding),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Anatomy.stackPadding),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

            {
                let top = stackView.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: Anatomy.stackPadding)
                top.priority = .defaultLow
                return top
            }(),
            {
                let bottom = stackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -Anatomy.stackPadding)
                bottom.priority = .defaultLow
                return bottom
            }(),

            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Anatomy.stackPadding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Anatomy.stackPadding),

            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Anatomy.stackPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Anatomy.stackPadding),

            button.heightAnchor.constraint(equalToConstant: Anatomy.buttonSize),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Anatomy.stackPadding),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Anatomy.stackPadding),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Anatomy.stackPadding)
        ])
    }

    override func configureBindings() {
        button.addTarget(self, action: #selector(handleFinish), for: .touchUpInside)
    }

    @objc
    fileprivate func handleFinish() {
        interactor.onClick()
    }

    func configure(_ dto: FeedbackDTO) {
        titleLabel.text = dto.title
        descriptionLabel.text = dto.message
        imageView.image = BundleAssets.image(dto.image)
        button.setTitle(dto.buttonTitle, for: .normal)
    }
}

extension FeedbackViewController: FeedbackController {}
