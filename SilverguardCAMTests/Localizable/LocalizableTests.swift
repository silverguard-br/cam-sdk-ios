import Testing
@testable import SilverguardCAM

@Suite("Localizable")
struct LocalizableTests {
    @Test
    func loading_message_matchesExpected() {
        #expect(Localizable.Loading.message == "Analisando os dados")
    }

    @Test
    func error_copy_matchesExpected() {
        #expect(Localizable.Error.title == "Infelizmente não podemos seguir com sua contestação via MED")
        #expect(Localizable.Error.description == "Fale conosco através dos nossos canais de atendimento.")
        #expect(Localizable.Error.buttonTitle == "Finalizar")
    }
}


