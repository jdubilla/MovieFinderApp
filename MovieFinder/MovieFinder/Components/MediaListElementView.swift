//
//  MediaListElementView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 04/11/2024.
//

import SwiftUI

struct MediaListElementView: View {
    
    let media: MediaDetailResponseModel
    
    var body: some View {
        HStack(spacing: 0) {
            MediaImageView(suggestion: media)
            
            VStack(alignment: .leading, spacing: 4) {
                MediaNameAndGenreView(suggestion: media)
                
                MediaVoteAverageAndYearView(suggestion: media)
                
                Spacer()
            }
            
            Spacer()
        }
        .frame(height: 125)
    }
}

extension MediaListElementView {
    // MARK: MediaImageView
    @ViewBuilder
    private func MediaImageView(suggestion: MediaDetailResponseModel) -> some View {
        AsyncImage(
            url: URL(string: Const.Url.imageBaseUrl + (suggestion.posterPath ?? "")),
            transaction: Transaction(animation: .default)
        ) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 125)
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    // MARK: MediaNameAndGenreView
    @ViewBuilder
    private func MediaNameAndGenreView(suggestion: MediaDetailResponseModel) -> some View {
        Text(suggestion.nameOrTitle)
            .font(.headline)
            .fontWeight(.bold)
            .padding(.leading)
            .multilineTextAlignment(.leading)
        
        HStack(spacing: 4) {
            ForEach((suggestion.genreIds?.prefix(2).map { TmdbManager.shared.getGenreNameById(idGenre: $0) }
                     ?? suggestion.genres?.prefix(2).map { $0.name }) ?? [], id: \.self) { genreName in
                Text(genreName)
                    .font(.subheadline)
                    .lineLimit(1)
                    .capsuleBackground()
            }
        }
        .padding(.leading)
    }
    
    // MARK: MediaVoteAverageAndYearView
    @ViewBuilder
    private func MediaVoteAverageAndYearView(suggestion: MediaDetailResponseModel) -> some View {
        HStack(spacing: 8) {
            if let voteAverage = suggestion.voteAverage {
                HStack(spacing: 8) {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(String(format: "%.2f", voteAverage))".excludeLocalization)
                        .font(.subheadline)
                }
                .capsuleBackground()
                .padding(.leading)
            }
            
            if let year = suggestion.date?.getYear() {
                HStack(spacing: 8) {
                    Image(systemName: "calendar")
                    
                    Text(year)
                        .font(.subheadline)
                }
                .capsuleBackground()
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    MediaListElementView(
        media: MediaDetailResponseModel(
            backdropPath: "/c1r23hXbH2AYFpFI8KDCq852WhG.jpg",
            firstAirDate: "2022-03-02",
            releaseDate: "2022-03-02",
            genres: [
                Genre(id: 10765, name: "Sci-Fi & Fantasy"),
                Genre(id: 10759, name: "Action & Adventure")
            ],
            genreIds: [],
            homepage: nil,
            id: 211684,
            numberOfEpisodes: nil,
            numberOfSeasons: nil,
            originalName: "The Batman",
            originalTitle: "The Batman",
            overview: "In his second year of fighting crime, Batman uncovers corruption in Gotham City " +
            "that connects to his own family while facing a serial killer known as the Riddler.",
            posterPath: "/c1r23hXbH2AYFpFI8KDCq852WhG.jpg",
            voteAverage: 6.0,
            voteCount: 0,
            mediaType: .tv
        )
    )
}
