//
//  Repository.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import Foundation

struct Repository: Codable, Identifiable {
    var id: Int
    var name: String
    var owner: Owner
    var description: String?
    var html_url: String
    var contributors_url: String
    
}
