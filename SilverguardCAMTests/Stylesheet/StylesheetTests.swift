import UIKit
import Testing
@testable import SilverguardCAM

@Suite("Stylesheet")
struct StylesheetTests {
    @Test
    func setStyle_overridesColors() {
        let originalColors = Stylesheet.colors
        defer { Stylesheet.setStyle(color: originalColors) }

        let colors = ColorsStub()
        Stylesheet.setStyle(color: colors)

        #expect(Stylesheet.colors.primary == colors.primary)
        #expect(Stylesheet.colors.background == colors.background)
    }

    @Test
    func setFonts_overridesFonts() {
        let originalFonts = Stylesheet.fonts
        defer { Stylesheet.setFonts(fonts: originalFonts) }

        let fonts = FontsStub()
        Stylesheet.setFonts(fonts: fonts)

        #expect(Stylesheet.fonts.body == fonts.body)
        #expect(Stylesheet.fonts.headline3 == fonts.headline3)
    }

    @Test
    func environment_setEnvironment_updatesBaseUrl() {
        let original = Environment.base
        defer { Environment.setEnvironment(original) }

        Environment.setEnvironment(.production)

        #expect(Environment.base == .production)
    }
}

private final class ColorsStub: ColorsProtocol {
    let background: UIColor = .gray
    let primary: UIColor = .red
    let primary04: UIColor = .blue
    var buttonTitle: UIColor = .white
    let label: UIColor = .black
    let surface: UIColor = .green
    let buttonEnabled: UIColor = .magenta
    let buttonDisabled: UIColor = .lightGray
}

private final class FontsStub: FontsProtocol {
    let button: UIFont = .boldSystemFont(ofSize: 16)
    let body: UIFont = .systemFont(ofSize: 12)
    let headline2: UIFont = .systemFont(ofSize: 20)
    let headline3: UIFont = .systemFont(ofSize: 18)
}


