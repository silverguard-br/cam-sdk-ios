struct DICTResponse: Decodable {
    let data: DICTWebViewResponse
}

struct DICTWebViewResponse: Decodable {
    let url: String
}
