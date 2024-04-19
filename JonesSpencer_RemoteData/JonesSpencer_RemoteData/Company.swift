//  Company.swift
//  JonesSpencer_RemoteData
//  Created by Spencer Jones on 4/15/24.

import Foundation

class Company {
    // MARK: Stored Properties
    let company: String
    let product: String
    let version: String
    
    // MARK: Computed Properties
    // Property that returns a formatted string for the product and version
    var productVersion: String {
        var prodVersString = ""
        let prod = product
        let vers = version
        
        prodVersString += "\(prod) (\(vers))"
        
        return prodVersString
    }
    
    // Property that returns a formatted string for the company name
    var formattedCompany: String {
        var formatedComp = ""
        let comp = company
        
        formatedComp += "By: \(comp)"
        
        return formatedComp
    }
    
    
    // MARK: Initalizer
    init(company: String, product: String, version: String) {
        self.company = company
        self.product = product
        self.version = version
    }
}
