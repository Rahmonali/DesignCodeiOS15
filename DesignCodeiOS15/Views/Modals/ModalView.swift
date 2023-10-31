//
//  ModalView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 31/10/23.
//

import SwiftUI

struct ModalView: View {
    @EnvironmentObject var model: Model
    @AppStorage("showModal") var showModal = true
    @State private var viewState: CGSize = .zero
    
    var body: some View {
        ZStack {
            Color.clear.background(.regularMaterial)
                .ignoresSafeArea()
            
            Group {
                switch model.selectedModal {
                    case .signUp: SignUpView()
                    case .signIn: SignInView()
                }
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .offset(x: viewState.width, y: viewState.height)
            .rotationEffect(.degrees(viewState.width / 40))
            .rotation3DEffect(
                .degrees(viewState.height / 20), axis: (x: 1.0, y: 0.0, z: 0.0)
            )
            .hueRotation(.degrees(viewState.width / 5))
            .gesture(drag)
            .shadow(color: Color("Shadow").opacity(0.2), radius: 30, x: 0, y: 30)
            .padding(20)
            .background(
                Image("Blob 1")
                    .offset(x: 200, y: -100)
            )
            
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
    }
}

extension ModalView {
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                viewState = value.translation
            }
            .onEnded { value in
                withAnimation(.openCard) {
                    viewState = .zero
                }
            }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
            .environmentObject(Model())
    }
}
