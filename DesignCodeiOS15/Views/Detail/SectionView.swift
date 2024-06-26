//
//  SectionView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 01/11/23.
//

import SwiftUI

struct SectionView: View {
    var section: CourseSection = courseSections[0]
    @EnvironmentObject var model: Model
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
                    .overlay(PlayView().overlay(CircularView(value: section.progress, lineWidth: 5).padding(24)))
                
                content
                    .offset(y: 120)
                    .padding(.bottom, 200)
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            button
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView()
            .environmentObject(Model())
    }
}

extension SectionView {
    private var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
            Image(section.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(maxWidth: 500)
        )
        .background(
            Image(section.background)
                .resizable()
                .aspectRatio(contentMode: .fill)
        )
        .mask {
            RoundedRectangle(cornerRadius: 0, style: .continuous)
        }
        .overlay {
            overlayContent
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
            dismiss()
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
            Text(section.title)
                .font(.largeTitle.weight(.bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            Text(section.subtitle.uppercased())
                .font(.footnote.weight(.semibold))
            
            Text(section.text)
                .font(.footnote)
            Divider()
            
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
        }
        .padding(20)
        .background {
            Rectangle()
                .fill(.ultraThinMaterial)
                .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
        }
        .offset(y: 250)
        .padding(20)
    }
}
