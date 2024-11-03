//
//  FavoritesMediaManager.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 03/11/2024.
//

import SwiftUI

class FavoritesMediaManager: ObservableObject {
    @Published var items: [FavoriteMedia] = []
    static let shared = FavoritesMediaManager()
    @AppStorage("favorites") private var favoritesData: Data = Data()
    
    init() {
        loadItems()
    }
    
    func loadItems() {
        if let data = UserDefaults.standard.data(forKey: "items") {
            if let decoded = try? JSONDecoder().decode([FavoriteMedia].self, from: data) {
                items = decoded
                return
            }
        }
        
        items = []
    }
    
    func saveItems() {
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "items")
        }
    }
    
    func getItems() -> [FavoriteMedia] {
        return items
    }
}
