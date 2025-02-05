//
//  Item.swift
//  tip calculator app
//
//  Created by Datla, Vaishnavi on 2/5/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
