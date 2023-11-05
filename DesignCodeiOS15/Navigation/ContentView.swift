//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("selectedTab") private var selectedTab: Tab = .home
    @AppStorage("showModal") var showModal = false
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack(alignment: .bottom)  {
            switch selectedTab {
                case .home:
                    HomeView()
                case .explore:
                    ExploreView()
                case .notifications:
                    AccountView()
                case .library:
                    AccountView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                ModalView()
                    .zIndex(1)
                    .accessibilityAddTraits(.isModal)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
        .dynamicTypeSize(.large ... .xxLarge)
    }
}

#Preview {
    ContentView()
        .environmentObject(Model())
}
