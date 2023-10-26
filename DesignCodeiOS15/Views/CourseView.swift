//
//  CourseView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 26/10/23.
//

import SwiftUI

struct CourseView: View {
    
    var namespace: Namespace.ID
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            ScrollView {
                cover
            }
            .background(Color("Background"))
            .ignoresSafeArea()
            
            button
        }
    }
}

//#Preview {
//    @Namespace static var namespace
//    CourseView(namespace: namespace, show: .constant(true))
//}

extension CourseView {
    private var cover: some View {
        VStack {
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .foregroundStyle(.black)
        .background(
            Image("Illustration 9")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: "image", in: namespace)
        )
        .background(
            Image("Background 5")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: "background", in: namespace)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .matchedGeometryEffect(id: "mask", in: namespace)
        }
        .overlay {
            VStack(alignment: .leading, spacing: 12) {
                Text("SwiftUI")
                    .font(.largeTitle.weight(.bold))
                    .matchedGeometryEffect(id: "title", in: namespace)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("20 Sections - 3 hours".uppercased())
                    .font(.footnote.weight(.semibold))
                    .matchedGeometryEffect(id: "subtitle", in: namespace)
                
                Text("Build an iOS app for iOS 15 with custom layouts, animations and ..")
                    .font(.footnote)
                    .matchedGeometryEffect(id: "text", in: namespace)
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
                    .matchedGeometryEffect(id: "blur", in: namespace)
            }
            .offset(y: 250)
            .padding(20)
        }
    }
    
    private var button: some View {
        Button {
            withAnimation(.closeCard) {
                show.toggle()
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
}
