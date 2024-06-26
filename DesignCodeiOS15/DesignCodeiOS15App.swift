//
//  DesignCodeiOS15App.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 19/10/23.
//

import SwiftUI

@main
struct DesignCodeiOS15App: App {
    
    @StateObject var model = Model()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
