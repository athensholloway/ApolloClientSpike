//
//  Network.sqift.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/22/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

import Foundation
import Apollo


class Network {
  static let shared = Network()
  let log = Log()
    
  // Configure the network transport to use the singleton as the delegate.
  private lazy var networkTransport = HTTPNetworkTransport(
    url: URL(string: "http://localhost:4000/graphql")!,
    delegate: self
  )
  
  //What instance does self refer to?
  
  // Use the configured network transport in your Apollo client.
  private(set) lazy var apollo = ApolloClient(networkTransport: self.networkTransport)
}



// MARK: - Pre-flight delegate

extension Network: HTTPNetworkTransportPreflightDelegate {

  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                          shouldSend request: URLRequest) -> Bool {
    // If there's an authenticated user, send the request. If not, don't.
    
    log.debug("Should send request: true")
    
    return true
  }
  
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        willSend request: inout URLRequest) {
    log.debug("Searching for existing authentication token ...")
    guard let token = TokenRepository.shared.token else {
        log.debug("Authentication token does not exist...")
        return
    }
    
    log.debug("Authentication token found...")
    
    // Get the existing headers, or create new ones if they're nil
    var headers = request.allHTTPHeaderFields ?? [String: String]()

    // Add any new headers you need
    headers["Authorization"] = "Bearer \(token)"
  
    // Re-assign the updated headers to the request.
    request.allHTTPHeaderFields = headers
    log.debug("Outgoing request: \(request)")
  }
}

// MARK: - Task Completed Delegate

extension Network: HTTPNetworkTransportTaskCompletedDelegate {
  func networkTransport(_ networkTransport: HTTPNetworkTransport,
                        didCompleteRawTaskForRequest request: URLRequest,
                        withData data: Data?,
                        response: URLResponse?,
                        error: Error?) {
    log.debug("Raw task completed for request: \(String(decoding: request.httpBody!, as: UTF8.self))")
                        
    if let error = error {
        log.error("Error: \(error)")
    }
    
    if let response = response {
        log.debug("Response: \(response)")
    } else {
      log.debug("No URL Response received!")
    }
    
    if let data = data {
      log.debug("Data: \(String(describing: String(bytes: data, encoding: .utf8)))")
    } else {
      log.debug("No data received!")
    }
  }
}
