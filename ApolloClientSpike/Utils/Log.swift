//
//  Log.swift
//  ApolloClientSpike
//
//  Created by Athens Holloway on 1/25/20.
//  Copyright © 2020 Logic Artisan, Inc. All rights reserved.
//

/*
 Research capabilities of the unified logging system
 
 - Resources:
 https://www.raywenderlich.com/605079-migrating-to-unified-logging-console-and-instruments
 */

import Foundation
import os

private let subsystem = "co.logicartisan.ApolloCientSpike"

struct Log {
    static let networkingLog = OSLog(subsystem: subsystem, category: "Networking")
    
    func debug(_ message: String) {
        os_log("%s", log: Log.networkingLog, type: .debug, message)
    }
    
    func info(_ message: String) {
        os_log("%s", log: Log.networkingLog, type: .info, message)
    }
    
    func error(_ message: String) {
        os_log("%s", log: Log.networkingLog, type: .error, message)
    }
}

let log = Log();

