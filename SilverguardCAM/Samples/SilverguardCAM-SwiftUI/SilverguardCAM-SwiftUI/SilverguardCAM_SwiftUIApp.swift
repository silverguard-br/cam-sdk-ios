//
//  SilverguardCAM_SwiftUIApp.swift
//  SilverguardCAM-SwiftUI
//
//  Created by Matheus Sanada on 11/11/25.
//

import SwiftUI
import SilverguardCAM

@main
struct SilverguardCAM_SwiftUIApp: App {

    init() {
        SilverguardCAM
            .configure(with: "3|14sa2lC4r0jEKLqUpBWcGowIbkt30ziyNJqWvniQ49b50f69")
        SilverguardCAM
            .setStyle(colors: DefaultColors())
            .setFonts(fonts: DefaultFonts())
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
