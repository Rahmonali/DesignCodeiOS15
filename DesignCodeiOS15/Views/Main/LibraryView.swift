//
//  LibraryView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 05/11/23.
//

import SwiftUI

struct LibraryView: View {
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            
            ScrollView {
                
                CertificateView()
                    .frame(height: 220)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.purple, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(20)
                            .offset(y: -30)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(.linearGradient(colors: [.teal, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding(40)
                            .offset(y: -60)
                    )
                    .padding(20)
                
                Text("History".uppercased())
                    .titleStyle()
                
                coursesSection
                
                Text("Topics".uppercased())
                    .titleStyle()
                
                topicsSection
            }
            .safeAreaInset(edge: .top, content: {
                Color.clear.frame(height: 70)
            })
            .overlay(NavigationBar(title: "Library", hasScrolled: .constant(true)))
            .background(Image("Blob 1").offset(x: -100, y: -400))
        }
    }
}

extension LibraryView  {
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
    
    private var topicsSection: some View {
        VStack {
            ForEach(topics) { topic in
                ListRow(topic: topic)
            }
        }
        .padding(20)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
        .strokeStyle(cornerRadius: 30)
        .padding(.horizontal, 20)
    }
}

#Preview {
    LibraryView()
}
