//
//  RepoDetailViewModel.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Combine
import SwiftUI

class RepoDetailViewModel: ObservableObject {
    @Published var repository: Repository
    @Published var contributors = [Contributor]()
    
    private var cancellables = Set<AnyCancellable>()
    private let gitHubAPIService = GitHubAPIService()
    
    init(repository: Repository) {
        self.repository = repository
        fetchContributors()
    }
    
    func fetchContributors() {
        gitHubAPIService.fetchContributors(url: repository.contributors_url)
            .catch { _ in Just([]) }
            .assign(to: \.contributors, on: self)
            .store(in: &cancellables)
    }
}
