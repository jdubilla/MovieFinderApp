//
//  MediaDetailViewModel.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 31/10/2024.
//

import Foundation
import SwiftUI

final class MediaDetailViewModel: ObservableObject {
    
    @Published var media: MediaDetailResponseModel?
    @Published var credits: MediaCreditsResponseModel?
    @Published var recommendations: HomeImageResponseModel?
    @Published var isLoading = false
    @Published var imageOpacity: CGFloat = 0
        
    func fetchDatas(media: MediaDetailResponseModel) {
        fetchMediaById(media: media)
        fetchCredits(media: media)
        fetchRecommendations(media: media)
    }
    
    func fetchMediaById(media: MediaDetailResponseModel) {
        Task { @MainActor in
            do {
                self.media = try await TmdbManager.shared.getMediaById(
                    mediaType: media.typeMedia,
                    id: media.id
                )
            } catch {
                print(error)
            }
        }
    }
    
    func fetchCredits(media: MediaDetailResponseModel) {
        Task { @MainActor in
            do {
                credits = try await TmdbManager.shared.getMediaCreditsById(media: media)
            } catch {
                print(error)
            }
        }
    }
    
    func fetchRecommendations(media: MediaDetailResponseModel) {
        Task { @MainActor in
            do {
                recommendations = try await TmdbManager.shared.getMediaRecomemndationById(media: media)
            } catch {
                print(error)
            }
        }
    }
    
    func getImageStarRating(idx: Int, voteAverage: Double) -> String {
        if voteAverage / 2 >= Double(idx) {
            return "star.fill"
        } else if voteAverage / 2 > Double(idx - 1) {
            return "star.leadinghalf.fill"
        } else {
            return "star"
        }
    }
    
    func getForegroundColorStarRating(idx: Int, voteAverage: Double) -> Color {
        if voteAverage / 2 >= Double(idx) ||
            voteAverage / 2 > Double(idx - 1) {
            return .yellow
        }
        return .gray
    }

}
