//  Product.swift
//  JonesSpencer_RemoteData
//  Created by Spencer Jones on 4/15/24.

import Foundation
 
class Product {
    // MARK: Stored Properties
    let catchPhrase: String
    var colorData: [ColorData]
    let dailyRevenue: String // May not have a value
    
    // MARK: Computed Properties
    // Property that returns a formatted string for daily revenue
    var formattedRevenue: String {
        var formattedRev = ""
        let rev = dailyRevenue
        formattedRev += "Daily Revenue: \(rev)"
        
        return formattedRev
    }
    
    // MARK: Initalizer
    init(catchPhrase: String, colorData: [ColorData] = [ColorData](), dailyRevenue: String) {
        self.catchPhrase = catchPhrase
        self.colorData = colorData
        self.dailyRevenue = dailyRevenue
    }
}
