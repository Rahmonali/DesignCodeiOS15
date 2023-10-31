//
//  AvatarView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 31/10/23.
//

import SwiftUI

struct AvatarView: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://picsum.photos/200"), transaction: Transaction(animation: .easeOut) ) { phase in
            switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .transition(.scale(scale: 0.5, anchor: .center))
                case .failure(_):
                    Color.gray
                @unknown default:
                    EmptyView()
            }
        }
        .frame(width: 26, height: 26)
        .cornerRadius(10)
        .padding(8)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .strokeStyle(cornerRadius: 18)
    }
}

#Preview {
    AvatarView()
}
