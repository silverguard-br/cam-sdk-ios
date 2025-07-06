import UIKit

public class ImageDownloader {
    
    public init () { }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(from url: URL,
                               onFinish: @escaping (UIImage?) -> ()) {
        Helper.print("Download Started")
        var image: UIImage? = nil
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            Helper.print(response?.suggestedFilename ?? url.lastPathComponent)
            Helper.print("Download Finished")
            image = UIImage(data: data)
            onFinish(image)
        }
    }
    
    public func downloadImage(from link: String,
                              onFinish: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: link) else { return }
        downloadImage(from: url, onFinish: onFinish)
    }
}
