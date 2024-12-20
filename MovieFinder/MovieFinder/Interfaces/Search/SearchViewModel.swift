//
//  SearchViewModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var imageToShow: String?
    @Published var text = ""
    @Published var genres: [Genre] = []
    @Published var suggestions: [MediaDetailResponseModel] = []
    @Published var animateTextField = false
    @Published private var bgImagesHome: [String] = []
    @Published private var index = 0
    @Published private var searchWorkItem: DispatchWorkItem?
        
    func fetchData() {
        fetchHomeImage()
        fetchGenres()
        fetchSuggestions()
    }
    
    func fetchHomeImage() {
        Task { @MainActor in
            do {
                bgImagesHome = try await TmdbManager.shared.getHomeImages()
                
                imageToShow = Const.Url.imageBaseUrl + bgImagesHome[index]
            } catch {
                print("Error")
            }
        }
    }
    
    func fetchGenres() {
        Task { @MainActor in
            do {
                let response = try await TmdbManager.shared.getGenres()
                genres = response
            } catch {
                print("Error")
            }
        }
    }
    
    func updateImage() {
        guard !bgImagesHome.isEmpty else { return }
        
        incrementIndex()
        imageToShow = Const.Url.imageBaseUrl + bgImagesHome[index]
    }
    
    func mustAnimateTextField(oldValue: String, newValue: String) -> Bool {
        (oldValue.isEmpty && !newValue.isEmpty) ||
            (!oldValue.isEmpty && newValue.isEmpty)
    }
        
    func fetchSuggestionsIfNeeded() {
        searchWorkItem?.cancel()
        
        let newWorkItem = DispatchWorkItem {
            self.fetchSuggestions()
        }
        searchWorkItem = newWorkItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: newWorkItem)
    }
    
    func getGenreById(id: Int) -> String {
        genres.first { $0.id == id }?.name ?? ""
    }
    
    func resetSuggestions() {
        suggestions = []
    }
    
    private func fetchSuggestions() {
        Task { @MainActor in
            do {
                let response = try await TmdbManager.shared.getSuggestions(text: text)
                let filteredResponse = response.filter { $0.mediaType == .movie || $0.mediaType == .tv }
                suggestions = Array(filteredResponse.prefix(10))
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
