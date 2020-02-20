//
//  SignInView.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import SwiftUI

struct SignInView: View {
    @State var email = ""
    @State var password = ""
    @State var authenticating = false
    @State var authenticationDidFail = false
    @State var authenticationDidSucceed = false
    @State var editingMode: Bool = false //Shift text field up when editing to make room for the keyboard: https://www.blckbirds.com/post/login-page-in-swiftui-2
    
    @State var error: Bool = false;
    @EnvironmentObject var sessionStore: SessionStore
    
    var body: some View {
        
        
        VStack {
            Text("Sign In")
            
            TextField("Email", text: $email)
            SecureField("Password", text: $password)
            
            if (error) {
                HStack{
                    Image(systemName: "exclamationmark.triangle")
                    Text("Login Failed!")
                }.foregroundColor(.red)
            }
            
            Button(action: {
                self.sessionStore.signIn(email: self.email, password: self.password) { success in
                    print("login success = \(success)")
                    withAnimation {
                        self.error = !success
                    }
                }
            }) {
                Text("Sign In!")
                    .background(Color.green).foregroundColor(Color.white).cornerRadius(CGFloat(25))
            }
        }
    .padding(40)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
