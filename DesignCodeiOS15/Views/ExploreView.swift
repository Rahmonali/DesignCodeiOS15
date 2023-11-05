//
//  ExploreView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 05/11/23.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            coursesSection
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(NavigationBar(title: "Recent", hasScrolled: .constant(true)))
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
}

extension ExploreView  {
    private var coursesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack (spacing: 16){
                ForEach(courses) { course in
                    SmallCourseItem(course: course)
                }
            }
            .padding(.horizontal, 20)
            Spacer()
        }
    }
}

#Preview {
    ExploreView()
}
