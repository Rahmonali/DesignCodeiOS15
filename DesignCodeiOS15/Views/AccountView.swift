//
//  AccountView.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 20/10/23.
//

import SwiftUI

struct AccountView: View {
    
    @State private var isDeleted = false
    @State private var isPinned = false
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = false
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                links
                
                Button(action: {
                    isLogged = false
                    dismiss()
                }, label: {
                    Text("Sign Out")
                })
                .tint(.red)
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Acccount")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: { dismiss() }, label: {
                        Text("Done").bold()
                    })
                }
            }
        }
    }
}

#Preview {
    AccountView()
}

extension AccountView {
    private var profile: some View {
        VStack (spacing: 8){
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(
                    HexagonView()
                        .offset(x: -50, y: -100)
                )
                .background(
                    BlobView()
                        .offset(x: 200, y: 0)
                        .scaleEffect(0.6)
                )
            Text("Rahmonali Fatkhuddinov")
                .font(.title.weight(.semibold))
                .multilineTextAlignment(.center)
            
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text("Tajikistan")
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    private var menu: some View {
        Section {
            NavigationLink {
                HomeView()
            } label: {
                Label("Account", systemImage: "gear")
            }
            
            NavigationLink {
                Text("Billing")
            } label: {
                Label("Billing", systemImage: "creditcard")
            }
            
            NavigationLink {
                HomeView()
            } label: {
                Label("Help", systemImage: "questionmark")
            }
        }
        .accentColor(.primary)
        .listRowSeparatorTint(.blue)
        .listRowSeparator(.hidden)
    }
    
    private var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://www.apple.com")!, label: {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundStyle(.secondary)
                    }
                })
                .swipeActions(edge: .leading, allowsFullSwipe: false) {
                    Button(action: { isDeleted = true }, label: {
                        Label("Delete", systemImage: "trash")
                    })
                    .tint(.red)
                    pinButton
                }
            }
            
            Link(destination: URL(string: "https://www.youtube.com")!, label: {
                HStack {
                    Label("Youtube", systemImage: "tv")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundStyle(.secondary)
                }
            })
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                pinButton
            }
            
        }
        .accentColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var pinButton: some View {
        Button { isPinned.toggle() } label: {
            if isPinned {
                Label("Unpin", systemImage: "pin.slash")
            } else {
                Label("Pin", systemImage: "pin")
            }
        }
        .tint(isPinned ? .gray : .yellow)
    }
}
