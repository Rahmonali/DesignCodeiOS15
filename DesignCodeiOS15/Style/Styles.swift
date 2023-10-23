//
//  Styles.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 20/10/23.
//

import SwiftUI

struct StrokeStyle: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    var cornerRadius: CGFloat
    func body(content: Content) -> some View {
        content
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(
                        .linearGradient(
                            colors: [
                                .white.opacity(colorScheme == .dark ? 0.6 : 0.3),
                                .black.opacity(colorScheme == .dark ? 0.3 : 0.1)
                            ], startPoint: .top, endPoint: .bottom
                        )
                    )
                    .blendMode(.overlay)
            }
    }
}

extension View {
    func strokeStyle(cornerRadius: CGFloat = 30) -> some View {
        modifier(StrokeStyle(cornerRadius: cornerRadius))
    }
}