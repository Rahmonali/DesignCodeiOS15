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
    @State var address: Address = Address(id: 1, country: "Tajikistan")
    @Environment(\.dismiss) var dismiss
    @AppStorage("isLogged") var isLogged = false
    @AppStorage("isLiteMode") var isLiteMode = true
    @StateObject var coinModel = CoinModel()
    
    func fetchAddress() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/address/random_address")!
            let (data, _) = try await URLSession.shared.data(from: url)
            address = try JSONDecoder().decode(Address.self, from: data)
            
        } catch {
            address = Address(id: 1, country: "Error fetching")
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                profile
                
                menu
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label(
                            title: { Text("Lite Mode") },
                            icon: { Image(systemName: isLiteMode ? "tortoise" : "hare") }
                        )
                    }
                }
                .accentColor(.primary)
                
                links
                
                coins
                
                Button(action: {
                    isLogged = false
                    dismiss()
                }, label: {
                    Text("Sign Out")
                })
                .tint(.red)
            }
            .task {
                await fetchAddress()
                await coinModel.fetchCoins()
            }
            .refreshable {
                await fetchAddress()
                await coinModel.fetchCoins()
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
                Text(address.country)
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
    
    private var coins: some View {
        Section(header: Text("Coins")) {
            ForEach(coinModel.coins) { coin in
                HStack {
                    
                    AsyncImage(url: URL(string: coin.logo)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 32, height: 32)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym)
                            .font(.caption)
                            .foregroundStyle(Color.secondary)
                    }
                }
            }
        }
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
