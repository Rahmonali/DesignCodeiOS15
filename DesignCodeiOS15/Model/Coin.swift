//
//  Coin.swift
//  DesignCodeiOS15
//
//  Created by Rahmonali on 31/10/23.
//

import Foundation

struct Coin: Identifiable, Decodable {
    var id: Int
    var coin_name: String
    var acronym: String
    var logo: String
}

class CoinModel: ObservableObject {
    @Published var coins: [Coin] = []

    @MainActor
    func fetchCoins() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            coins = try JSONDecoder().decode([Coin].self, from: data)
        } catch {
            print("Error")
        }
    }
}
