//
//  SearchResults.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Foundation


struct SearchResults: Codable {
    var items: [Repository]
}

struct Contributor: Codable, Identifiable {
    var id: Int
    var login: String
    var avatar_url: String
}
