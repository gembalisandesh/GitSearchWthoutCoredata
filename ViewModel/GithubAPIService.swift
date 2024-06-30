//
//  GithubAPIService.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Foundation
import Combine

class GitHubAPIService {
    private let baseURL = "https://api.github.com"
    private var authToken: String?
    
    init(authToken: String? = nil) {
        self.authToken = authToken
    }
    
    func searchRepositories(query: String, page: Int) -> AnyPublisher<[Repository], Error> {
        let urlString = "\(baseURL)/search/repositories?q=\(query)&page=\(page)&per_page=10"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        if let authToken = authToken {
            request.setValue("token \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: SearchResults.self, decoder: JSONDecoder())
            .map { $0.items }
            .eraseToAnyPublisher()
    }
    
    func fetchContributors(url: String) -> AnyPublisher<[Contributor], Error> {
        guard let url = URL(string: url) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        if let authToken = authToken {
            request.setValue("token \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Contributor].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func fetchRepositories(for user: String) -> AnyPublisher<[Repository], Error> {
        let urlString = "\(baseURL)/users/\(user)/repos"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        if let authToken = authToken {
            request.setValue("token \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: [Repository].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
