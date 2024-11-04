//
//  SearchView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var vm = SearchViewModel()
    private let timer = Timer.publish(
        every: 3.5,
        on: .main,
        in: .common
    ).autoconnect()
    let screenHeight = UIScreen.main.bounds.size.height
        
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !vm.animateTextField {
                    Spacer()
                }
                
                MTextField(
                    placeholder: "Recherchez un film ou une série",
                    text: $vm.text
                )
                .padding(.top, !vm.animateTextField ? 0 : 40)
                
                SuggestionsView()
                
                Spacer()
            }
            .padding()
            .frame(maxHeight: .infinity)
            .background {
                BackgroundImageView()
            }
            .ignoresSafeArea(.all)
            .onAppear {
                vm.fetchData()
            }
            .onReceive(timer) { _ in
                vm.updateImage()
            }
            .onChange(of: vm.text) { [text = vm.text] newValue in
                if vm.mustAnimateTextField(
                    oldValue: text,
                    newValue: newValue
                ) {
                    withAnimation {
                        vm.animateTextField.toggle()
                    }
                }
                
                if newValue.isEmpty {
                    vm.resetSuggestions()
                } else {
                    vm.fetchSuggestionsIfNeeded()
                }
            }
        }
    }
}

#Preview {
    SearchView()
}

extension SearchView {
    // MARK: BackgroundImageView
    @ViewBuilder
    private func BackgroundImageView() -> some View {
        AsyncImage(
            url: URL(string: vm.imageToShow ?? ""),
            transaction: Transaction(animation: .default)
        ) { phase in
            switch phase {
            case .empty:
                EmptyView()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: .infinity)
                    .clipped()
                    .overlay {
                        Color.black.opacity(0.5)
                    }
            case .failure:
                EmptyView()
            @unknown default:
                EmptyView()
            }
        }
    }
    
    // MARK: SuggestionsView
    @ViewBuilder
    private func SuggestionsView() -> some View {
        if !vm.suggestions.isEmpty {
            ScrollView {
                ForEach(vm.suggestions, id: \.id) { suggestion in
                    NavigationLink(destination: MediaDetailView(media: suggestion)) {
                        MediaListElementView(media: suggestion)
                    }
                }
                .padding(24)
            }
            .frame(maxWidth: .infinity, maxHeight: screenHeight / 2.5)
            .background(
                .ultraThinMaterial,
                in: RoundedRectangle(cornerRadius: 32, style: .continuous)
            )
            .padding(.top)
            .foregroundStyle(.white)
        }
    }
}
