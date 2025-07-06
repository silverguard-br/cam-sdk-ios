import UIKit

public final class ButtonDemoViewController: UIViewController {
    private let button01 = SilverguardButton()
    private let button02 = SilverguardButton()
    private let button03 = SilverguardButton()
    private let button04 = SilverguardButton()
    private let button05 = SilverguardButton()

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupButtons()
    }

    private func setupButtons() {
        let stack = UIStackView(arrangedSubviews: [
            button01,
            button02,
            button03,
            button04,
            button05
        ])
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),

            button01.heightAnchor.constraint(equalToConstant: 40),
            button01.widthAnchor.constraint(equalToConstant: 240),
            button02.heightAnchor.constraint(equalToConstant: 40),
            button02.widthAnchor.constraint(equalToConstant: 240),
            button03.heightAnchor.constraint(equalToConstant: 40),
            button03.widthAnchor.constraint(equalToConstant: 240),
            button04.heightAnchor.constraint(equalToConstant: 40),
            button04.widthAnchor.constraint(equalToConstant: 240),
            button05.heightAnchor.constraint(equalToConstant: 40),
            button05.widthAnchor.constraint(equalToConstant: 240),
        ])

        setupButton01()
        setupButton02()
        setupButton03()
        setupButton04()
        setupButton05()
    }

    private func setupButton01() {
        button01.setTitle("Habilitado", for: .normal)
        button01.icon = UIImage(systemName: "checkmark.circle")
        button01.isEnabled = true
        button01.addTarget(self, action: #selector(handleButton01), for: .touchUpInside)
    }
    
    @objc private func handleButton01() {
        print("button01")
    }

    private func setupButton02() {
        button02.setTitle("Desabilitado", for: .normal)
        button02.icon = UIImage(systemName: "checkmark.circle")
        button02.isEnabled = false
    }

    private func setupButton03() {
        button03.setTitle("Habilitado", for: .normal)
        button03.isEnabled = true
        button03.addTarget(self, action: #selector(handleButton03), for: .touchUpInside)
    }
    
    @objc private func handleButton03() {
        print("button03")
    }

    private func setupButton04() {
        button04.setTitle("Habilitado", for: .normal)
        button04.icon = UIImage(systemName: "checkmark.circle")
        button04.isEnabled = true
        button04.addTarget(self, action: #selector(handleButton04), for: .touchUpInside)
    }
    
    @objc private func handleButton04() {
        button04.setLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.button04.setLoading(false)
            self.button04.isEnabled = true
        }
    }

    private func setupButton05() {
        button05.setTitle("Habilitado", for: .normal)
        button05.isEnabled = true
        
        button05.icon = UIImage(systemName: "checkmark.circle")
        button05.cornerRadius = 20
        button05.enabledBackgroundColor = .red
        button05.disabledBackgroundColor = .blue
        button05.titleFont = .boldSystemFont(ofSize: 20)
        button05.addTarget(self, action: #selector(handleButton05), for: .touchUpInside)
    }
    
    @objc private func handleButton05() {
        button05.setLoading(true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.button05.setLoading(false)
            self.button05.isEnabled = true
        }
    }

}

