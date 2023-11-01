//
//  CircularView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 01/11/23.
//

import SwiftUI

struct CircularView: View {
    var value: CGFloat = 0.2
    @State var appear = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: appear ? value : 0)
            .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round))
            .fill(.angularGradient(colors: [.purple, .pink, .purple], center: .center, startAngle: .degrees(0), endAngle: .degrees(360)))
            .rotationEffect(.degrees(270))
            .onAppear {
                withAnimation(.spring().delay(0.4)) {
                    appear = true
                }
            }
            .onDisappear {
                appear = false
            }
    }
}

#Preview {
    CircularView()
}
