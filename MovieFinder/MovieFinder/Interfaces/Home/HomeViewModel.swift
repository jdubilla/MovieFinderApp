//
//  HomeViewModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var imageToShow: String?
    @Published var text = "Les simpson"
    @Published var suggestions: [Result] = []
    @Published var animateTextField = true
    @Published private var bgImagesHome: [String] = []
    @Published private var index = 11
    
    let baseUrlBackdropImage = "https://image.tmdb.org/t/p/original/"
    
    func fetchHomeImage() {
        Task { @MainActor in
            do {
                bgImagesHome = try await TmdbManager.shared.getHomeImages()
                
                imageToShow = baseUrlBackdropImage + bgImagesHome[index]
            } catch {
                print("Error")
            }
        }
    }
    
    func updateImage() {
        guard !bgImagesHome.isEmpty else { return }
        
//        incrementIndex()
        imageToShow = baseUrlBackdropImage + bgImagesHome[index]
    }
    
    func mustAnimateTextField(oldValue: String, newValue: String) -> Bool {
        (oldValue.isEmpty && !newValue.isEmpty) ||
            (!oldValue.isEmpty && newValue.isEmpty)
    }
    
    func getSuggestions() {
        Task { @MainActor in
            do {
                let response = try await TmdbManager.shared.getSuggestions(text: text)
                suggestions = Array(response.prefix(10))
            } catch {
                print("Error")
            }
        }
    }

    private func incrementIndex() {
        guard index + 1 < bgImagesHome.count else {
            index = 0
            return
        }
        
        index += 1
    }
}
