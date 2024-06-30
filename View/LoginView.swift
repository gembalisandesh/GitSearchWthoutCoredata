//
//  LoginView.swift
//  GitSearch
//
//  Created by user263604 on 6/28/24.
//

import SwiftUI

struct LoginView: View {
    @State private var authToken = ""
    @State private var isLoggedIn = false
    // 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
    var body: some View {
        if isLoggedIn {
            HomeView(authToken: authToken)
        } else {
            VStack {
                TextField("Enter GitHub Personal Access Token", text: $authToken)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    isLoggedIn = true
                }) {
                    Text("Login")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    LoginView()
}
