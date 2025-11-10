import Foundation

func awaitResult<T>(_ body: (@escaping (T) -> Void) -> Void) async -> T {
    await withCheckedContinuation { continuation in
        body { value in
            continuation.resume(returning: value)
        }
    }
}


