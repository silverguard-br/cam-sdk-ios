//
//  Environment.swift
//  SilverguardCAM
//
//  Created by Matheus Sanada on 24/10/25.
//

public protocol Environmenting {
    static func setEnvironment(_ environment: BaseURL)
}

public final class Environment: Environmenting {
    static var base: BaseURL = .debug
    
    public static func setEnvironment(_ environment: BaseURL) {
        Environment.base = environment
    }
}
