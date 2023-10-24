//
//  HomeView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 23/10/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var hasScrolled = false
    
    var body: some View {
        ScrollView {
            
            GeometryReader { proxy in
                Color.clear.preference(key: ScrollPreferenceKey.self, value: proxy.frame(in: .named("scroll")).minY)
            }
            .frame(height: 0)
            
            FeaturedItem()
            
            Color.clear.frame(height: 1000)
        }
        .coordinateSpace(name: "scroll")
        .onPreferenceChange(ScrollPreferenceKey.self, perform: { value in
            withAnimation(.easeOut) {
                if value < 0 {
                    hasScrolled = true
                } else {
                    hasScrolled = false
                }
            }
        })
        .safeAreaInset(edge: .top, content: {
            Color.clear.frame(height: 70)
        })
        .overlay(
            NavigationBar(title: "Featured", hasScrolled: $hasScrolled)
        )
    }
}

#Preview {
    HomeView()
}
