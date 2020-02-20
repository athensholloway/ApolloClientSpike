//
//  LoginUser.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation

struct User {
    var id: String
    var email: String
    var firstName: String
    
    init(id: String, email: String, firstName: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
    }
}

struct SignInResult {
    var success: Bool
    var user: User?
    var token: String?
}

protocol SignIn {
    func signIn(email: String, password: String, onCompletion: @escaping (SignInResult) -> Void)
}

extension SignIn {
    func signIn(email: String, password: String, onCompletion: @escaping (SignInResult) -> Void) {
        Network.shared.apollo.perform(mutation: LoginUserMutation(username: email, password: password)) { result in
            guard let data = try? result.get().data else {
                onCompletion(SignInResult(success: false))
                print("login failed")
                return
            }
            
            guard let token = data.login.token else {
                onCompletion(SignInResult(success: false))
                print("token is nil")
                return
            }
            
            //how do you unwrap graphql data from apollo
            let user = User(id: data.login.user?.id ?? "", email: data.login.user?.email ?? "", firstName: "Athens")
            onCompletion(SignInResult(success: true, user: user, token: token))
        }
    }
}

class SignInService : SignIn {
}
