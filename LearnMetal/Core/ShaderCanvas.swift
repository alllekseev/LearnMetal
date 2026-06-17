import SwiftUI

struct ShaderCanvas: View {
    let animated: Bool
    let shader: @Sendable (CGSize, TimeInterval) -> Shader

    private let startDate = Date()

    /// Полный контроль — передаёшь замыкание с size и time
    init(
        animated: Bool = false,
        shader: @Sendable @escaping (CGSize, TimeInterval) -> Shader
    ) {
        self.animated = animated
        self.shader = shader
    }

    /// Упрощённый вызов — передаёшь только имя функции из ShaderLibrary.
    /// size подставится автоматически первым аргументом.
    init(_ shaderFunction: ShaderFunction, animated: Bool = false, _ arguments: Shader.Argument...) {
        self.animated = animated
        self.shader = { size, time in
            var args: [Shader.Argument] = [.float2(size)]
            if animated { args.append(.float(time)) }
            args.append(contentsOf: arguments)
            return Shader(function: shaderFunction, arguments: args)
        }
    }

    var body: some View {
        if animated {
            TimelineView(.animation) { context in
                let time = context.date.timeIntervalSince(startDate)
                canvas(time: time)
            }
        } else {
            canvas(time: 0)
        }
    }

    private func canvas(time: TimeInterval) -> some View {
        Color.white
            .visualEffect { content, proxy in
                content.colorEffect(shader(proxy.size, time))
            }
    }
}
