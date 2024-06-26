//
//  NavigationBar.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 24/10/23.
//

import SwiftUI

struct NavigationBar: View {
    var title = ""
    @Binding var hasScrolled: Bool
    @State private var showSearch = false
    @State private var showAccount = false
    @AppStorage("showModal") var showModal = false
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        ZStack {
            Color.clear
                .background(.ultraThinMaterial)
                .blur(radius: 10)
                .opacity(hasScrolled ? 1 : 0)
            
            Text(title)
                .animatableFont(size: hasScrolled ? 22 : 34, weight: .bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .padding(.top, 20)
                .offset(y: hasScrolled ? -4 : 0)
            
            HStack(spacing: 16) {
                Button {
                    showSearch = true
                } label: {
                    Image(systemName: "magnifyingglass")
                        .font(.body.weight(.bold))
                        .frame(width: 36, height: 36)
                        .foregroundStyle(.secondary)
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
                        .strokeStyle(cornerRadius: 14)
                }
                .sheet(isPresented: $showSearch) {
                    SearchView()
                }
                
                Button {
                    if isLogged {
                        showAccount = true
                    } else {
                        withAnimation {
                            showModal = true
                        }
                    }
                } label: {
                    AvatarView()
                }
                .accessibilityElement()
                .accessibilityLabel("Account")
                .accessibilityAddTraits(.isButton)
                .sheet(isPresented: $showAccount) {
                    AccountView()
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 20)
            .padding(.top, 20)
            .offset(y: hasScrolled ? -4 : 0)
        }
        .frame(height: hasScrolled ? 44 : 70)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    NavigationBar(title: "Featured", hasScrolled: .constant(false))
}
