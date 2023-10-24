//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack(alignment: .bottom)  {
            switch selectedTab {
                case .home:
                    HomeView()
                case .explore:
                    AccountView()
                case .notifications:
                    AccountView()
                case .library:
                    AccountView()
            }
            
            TabBar()
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

#Preview {
    ContentView()
}
