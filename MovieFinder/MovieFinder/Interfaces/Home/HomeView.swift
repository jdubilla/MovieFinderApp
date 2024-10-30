//
//  HomeView.swift
//  MovieFinder
//
//  Created by Jean-baptiste DUBILLARD on 26/10/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm = HomeViewModel()
    private let timer = Timer.publish(
        every: 3.5,
        on: .main,
        in: .common
    ).autoconnect()
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack(spacing: 0) {
            if !vm.animateTextField {
                Spacer()
            }
            
            MTextField(
                placeholder: "Recherchez un film ou une série",
                text: $vm.text
            )
            .padding(.top, !vm.animateTextField ? 0 : 40)
            
            ScrollView {
                ForEach(vm.suggestions, id: \.id) { _ in
                    HStack(spacing: 0) {
                        Text("Ok")
                        
                        Spacer()
                    }
                }
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
                Text("Ok")
            }
            .frame(maxWidth: .infinity, maxHeight: screenHeight / 2.5)
            .background(.ultraThickMaterial)
//            .background(.orange.opacity(0))
//            .blur(radius: 20)
            
            Spacer()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background {
            BackgroundImageView()
        }
        .ignoresSafeArea(.all)
        .onAppear {
            vm.fetchHomeImage()
            vm.getSuggestions()
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
            
            if !newValue.isEmpty {
                vm.getSuggestions()
            }
        }
    }
}

#Preview {
    HomeView()
}

extension HomeView {
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
}
