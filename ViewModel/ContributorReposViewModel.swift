//
//  ContributorReposViewModel.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Combine
import SwiftUI

class ContributorReposViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    private var cancellables = Set<AnyCancellable>()
    private let gitHubAPIService = GitHubAPIService()
    
    func fetchRepositories(for contributor: Contributor) {
        gitHubAPIService.fetchRepositories(for: contributor.login)
            .catch { _ in Just([]) }
            .assign(to: \.repositories, on: self)
            .store(in: &cancellables)
    }
}
