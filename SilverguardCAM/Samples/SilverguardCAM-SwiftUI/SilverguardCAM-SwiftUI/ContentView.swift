//
//  ContentView.swift
//  SilverguardCAM-SwiftUI
//
//  Created by Matheus Sanada on 11/11/25.
//

import SwiftUI
import SilverguardCAM

enum FlowDestination: Hashable {
    case full
    case minimal
}

struct ContentView: View {
    @State private var path: [FlowDestination] = []
    @State private var isDefaultStyle = true
    @State private var didConfigureFramework = false

    private var colors: ColorsProtocol {
        isDefaultStyle ? DefaultColors() : CustomColors()
    }

    private var fonts: FontsProtocol {
        isDefaultStyle ? DefaultFonts() : CustomFonts()
    }

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 12) {
                    Button("Iniciar contestação") {
                        path.append(.full)
                    }
                    .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))

                    Button("Iniciar contestação (campos obrigatórios)") {
                        path.append(.minimal)
                    }
                    .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))
                }
                .padding(20)
            }
            .background(Color(uiColor: colors.background).ignoresSafeArea())
            .navigationTitle("Silverguard - CAM")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Change Style", action: toggleStyle)
                        .tint(Color(uiColor: colors.primary))
                }
            }
            .onAppear {
                if !didConfigureFramework {
                    didConfigureFramework = true
                    applyConfigs()
                }
                applyCurrentStyle()
            }
            .navigationDestination(for: FlowDestination.self) { destination in
                SilverguardFlowView(flow: destination) { command in
                    DispatchQueue.main.async {
                        if !path.isEmpty {
                            path.removeLast()
                        }
                        print(command ?? "404")
                    }
                }
                .ignoresSafeArea()
            }
        }
    }

    private func toggleStyle() {
        isDefaultStyle.toggle()
        applyCurrentStyle()
    }
    
    private func applyConfigs() {
        SilverguardCAM
            .setEnvironment(.debug)
            .configure(with: "3|14sa2lC4r0jEKLqUpBWcGowIbkt30ziyNJqWvniQ49b50f69")
    }

    private func applyCurrentStyle() {
        let colors = self.colors
        let fonts = self.fonts
        SilverguardCAM
            .setStyle(colors: colors)
            .setFonts(fonts: fonts)
    }
}

struct SilverguardButtonStyle: ButtonStyle {
    let colors: ColorsProtocol
    let fonts: FontsProtocol

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font(fonts.button))
            .frame(maxWidth: .infinity, minHeight: 44)
            .foregroundColor(Color(uiColor: colors.buttonTitle))
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(uiColor: colors.primary))
                    .opacity(configuration.isPressed ? 0.8 : 1.0)
            )
    }
}

struct SilverguardFlowView: UIViewControllerRepresentable {
    let flow: FlowDestination
    let onFinish: (String?) -> Void

    func makeCoordinator() -> Coordinator {
        Coordinator(onFinish: onFinish)
    }

    func makeUIViewController(context: Context) -> UIViewController {
        switch flow {
        case .full:
            return SilverguardCAM.start(
                with: SampleDataFactory.makeFullModel(),
                navigationHandler: context.coordinator
            )
        case .minimal:
            return SilverguardCAM.start(
                with: SampleDataFactory.makeMinimalModel(),
                navigationHandler: context.coordinator
            )
        }
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    final class Coordinator: NSObject, SilverguardNavigationHandlerDelegate {
        private let onFinish: (String?) -> Void

        init(onFinish: @escaping (String?) -> Void) {
            self.onFinish = onFinish
        }

        func onPopViewController(with command: String?) {
            onFinish(command)
        }
    }
}

#Preview {
    ContentView()
}
