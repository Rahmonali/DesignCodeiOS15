//
//  NotificationsView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 05/11/23.
//

import SwiftUI

struct NotificationsView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView {
                sectionsSection
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(NavigationBar(title: "Notifications", hasScrolled: .constant(true)))
            .background(Image("Blob 1").offset(x: -180, y: 300))
        }
    }
}

extension NotificationsView {
    private var sectionsSection: some View {
        VStack(alignment: .leading) {
            ForEach(Array(courseSections.enumerated()), id: \.offset) { index, section in
                if index != 0 {
                    Divider()
                }
                
                SectionRow()
            }
        }
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(20)
    }
}

#Preview {
    NotificationsView()
}
