//
//  MediaDetailView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 31/10/2024.
//

import SwiftUI

struct MediaDetailView: View {
    
    let media: Result
    @StateObject private var vm = MediaDetailViewModel()
    let screenWidth = UIScreen.main.bounds.size.width
    
    @State private var showingSafariView = false
    @State var url: URL?
    @State private var isPresentWebView = false
    
    var body: some View {
        VStack(spacing: 0) {
            if let detailMedia = vm.media {
                MediaView(detailMedia: detailMedia)
            } else {
                LoadingView()
            }
        }
        .ignoresSafeArea()
        .background(.backgroundGray)
        .onAppear {
            vm.fetchDatas(media: media)
        }
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $showingSafariView) {
            if let url = url {
                SafariView(url: url)
            }
        }
    }
}

extension MediaDetailView {
    // MARK: LoadingView
    @ViewBuilder
    private func LoadingView() -> some View {
        VStack {
            ProgressView()
            
            Text("Loading...")
        }
    }
    
    @ViewBuilder
    private func MediaView(detailMedia: MediaDetailResponseModel) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                GeometryReader { geo in
                    let scrollOffset = geo.frame(in: .global).minY
                    let darkenAmount = min(0.6, max(0, (300 - scrollOffset) / 300))
                    Color.clear
                        .onChange(of: darkenAmount) { newValue in
                            vm.imageOpacity = newValue
                        }
                }
                
                TitleView(detailMedia: detailMedia)
                
                MediaInfoSummaryView(detailMedia: detailMedia)
                
                GenresView(detailMedia: detailMedia)
                
                DescriptionView(detailMedia: detailMedia)
                
                CreditsView(detailMedia: detailMedia)
                
                RecommendationsView()
            }
            .padding(.top, 215)
            .padding(.bottom, 32)
        }
        .background {
            VStack {
                HeaderImageView()
                
                Spacer()
            }
        }
    }
    
    // MARK: HeaderImageView
    @ViewBuilder
    private func HeaderImageView() -> some View {
        VStack {
            AsyncImage(
                url: URL(string: vm.baseUrlBackdropImage + (vm.media?.backdropPath ?? "")),
                transaction: Transaction(animation: .default)
            ) { phase in
                switch phase {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: screenWidth, maxHeight: 300)
                        .overlay(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: [
                                        Color.backgroundGray.opacity(1),
                                        Color.backgroundGray.opacity(vm.imageOpacity),
                                        Color.backgroundGray.opacity(0.1)
                                    ]
                                ),
                                startPoint: .bottom,
                                endPoint: .top
                            )
                            .frame(height: 300),
                            alignment: .bottom
                        )
                case .failure:
                    EmptyView()
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
    
    // MARK: TitleView
    @ViewBuilder
    private func TitleView(detailMedia: MediaDetailResponseModel) -> some View {
        HStack(alignment: .top) {
            Text(detailMedia.nameOrTitle)
                .font(.title)
                .fontWeight(.bold)
            
            Spacer()
            
            VStack(spacing: 4) {
                HStack(spacing: 4) {
                    ForEach(1...5, id: \.self) { idx in
                        Image(systemName: vm.getImageStarRating(idx: idx, voteAverage: detailMedia.voteAverage))
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundStyle(
                                vm.getForegroundColorStarRating(
                                    idx: idx,
                                    voteAverage: detailMedia.voteAverage
                                )
                            )
                    }
                }
                
                Text("\(detailMedia.voteCount) votants")
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            .padding(.top, 8)
        }
        .padding(.horizontal)
    }
    
    // MARK: MediaInfoSummaryView
    @ViewBuilder
    private func MediaInfoSummaryView(detailMedia: MediaDetailResponseModel) -> some View {
        HStack(spacing: 8) {
            if let year = detailMedia.date?.getYear() {
                Text("\(year)")
                    .foregroundStyle(.gray)
            }
            
            if let nbSeasons = detailMedia.numberOfSeasons {
                Text("•")
                    .foregroundStyle(.gray)
                
                Text("\(nbSeasons) saisons")
                    .foregroundStyle(.gray)
            }
            
            if let nbEpisodes = detailMedia.numberOfEpisodes {
                Text("•")
                    .foregroundStyle(.gray)
                
                Text("\(nbEpisodes) épisodes")
                    .foregroundStyle(.gray)
            }
        }
        .padding(.top, 8)
        .padding(.horizontal)
    }
    
    // MARK: GenresView
    @ViewBuilder
    private func GenresView(detailMedia: MediaDetailResponseModel) -> some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(detailMedia.genres, id: \.id) { genre in
                    Text(genre.name)
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .overlay(
                            Capsule()
                                .strokeBorder(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                .borderGreen,
                                                .borderPurple
                                            ]
                                        ),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 2
                                )
                        )
                }
            }
            .padding(.top, 8)
            .padding(.horizontal)
        }
    }
    
    // MARK: DescriptionView
    @ViewBuilder
    private func DescriptionView(detailMedia: MediaDetailResponseModel) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(detailMedia.overview)
                .font(.body)
                .padding(.top)
            
            Button {
                url = URL(string: detailMedia.homepage)
                showingSafariView = true
            } label: {
                Text("Voir plus")
                    .foregroundStyle(.borderGreen)
                    .fontWeight(.bold)
                    .underline()
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: CreditsView
    @ViewBuilder
    private func CreditsView(detailMedia: MediaDetailResponseModel) -> some View {
        if let credits = vm.credits {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(credits.cast, id: \.id) { cast in
                        ZStack(alignment: .leading) {
                            CreditNameAndDepartmentView(cast: cast)
                            
                            CreditImageView(cast: cast)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.top, 24)
        }
    }
    
    // MARK: CreditNameAndDepartmentView
    @ViewBuilder
    private func CreditNameAndDepartmentView(cast: Cast) -> some View {
        VStack(alignment: .leading) {
            Text(cast.name)
            
            Text(cast.knownForDepartment.rawValue)
        }
        .padding(8)
        .padding(.leading, 32)
        .background(.backgroundBlack)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(
                    LinearGradient(
                        gradient: Gradient(
                            colors: [
                                Color.black.opacity(0.4),
                                Color.borderGray.opacity(0.1),
                                Color.borderGray.opacity(0.2)
                            ]
                        ),
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing
                    ),
                    lineWidth: 1
                )
        )
        .padding(.leading, 24)
    }
    
    // MARK: CreditImageView
    @ViewBuilder
    private func CreditImageView(cast: Cast) -> some View {
        if let stringUrlImage = cast.profilePath {
            AsyncImage(
                url: URL(string: vm.baseUrlBackdropImage + stringUrlImage),
                transaction: Transaction(animation: .default)
            ) { phase in
                switch phase {
                case .empty:
                    EmptyView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .strokeBorder(
                                    LinearGradient(
                                        gradient: Gradient(
                                            colors: [
                                                .borderGreen,
                                                .borderPurple
                                            ]
                                        ),
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ),
                                    lineWidth: 3
                                )
                        )
                case .failure:
                    CreditDefaultImageView()
                @unknown default:
                    EmptyView()
                }
            }
        } else {
            CreditDefaultImageView()
        }
    }
    
    // MARK: CreditDefaultImageView
    @ViewBuilder
    private func CreditDefaultImageView() -> some View {
        Image(.defaultUser)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(
                                colors: [
                                    .borderGreen,
                                    .borderPurple
                                ]
                            ),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        lineWidth: 3
                    )
            )
    }
    
    // MARK: RecommendationsView
    @ViewBuilder
    private func RecommendationsView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Recommandations")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            if let recommendations = vm.recommendations?.results {
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(recommendations, id: \.id) { recommendation in
                            NavigationLink(destination: MediaDetailView(media: recommendation)) {
                                VStack(spacing: 8) {
                                    AsyncImage(
                                        url: URL(string: vm.baseUrlBackdropImage + (recommendation.posterPath ?? "")),
                                        transaction: Transaction(animation: .default)
                                    ) { phase in
                                        switch phase {
                                        case .empty:
                                            EmptyView()
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .clipShape(.rect(cornerRadius: 16))
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 125, height: 200)
                                        case .failure:
                                            EmptyView()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    
                                    Text(recommendation.nameOrTitle)
                                        .foregroundStyle(.white)
                                }
                                .frame(width: 125)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
            }
        }
        .padding(.top, 24)
    }
}

#Preview {
    MediaDetailView(
        media: Result(
            backdropPath: "/mDt3Gkep3L0L5aL5Ck5hj8e3Rf.jpg",
//            id: 132719,
//            id: 71446,
            
            id: 689249,
            posterPath: "The Batman",
            name: "The Batman",
            title: "The Batman",
            originalTitle: "The Batman",
            originalName: "The Batman",
            mediaType: .movie,
            genreIds: [99],
            releaseDate: "2022-03-02",
            voteAverage: 6.0,
            firstAirDate: "2022-03-02"
        )
    )
}
