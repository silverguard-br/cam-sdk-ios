struct FeedbackDTO: Codable {
    let title: String
    let message: String
    let buttonTitle: String
    let image: Images
}

extension FeedbackDTO {
    static func common() -> FeedbackDTO {
        .init(
            title: Localizable.Error.title,
            message: Localizable.Error.description,
            buttonTitle: Localizable.Error.buttonTitle,
            image: Images.warning
        )
    }
}
