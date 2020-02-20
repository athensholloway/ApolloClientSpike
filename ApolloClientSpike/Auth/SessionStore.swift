//
//  UserManager.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation
import Combine

class SessionStore : ObservableObject {
    var signIn: SignIn
    
    @Published var user: User?
    
    init(signIn: SignIn) {
        self.signIn = signIn
    }
    
    func isUserAuthenticated() -> Bool {
        return user != nil
    }
    
    func signIn(email: String, password: String, onComplete: @escaping (Bool) -> ()) {
        signIn.signIn(email: email, password: password) { result in
            if (!result.success) {
                onComplete(false)
                return
            }
            
            guard let user = result.user else {
                onComplete(false)
                return
            }
            
            guard let token = result.token else {
                onComplete(false)
                return
            }
            
            
            self.user = User(
                id: user.id,
                email: user.email,
                firstName: user.firstName
            )
            
            print("token = \(token)")
            
            TokenRepository.shared.token = token
            
            onComplete(result.success)
        }
    }
}

//https://www.apollographql.com/docs/ios/initialization/#basic-client-creation
//Auth in server: https://www.apollographql.com/docs/apollo-server/security/authentication/#putting-user-info-on-the-context
