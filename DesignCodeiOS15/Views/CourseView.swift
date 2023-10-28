//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 26/10/23.
//

import SwiftUI

struct CourseView: View {
    
    var namespace: Namespace.ID
    var course: Course = courses[0]
    @Binding var show: Bool
    @State private var appear = [false, false, false]
    @EnvironmentObject var model: Model
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
                    .opacity(appear[2] ? 1 : 0)
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            button
        }
        .onAppear {
            fadeIn()
        }
        .onChange(of: show) { newValue in
            fadeOut()
        }
    }
}

//#Preview {
//    @Namespace static var namespace
//    CourseView(namespace: namespace, show: .constant(true))
//}

extension CourseView {
    private var cover: some View {
        GeometryReader { proxy in
            let scrollY = proxy.frame(in: .global).minY
            VStack {
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: scrollY > 0 ? 500 + scrollY : 500)
            .foregroundStyle(.black)
            .background(
                Image(course.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "image\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? scrollY * -0.8 : 0)
            )
            .background(
                Image(course.background)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .matchedGeometryEffect(id: "background\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
                    .scaleEffect(scrollY > 0 ? scrollY / 1000 + 1 : 1)
                    .blur(radius: scrollY / 10)
            )
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
                    .matchedGeometryEffect(id: "mask\(course.id)", in: namespace)
                    .offset(y: scrollY > 0 ? -scrollY : 0)
            }
            .overlay {
                overlayContent
                    .offset(y: scrollY > 0 ? scrollY * -0.6 : 0)
            }
        }
        .frame(height: 500)
    }
    
    private var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("SwiftUI helps you build great-looking apps across all Apple platforms with the power of Swift — and surprisingly little code.")
                .font(.title3).fontWeight(.medium)
            Text("This course")
                .font(.title).bold()
            Text("Build sophisticated animations with expanded animation support. Use phases to create sequences of animations, or create multiple animation tracks using keyframes. SwiftUI automatically transfers the velocity of a user gesture to your animations so your app feels fluid and natural.")
            Text("Share more of your SwiftUI code with your watchOS apps. Scroll vertical TabViews using the crown, match colors with adaptive background containers, take advantage of edge-to-edge displays with new ToolbarItem placements, and leverage NavigationSplitView to build detailed list views.")
                .font(.title.bold())
            Text("When you recompile your SwiftUI apps for visionOS, you can add depth and 3D objects to windows or present volumes. Use RealityView to bring in RealityKit content alongside your views and controls. And you can use SwiftUI and RealityKit together to build Full Space immersive experiences.")
        }
        .padding(20)
    }
    
    private var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
                model.showDetail.toggle()
                
            }
        } label: {
            Image(systemName: "xmark")
                .font(.body.weight(.bold))
                .foregroundStyle(Color.secondary)
                .padding(8)
                .background(
                    .ultraThinMaterial, in: Circle()
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        .padding(20)
        .ignoresSafeArea()
    }
    
    private var overlayContent: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(course.title)
                .font(.largeTitle.weight(.bold))
                .matchedGeometryEffect(id: "title\(course.id)", in: namespace)
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(course.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
                .matchedGeometryEffect(id: "subtitle\(course.id)", in: namespace)
            
            Text(course.text)
                .font(.footnote)
                .matchedGeometryEffect(id: "text\(course.id)", in: namespace)
            Divider()
                .opacity(appear[0] ? 1 : 0)
            HStack {
                Image("Avatar Default")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                
                Text("Taught by Meng To")
                    .font(.footnote)
            }
            .opacity(appear[1] ? 1 : 0)
        }
        .padding(20)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .matchedGeometryEffect(id: "blur\(course.id)", in: namespace)
        }
        .offset(y: 250)
        .padding(20)
    }
}

extension CourseView {
    func fadeIn() {
        withAnimation(.easeOut.delay(0.3)) {
            appear[0] = true
        }
        withAnimation(.easeOut.delay(0.3)) {
            appear[1] = true
        }
        withAnimation(.easeOut.delay(0.3)) {
            appear[2] = true
        }
    }
    
    func fadeOut() {
        appear[0] = false
        appear[1] = false
        appear[2] = false
    }
}
