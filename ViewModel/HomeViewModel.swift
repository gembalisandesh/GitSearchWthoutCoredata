//
//  HomeViewModel.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Combine
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    @Published var searchText = ""
    @Published var page = 1
    
    private var cancellables = Set<AnyCancellable>()
    private let gitHubAPIService: GitHubAPIService
    
    init(authToken: String? = nil) {
        self.gitHubAPIService = GitHubAPIService(authToken: authToken)
        setupSearchSubscription()
    }
    
    func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { [weak self] query -> AnyPublisher<[Repository], Never> in
                guard let self = self else { return Just([]).eraseToAnyPublisher() }
                return self.gitHubAPIService.searchRepositories(query: query, page: self.page)
                    .catch { _ in Just([]) }
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.repositories, on: self)
            .store(in: &cancellables)
    }
    
    func loadMoreRepositories() {
        page += 1
        gitHubAPIService.searchRepositories(query: searchText, page: page)
            .catch { _ in Just([]) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] newRepos in
                self?.repositories.append(contentsOf: newRepos)
            })
            .store(in: &cancellables)
        
    }
}
