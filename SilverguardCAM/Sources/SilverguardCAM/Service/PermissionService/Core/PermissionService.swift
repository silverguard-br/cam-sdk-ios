protocol PermissionServicing {
    func requestPermission(for type: PermissionType, completion: @escaping (PermissionStatus) -> Void)
    func currentStatus(for type: PermissionType) -> PermissionStatus
    func openSettings()
}
