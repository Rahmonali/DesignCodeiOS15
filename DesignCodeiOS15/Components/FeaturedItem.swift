//
//  FeaturedItem.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 24/10/23.
//

import SwiftUI

struct FeaturedItem: View {
    
    var course: Course = courses[0]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Spacer()
            Image(course.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 26, height: 26)
                .clipShape(.rect(cornerRadius: 10))
                .padding(9)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16, style: .continuous))
                .strokeStyle(cornerRadius: 16)
            Text(course.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.linearGradient(colors: [.primary, .primary.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing))
            Text(course.subtitle.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)
            Text(course.text)
                .font(.footnote)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.secondary)
        }
        .padding(20)
        .padding(.vertical, 20)
        .frame(height: 350)
        .background(.ultraThinMaterial)
        .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle()
        .padding(.horizontal, 20)
    }
}

#Preview {
    FeaturedItem()
}
