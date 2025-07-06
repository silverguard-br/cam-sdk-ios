import UIKit

final class SilverguardButton: UIButton, SilverguardButtonStylable, SilverguardButtonLoadable, SilverguardButtonConfigurable {
    // MARK: - Anatomy
    enum Anatomy {
        static let iconSize: CGFloat = 14
        static let iconPadding: CGFloat = 16
        static let textLeadingPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 8
        static let contentPadding: CGFloat = 12
    }
    
    // MARK: - Public Style Properties
    var enabledBackgroundColor: UIColor = Stylesheet.colors.buttonEnabled {
        didSet { updateButton() }
    }

    var disabledBackgroundColor: UIColor = Stylesheet.colors.buttonDisabled {
        didSet { updateButton() }
    }

    var titleColor: UIColor = Stylesheet.colors.buttonTitle {
        didSet { updateButton() }
    }

    var cornerRadius: CGFloat = Anatomy.cornerRadius {
        didSet { updateButton() }
    }

    var titleFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium) {
        didSet { updateButton() }
    }

    var icon: UIImage? {
        didSet {
            iconImageView.image = icon
            updateButton()
        }
    }

    private var iconPadding: CGFloat {
        Anatomy.iconSize +
        Anatomy.iconPadding +
        Anatomy.textLeadingPadding
    }

    // MARK: - Private Views
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .white
        return iv
    }()

    private let spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView(style: .medium)
        s.translatesAutoresizingMaskIntoConstraints = false
        s.hidesWhenStopped = true
        return s
    }()

    private var isLoading = false {
        didSet {
            iconImageView.isHidden = isLoading
            if isLoading {
                spinner.startAnimating()
                spinner.color = titleColor(for: .normal) ?? .white
                isEnabled = false
            } else {
                spinner.stopAnimating()
                isEnabled = true
            }
            updateBackground()
        }
    }

    // MARK: - Enable Override
    private lazy var _isEnabledState = true
    override var isEnabled: Bool {
        get { _isEnabledState }
        set {
            _isEnabledState = newValue
            super.isEnabled = newValue
            updateButton()
        }
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    // MARK: - Setup
    private func commonInit() {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius

        if #available(iOS 15.0, *) {
            setupButtonConfiguration()
        } else {
            setupButtonLegacy()
        }

        updateButton()
    }

    // MARK: - Loading
    func setLoading(_ loading: Bool) {
        isLoading = loading
    }
    
    func showLoading() {
        setLoading(true)
    }
    
    func hideLoading() {
        setLoading(false)
    }
}

// MARK: Common
extension SilverguardButton {
    func updateButton() {
        applyStyle()
        if #available(iOS 15.0, *) {
            configuration = updateConfigurationBackground(in: configuration)
        } else {
            updateBackground()
        }
        layoutIfNeeded()
    }

    func applyStyle() {
        setTitleColor(titleColor, for: .disabled)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.numberOfLines = 1
        titleLabel?.font = titleFont
        titleLabel?.lineBreakMode = .byTruncatingTail
    }
    
    private func buildViewHierarchy() {
        addSubview(iconImageView)
        addSubview(spinner)

        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: Anatomy.iconSize),
            iconImageView.heightAnchor.constraint(equalToConstant: Anatomy.iconSize),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Anatomy.iconPadding),

            spinner.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor)
        ])
    }
}

// MARK: < iOS 15.0
extension SilverguardButton {
    private func setupButtonLegacy() {
        applyStyle()
        contentHorizontalAlignment = .leading
        contentEdgeInsets = UIEdgeInsets(
            top: Anatomy.contentPadding,
            left: iconPadding,
            bottom: Anatomy.contentPadding,
            right: iconPadding
        )

        buildViewHierarchy()
        adjustsImageWhenHighlighted = true
    }
    
    private func updateBackground() {
        layer.cornerRadius = cornerRadius
        backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
    }
}

// MARK: > iOS 15.0
extension SilverguardButton {
    @available(iOS 15.0, *)
    private func setupButtonConfiguration() {
        applyStyle()
        addSubview(iconImageView)
        addSubview(spinner)
        setupInitialConfiguration()

        buildViewHierarchy()
        configurationUpdateHandler = { [weak self] _ in
            self?.updateButton()
        }
    }

    @available(iOS 15.0, *)
    private func setupInitialConfiguration() {
        var config = updateConfigurationBackground(in: .filled()) ?? .filled()
        config.cornerStyle = .fixed
        config.contentInsets = NSDirectionalEdgeInsets(
            top: Anatomy.contentPadding,
            leading: iconPadding,
            bottom: Anatomy.contentPadding,
            trailing: iconPadding
        )
        config.image = nil
        config.titleLineBreakMode = .byTruncatingTail
        config.titleAlignment = .center
        configuration = config
    }

    @available(iOS 15.0, *)
    private func updateConfigurationBackground(in buttonConfiguration: UIButton.Configuration?) -> UIButton.Configuration? {
        var config = buttonConfiguration
        if var background = config?.background {
            background.cornerRadius = cornerRadius
            background.backgroundColor = isEnabled ? enabledBackgroundColor : disabledBackgroundColor
            config?.background = background
        }
        let font = titleFont
        config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = font
            return outgoing
        }
        config?.baseForegroundColor = currentTitleColor
        config?.cornerStyle = .fixed
        config?.image = nil
        return config
    }

}
