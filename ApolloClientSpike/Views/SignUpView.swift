//
//  SignUpView.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import SwiftUI

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    
    let registerUserService = RegisterUserService()
    
    var body: some View {
        VStack {
            Text("Sign Up")
            EmailTextField(email: $email)
            PasswordTextField(password: $password)
            Button(action: {
                
                /**
                                        
                 do if let try
                 
                 */
                
                
                self.registerUserService.register(email: self.email, password: self.password) { user in
                    print (user?.id ?? "")
                    print (user?.email ?? "")
                }
            }) {
                Text("Sign Up!")
            }
        }
    .padding(40)
    }
}
struct EmailTextField: View {
    @Binding var email: String
    
    var body: some View {
        TextField("Email", text: $email)
    }
}

struct PasswordTextField: View {
    @Binding var password: String
    
    var body: some View {
        SecureField("Password", text: $password)
    }
}

#if DEBUG
struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
#endif
