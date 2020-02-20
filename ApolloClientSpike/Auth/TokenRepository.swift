//
//  TokenRepository.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/25/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation

class TokenRepository {
    static let shared = TokenRepository()
    
    var token: String?
}
