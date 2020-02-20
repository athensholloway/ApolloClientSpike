//
//  RegisterUser.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation

protocol RegisteredUser {
    var id: String { get }
    var email: String { get }
}

extension CustomStringConvertible where Self: CrosscheckRegisteredUser {
  var description: String {
    "id: \(id) \nemail: \(email)"
  }
}

class CrosscheckRegisteredUser : RegisteredUser {
    var id: String
    var email: String
    
    init(id: String, email: String) {
        self.id=id
        self.email = email
    }
}

protocol RegisterUser {
    func register(email: String, password: String, onCompletion: @escaping (RegisteredUser?) -> Void)
}

extension RegisterUser {
    func register(email: String, password: String, onCompletion: @escaping (RegisteredUser?) -> Void) {
        Network.shared.apollo.perform(mutation: RegisterUserMutation(username: email, password: password)) { result in
            guard let data = try? result.get().data else {
                onCompletion(nil)
                return
            }
            
            let user = CrosscheckRegisteredUser(id: data.register.id, email: data.register.email)
            onCompletion(user)
        }
    }
}

class RegisterUserService : RegisterUser {
    
}
