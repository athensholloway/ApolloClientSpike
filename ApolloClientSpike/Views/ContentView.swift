//
//  ContentView.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/21/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var sessionStore: SessionStore
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            
            if(sessionStore.isUserAuthenticated()) {
                BookListView().transition(.opacity)
            }else {
                SignInView()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore(signIn: SignInService()))
    }
}
