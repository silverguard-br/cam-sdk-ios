import Foundation

struct Helper {
    public static func print(_ message: Any) {
        #if DEBUG
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "dd/MM/YYYY - HH:mm:ss"
        let date = formatter.string(from: Date())
        Swift.print("👾 \(date) - \(message)")
        #endif
    }
}
