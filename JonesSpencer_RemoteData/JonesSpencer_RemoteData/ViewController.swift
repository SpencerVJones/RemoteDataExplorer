//  ViewController.swift
//  JonesSpencer_RemoteData
//  Created by Spencer Jones on 4/15/24.

import UIKit

class ViewController: UIViewController {
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var catchPhraseLabel: UILabel!
    @IBOutlet var dailyRevenueLabel: UILabel!
    @IBOutlet var colorsTextView: UITextView!
    
    var currentCompanyIndex = 0
    var companies = [Company]()
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Create default configuration
        let config = URLSessionConfiguration.default
        // Create session
        let session = URLSession(configuration: config)
        
        // MARK: Retreive JSON Data From Remote Server 1
        // Validate the first URL
        if let url1 = URL(string: "https://fullsailmobile.firebaseio.com/T1NVC.json") { // Contains: company, name, and version
            // Create task that downloads data at url1 as data object
            let task1 = session.dataTask(with: url1) { (data, response, error) in
                // If theres an error, return
                if let error = error {
                    print("Data task with url1 failed with error: " + error.localizedDescription)
                    return
                }
                
                // Check the response status and validate data
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200, // 200 means ok
                      let validData = data
                else { print("JSON Object Creation Failed"); return }
                
                // Call parse method with do-catch block and resume task
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    // Parse the JSON data from the first URL
                    self.ParseURL1(jsonObject: jsonObj)
                }
                catch { print(error.localizedDescription) }
            }
            task1.resume()
        }
        
        // MARK: Retreive JSON Data From Remote Server 2
        // Validate the second URL
        if let url2 = URL(string: "https://fullsailmobile.firebaseio.com/T2CRC.json") { // Contains: catch_phrase, colors[color,desription], daily_revene
            // Create task that downloads data at url2 as data object
            let task2 = session.dataTask(with: url2) { (data, response, error) in
                // If theres an error, return
                if let error = error {
                    print("Data task with url2 failed with error: " + error.localizedDescription)
                    return
                }
                
                // Check the response status and validate data
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200, // 200 means ok
                      let validData = data
                else { print("JSON Object Creation Failed"); return }
                
                // Call parse method with do-catch block and resume task
                do {
                    let jsonObj = try JSONSerialization.jsonObject(with: validData, options: .mutableContainers) as? [Any]
                    // Parse the JSON data from the second URL
                    self.ParseURL2(jsonObject: jsonObj)
                }
                catch { print(error.localizedDescription) }
            }
            task2.resume()
        }
    }
    
    // MARK: Parse data from URL 1
    func ParseURL1(jsonObject: [Any]?) {
        guard let json = jsonObject
        else { print("Parse failed to unwrap the optional"); return }
        
        // Loop through first level object
        for firstLevelItem in json {
            // Try to conver first level object into a [String: Any]
            guard let object = firstLevelItem as? [String: Any],
                // Get value of properties for the current object
                let companyName = object["company"] as? String,
                let productName = object["name"] as? String,
                let version = object["version"] as? String
                    
            else { continue }
            
            // Create Company object with parsed data and add it to companies
            let company = Company(company: companyName, product: productName, version: version)
            companies.append(company)
        }
    }
    
    
    // MARK: Parse data from URL 2
    func ParseURL2(jsonObject: [Any]?) {
        
        guard let json = jsonObject
        else { print("Parse failed to unwrap the optional"); return }
        
        // Loop through first level object
        for firstLevelItem in json {
            // Try to conver first level object into a [String: Any]
            guard let object = firstLevelItem as? [String: Any],
                  let catchPhrase = object["catch_phrase"] as? String
            else { continue }
            
            // Get the daily revenue value
            let dailyRevenue = object["daily_revene"] as? String

            var colorDataArray = [ColorData]()
            if let colors = object["colors"] as? [[String: Any]] {
                for c in colors {
                    guard let color = c["color"] as? String,
                          let description = c["desription"] as? String
                    else { continue }
                    // Create ColorData object and add it to colorDataArray
                    let colorData = ColorData(color: color, description: description)
                    colorDataArray.append(colorData)
                    
                }
            }
            // Create Product object with parsed data and add it to products
            let product = Product(catchPhrase: catchPhrase, colorData: colorDataArray, dailyRevenue: dailyRevenue ??  "$0.00")
            products.append(product)
        }
        // Update UI
        UpdateUI()
    }
    
    // MARK: Function to update the UI
    func UpdateUI() {
        DispatchQueue.main.async {
            // Update labels with the currentCompanyIndex
            self.companyNameLabel.text = self.companies[self.currentCompanyIndex].formattedCompany
            self.productNameLabel.text = self.companies[self.currentCompanyIndex].productVersion
            self.catchPhraseLabel.text = self.products[self.currentCompanyIndex].catchPhrase
            self.dailyRevenueLabel.text = self.products[self.currentCompanyIndex].formattedRevenue
            
            // Loop through color data for current product
            var descriptionText = ""
            for colorData in self.products[self.currentCompanyIndex].colorData {
                // Append the color and description to descriptionText string
                descriptionText += "\(colorData.description): \(colorData.color)\n"
            }
            // Update text view with color and description
            self.colorsTextView.text = descriptionText
        }
    }
    
    
    // MARK: Storyboard Actions
    @IBAction func CurrentCompanyChanged(_ sender: UIButton) {
        // Next button: tag = 1
        // Previous button: tag = -1
        
        // Update currentCompanyIndex based on button tag
        currentCompanyIndex += sender.tag
        
        if currentCompanyIndex < 0 {
            currentCompanyIndex = companies.count - 1
        }
        else if currentCompanyIndex >= companies.count {
            currentCompanyIndex = 0
        }
        // Update the UI
        UpdateUI()
    }
}
