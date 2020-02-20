//
//  BookListView.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/25/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import SwiftUI

struct BookListView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack {
            List(appState.books) { book in
                HStack {
                    Text(book.title)
                    Spacer()
                    Text(book.author)
                }
            }
        }.onAppear() {
            let fethBooksList = FetchBookListService(Network.shared.apollo)
            
            fethBooksList.fetchBookList() { result in
                switch result {
                case let .success(books):
                    self.appState.books = books
                    log.debug("Books: \(books)")
                case .failure(.network):
                    log.error("Network Error")
                case .failure(.parsing):
                    log.error("Parsing Error")
                }
            }
        }
    }
        
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
