//
//  HomeView.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    
    init(authToken: String? = nil) {
        let authToken = "<Your AuthToken>"
        _viewModel = StateObject(wrappedValue: HomeViewModel(authToken: authToken))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List(viewModel.repositories) { repo in
                    NavigationLink(destination: RepoDetailView(viewModel: RepoDetailViewModel(repository: repo))) {
                        RepoRowView(repository: repo)
                    }
                }
                Button(action: {
                    viewModel.loadMoreRepositories()
                }) {
                    Text("Load More")
                }
            }
            .navigationTitle("Repositories")
        }
    }
}

struct RepoRowView: View {
    var repository: Repository
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: repository.owner.avatar_url)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(repository.name)
                    .font(.headline)
                Text(repository.owner.login)
                    .font(.subheadline)
            }
        }
    }
}

#Preview {
    HomeView()
}
