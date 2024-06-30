//
//  ContributorReposView.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import SwiftUI

struct ContributorReposView: View {
    var contributor: Contributor
    @StateObject private var viewModel = ContributorReposViewModel()
    
    var body: some View {
        VStack {
            Text("Repositories by \(contributor.login)")
                .font(.headline)
            
            List(viewModel.repositories) { repo in
                RepoRowView(repository: repo)
            }
        }
        .onAppear {
            viewModel.fetchRepositories(for: contributor)
        }
    }
}



