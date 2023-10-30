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
                    AccountView()
                case .notifications:
                    AccountView()
                case .library:
                    AccountView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                ZStack {
                    Color.clear.background(.regularMaterial)
                        .ignoresSafeArea()
                    
                    SignUpView()
                    
                    Button(action: {
                        withAnimation {
                            showModal = false
                        }
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.body.weight(.bold))
                            .foregroundStyle(Color.secondary)
                            .padding(8)
                            .background(
                                .ultraThinMaterial, in: Circle()
                            )
                    })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                    .padding(20)
                }
                .zIndex(1)
            }
        }
        .safeAreaInset(edge: .bottom) {
            Color.clear.frame(height: 44)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Model())
}
