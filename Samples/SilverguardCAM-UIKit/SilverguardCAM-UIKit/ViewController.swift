//
//  ViewController.swift
//  SilverguardCAM-UIKit
//
//  Created by Matheus Sanada on 11/11/25.
//

import UIKit
import SilverguardCAM

final class ViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [startFullButton, startMinimalButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()

    private lazy var startFullButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Iniciar contestação"
        configuration.cornerStyle = .medium
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(didTapStartFull), for: .touchUpInside)
        return button
    }()

    private lazy var startMinimalButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Iniciar contestação (campos obrigatórios)"
        configuration.cornerStyle = .medium
        let button = UIButton(configuration: configuration, primaryAction: nil)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.addTarget(self, action: #selector(didTapStartMinimal), for: .touchUpInside)
        return button
    }()

    private var isDefaultStyle = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        configureFramework()
        configureNav()
        configureActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    private func setupView() {
        view.backgroundColor = UIColor.systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    private func configureFramework() {
        SilverguardCAM
            .setEnvironment(.debug)
            .configure(with: "3|14sa2lC4r0jEKLqUpBWcGowIbkt30ziyNJqWvniQ49b50f69")
            
        applyCurrentStyle()
    }

    private func configureNav() {
        title = "Silverguard - CAM"
        let button = UIBarButtonItem(
            title: "Change Style",
            style: .plain,
            target: self,
            action: #selector(didTapRightButton)
        )
        navigationItem.rightBarButtonItem = button
        navigationItem.largeTitleDisplayMode = .never
        applyNavStyle()
    }

    private func configureActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    private func applyCurrentStyle() {
        let colors: ColorsProtocol = isDefaultStyle ? DefaultColors() : CustomColors()
        let fonts: FontsProtocol = isDefaultStyle ? DefaultFonts() : CustomFonts()
        SilverguardCAM
            .setStyle(colors: colors)
            .setFonts(fonts: fonts)
        view.backgroundColor = colors.background
        contentView.backgroundColor = colors.background
        startFullButton.configuration?.baseBackgroundColor = colors.primary
        startFullButton.configuration?.baseForegroundColor = colors.buttonTitle
        startMinimalButton.configuration?.baseBackgroundColor = colors.primary
        startMinimalButton.configuration?.baseForegroundColor = colors.buttonTitle
    }

    private func applyNavStyle() {
        guard let rightButton = navigationItem.rightBarButtonItem else { return }
        let colors: ColorsProtocol = isDefaultStyle ? DefaultColors() : CustomColors()
        rightButton.tintColor = colors.primary
    }

    @objc private func didTapStartFull() {
        let controller = SilverguardCAM.start(
            with: SampleDataFactory.makeFullModel(),
            navigationHandler: self
        )
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func didTapStartMinimal() {
        let controller = SilverguardCAM.start(
            with: SampleDataFactory.makeMinimalModel(),
            navigationHandler: self
        )
        navigationController?.pushViewController(controller, animated: true)
    }

    @objc private func didTapRightButton() {
        isDefaultStyle.toggle()
        applyCurrentStyle()
        applyNavStyle()
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: SilverguardNavigationHandlerDelegate {
    func onPopViewController(with command: String?) {
        print(command ?? "404")
    }
}

