import SwiftUI

struct ShaderMenu: ViewModifier {
    let selected: ShaderExample
    let onSelect: (ShaderExample) -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Menu {
                        ForEach(ShaderExample.allCases, id: \.self) { example in
                            Button {
                                onSelect(example)
                            } label: {
                                if selected == example {
                                    Label(example.rawValue, systemImage: "checkmark")
                                } else {
                                    Text(example.rawValue)
                                }
                            }
                        }
                    } label: {
                        Text(selected.rawValue)
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .glassEffect()
                    }
                }
            }
//            .toolbarColorScheme(.dark, for: .navigationBar)
    }
}
