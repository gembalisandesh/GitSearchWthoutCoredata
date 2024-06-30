//
//  RepoDetailView.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import SwiftUI

struct RepoDetailView: View {
    @StateObject var viewModel: RepoDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: viewModel.repository.owner.avatar_url)) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.repository.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(viewModel.repository.description ?? "No description available.")
                    .font(.body)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Link(destination: URL(string: viewModel.repository.html_url)!) {
                    Text("Project Link")
                        .foregroundColor(.blue)
                        .underline()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Contributors")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(viewModel.contributors) { contributor in
                    NavigationLink(destination: ContributorReposView(contributor: contributor)) {
                        HStack {
                            AsyncImage(url: URL(string: contributor.avatar_url)) { image in
                                image.resizable()
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            
                            Text(contributor.login)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationTitle("Repository Details")
    }
}
