import Foundation
import Testing
import UIKit
@testable import SilverguardCAM

@Suite("Extensions")
struct ExtensionsTests {
    @Test
    func data_map_decodesModel() {
        struct Model: Decodable, Equatable { let value: Int }
        let data = #"{"value":42}"#.data(using: .utf8)!

        let decoded: Model? = data.map(to: Model.self)

        #expect(decoded == .init(value: 42))
    }

    @Test
    func data_map_returnsNilForInvalidJson() {
        let data = "invalid".data(using: .utf8)!

        let decoded: DecodableModel? = data.map(to: DecodableModel.self)

        #expect(decoded == nil)
    }

    @Test
    func data_dictionary_returnsDictionary() {
        let original: [String: Any] = ["foo": "bar", "value": 1]
        let data = try! JSONSerialization.data(withJSONObject: original)

        let dictionary = data.dictionary

        #expect(dictionary?["foo"] as? String == "bar")
        #expect(dictionary?["value"] as? Int == 1)
    }

    @Test
    func data_prettyJson_returnsFormattedString() {
        let data = #"{"foo":"bar"}"#.data(using: .utf8)!

        let pretty = data.prettyJson

        #expect(pretty?.contains("\n") == true)
        #expect(pretty?.contains("\"foo\"") == true)
    }

    @Test
    func dictionary_data_serializesDictionary() {
        let dictionary = ["foo": "bar", "value": 1] as [String : Any]

        let data = dictionary.data

        #expect(data != nil)
        if let data,
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            #expect(json["foo"] as? String == "bar")
            #expect(json["value"] as? Int == 1)
        }
    }

    @Test
    func uiColor_hex_initializesSixDigitColor() {
        let color = UIColor(hex: "#112233")

        #expect(color != nil)
    }

    @Test
    func uiColor_hex_initializesEightDigitColor() {
        let color = UIColor(hex: "11223344")

        #expect(color != nil)
    }

    @Test
    func uiColor_hex_returnsNilForInvalidString() {
        let color = UIColor(hex: "ZXY")

        #expect(color == nil)
    }
}

private struct DecodableModel: Decodable {}


