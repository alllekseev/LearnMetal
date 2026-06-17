import SwiftUI

// Чтобы добавить новый шейдер:
// 1. Создай .metal файл в Shaders/
// 2. Добавь case в enum ShaderExample
// 3. Добавь ShaderCanvas в switch

enum ShaderExample: String, CaseIterable {
    case flag = "Флаг"
    case chessBoard = "Шахматы"
    case colorfullChessBoard = "Цветные шахматы"
    case inversion = "Инверсия"
    case circularGradient = "Круговой градиент"
    case vignette = "Виньетка"
    case channelMix = "Микс Каналов"
    case lines = "Линии"
    case shaderCircle = "Круг"

    @ViewBuilder
    var canvas: some View {
        switch self {
        case .flag:
            ShaderCanvas(ShaderLibrary.Flag)
        case .chessBoard:
            ShaderCanvas(ShaderLibrary.ChessBoard)
                .frame(width: 300, height: 300)
        case .colorfullChessBoard:
            ShaderCanvas(ShaderLibrary.ColorfullChessBoard)
                .frame(width: 300, height: 300)
        case .inversion:
            ShaderCanvas(ShaderLibrary.Inversion)
        case .circularGradient:
            ShaderCanvas(ShaderLibrary.CircularGradient)
        case .vignette:
            ShaderCanvas(ShaderLibrary.Vignette)
        case .channelMix:
            ShaderCanvas(ShaderLibrary.ChannelMix)
        case .lines:
            ShaderCanvas(ShaderLibrary.Lines)
        case .shaderCircle:
            ShaderCanvas(ShaderLibrary.ShaderCircle, .float(200))
        }
    }
}

enum AppTheme: String, CaseIterable {
    case dark = "Indigo"
    case mesh = "MeshGradient"
    case minimal = "Минимализм"
}

struct ContentView: View {
    @State private var selected: ShaderExample = .shaderCircle
    @State private var theme: AppTheme = .mesh

    var body: some View {
        NavigationStack {
            ZStack {
                background
                shaderCard
            }
            .modifier(ShaderMenu(selected: selected) { example in
                selected = example
            })
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        ForEach(AppTheme.allCases, id: \.self) { t in
                            Button {
                                withAnimation { theme = t }
                            } label: {
                                if theme == t {
                                    Label(t.rawValue, systemImage: "checkmark")
                                } else {
                                    Text(t.rawValue)
                                }
                            }
                        }
                    } label: {
                        Image(systemName: "paintpalette")
                    }
                }
            }
        }
    }

    @ViewBuilder
    private var background: some View {
        switch theme {
        case .dark:
            LinearGradient(
                colors: [.indigo, .black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        case .mesh:
            MeshGradient(
                width: 3, height: 3,
                points: [
                    [0.0, 0.0], [0.5, 0.0], [1.0, 0.0],
                    [0.0, 0.5], [0.5, 0.5], [1.0, 0.5],
                    [0.0, 1.0], [0.5, 1.0], [1.0, 1.0]
                ],
                colors: [
                    .indigo,  .purple, .blue,
                    .purple,  .mint,   .indigo,
                    .blue,    .indigo, .purple
                ]
            )
            .ignoresSafeArea()
        case .minimal:
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
        }
    }

    @ViewBuilder
    private var shaderCard: some View {
        let cornerRadius: CGFloat = theme == .minimal ? 16 : 20

        selected.canvas
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(.gray.opacity(0.3), lineWidth: 1)
            )
            .padding()
            .shadow(
                color: theme == .dark
                    ? .indigo.opacity(0.4)
                    : theme == .mesh
                        ? .black.opacity(0.3)
                        : .black.opacity(0.08),
                radius: theme == .minimal ? 8 : 20,
                y: theme == .minimal ? 4 : 10
            )
    }
}

#Preview {
    ContentView()
}
