protocol PermissionProviding {
    func requestPermission(completion: @escaping (PermissionStatus) -> Void)
    func currentStatus() -> PermissionStatus
}
