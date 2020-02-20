//
//  ListBooks.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/25/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation
import Apollo

struct Book: Hashable, Identifiable {
    var id: String
    var title: String
    var author: String
    
    init(title: String, author: String) {
        self.id = title
        self.title = title
        self.author = author
    }
}


fileprivate extension Book {
    init?(book: BookListQuery.Data.Book?) {
        guard
            let title = book?.title,
            let author = book?.author
            else {
                return nil
        }

        self.init(title: title,
                  author: author)
    }
}

// Fetch Book List API
protocol FetchBookList {
    func fetchBookList(completion: @escaping (Result<[Book],APIError>) -> Void)
}

class FetchBookListService : FetchBookList {
    private var apolloClient: ApolloClientFetchProtocol
    
    init(_ apolloClient: ApolloClientFetchProtocol) {
        self.apolloClient = apolloClient
    }
    
    func fetchBookList(completion: @escaping (Result<[Book],APIError>) -> Void) {
        apolloClient.fetch(query: BookListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                //Not familiar with statements on on lines 51 to 65
                guard let books = graphQLResult.data?.books?.compactMap(Book.init) else {
                    completion(.failure(.parsing))
                    return
                }
                
                completion(.success(books))
                return
                
            case .failure:
                completion(.failure(.network))
            }
        }
    }
}
