//
//  ApolloClientFetchProtocol.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/25/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation
import Apollo

/// Fetches a query from the server or from the local cache, depending on the current contents of the cache and the specified cache policy.
///
/// - Parameters:
///   - query: The query to fetch.
///   - cachePolicy: A cache policy that specifies when results should be fetched from the server and when data should be loaded from the local cache.
///   - resultHandler: [optional] A closure that is called when query results are available or when an error occurs.
/// - Returns: An object that can be used to cancel an in progress fetch.
public protocol ApolloClientFetchProtocol {
    @discardableResult func fetch<Query: GraphQLQuery>(query: Query,
                                  resultHandler: GraphQLResultHandler<Query.Data>?) -> Cancellable
}

extension ApolloClient: ApolloClientFetchProtocol {
    
    @discardableResult public func fetch<Query: GraphQLQuery>(query: Query,
                                                              resultHandler: GraphQLResultHandler<Query.Data>?) -> Cancellable {
        self.fetch(query: query,
                   cachePolicy: .returnCacheDataElseFetch,
                   context: nil,
                   queue: DispatchQueue.main,
                   resultHandler: resultHandler)
    }
    
}
