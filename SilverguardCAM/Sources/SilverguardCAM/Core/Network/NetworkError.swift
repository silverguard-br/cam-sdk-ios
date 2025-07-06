public enum NetworkError: Error {
    case unauthorized
    case invalidData
    case error(Error)
    case badRequest([String: Any]?)
    case decoding
}
