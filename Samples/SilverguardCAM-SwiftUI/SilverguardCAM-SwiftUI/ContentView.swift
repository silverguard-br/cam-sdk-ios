//
//  ContentView.swift
//  SilverguardCAM-SwiftUI
//
//  Created by Matheus Sanada on 11/11/25.
//

import SwiftUI
import SilverguardCAM

enum FlowDestination: Hashable {
    case contestationFull
    case contestationMinimal
    case listFull
    case listMinimal
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
                VStack(alignment: .leading, spacing: 24) {
                    SectionView(title: "Iniciar Contestação", colors: colors) {
                        Button("Modelo completo") {
                            path.append(.contestationFull)
                        }
                        .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))

                        Button("Modelo (campos obrigatórios)") {
                            path.append(.contestationMinimal)
                        }
                        .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))
                    }

                    SectionView(title: "Listar Contestações", colors: colors) {
                        Button("Lista completa") {
                            path.append(.listFull)
                        }
                        .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))

                        Button("Lista (campos obrigatórios)") {
                            path.append(.listMinimal)
                        }
                        .buttonStyle(SilverguardButtonStyle(colors: colors, fonts: fonts))
                    }
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

struct SectionView<Content: View>: View {
    let title: String
    let colors: ColorsProtocol
    @ViewBuilder let content: () -> Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(uiColor: colors.label))

            VStack(spacing: 12) {
                content()
            }
        }
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
        case .contestationFull:
            return SilverguardCAM.start(
                with: SampleDataFactory.makeFullModel(),
                navigationHandler: context.coordinator
            )
        case .contestationMinimal:
            return SilverguardCAM.start(
                with: SampleDataFactory.makeMinimalModel(),
                navigationHandler: context.coordinator
            )
        case .listFull:
            return SilverguardCAM.start(
                for: SampleDataFactory.makeFullListModel(),
                navigationHandler: context.coordinator
            )
        case .listMinimal:
            return SilverguardCAM.start(
                for: SampleDataFactory.makeMinimalListModel(),
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
