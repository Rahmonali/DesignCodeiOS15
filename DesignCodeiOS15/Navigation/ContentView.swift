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
            Group {
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
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            TabBar()
        }
    }
}

#Preview {
    ContentView()
}
