//
//  App.swift
//  iTunesAppsList
//
//  Created by Abdullah Adwan on 5/30/18.
//  Copyright © 2018 Abdullah Adwan. All rights reserved.
//

import Foundation
import Alamofire

typealias JSONDictionary = [String:Any]

class App: NSObject {
    
    var name: String
    var imageURL: URL?
    var summary: String
    var category: String
    var link: URL?
    var releaseDate: String
    
    init(name: String, imageURL: URL, summary: String, category: String, releaseDate: String) {
        self.name = name
        self.imageURL = imageURL
        self.summary = summary
        self.category = category
        self.releaseDate = releaseDate
    }
    
    init(appInfoJSON: JSONDictionary) {
        let nameJSON = appInfoJSON["im:name"] as! JSONDictionary
        self.name = nameJSON["label"] as! String
        
        let imageUrlJSONs = appInfoJSON["im:image"] as! [JSONDictionary]
        let imageUrlString = imageUrlJSONs[2]["label"] as! String
        self.imageURL = URL(string: imageUrlString)
        
        let summaryJSON = appInfoJSON["summary"] as! JSONDictionary
        self.summary = summaryJSON["label"] as! String
        
        let linkJSON = appInfoJSON["link"] as! JSONDictionary
        let linkAttribuesJSON = linkJSON["attributes"] as! JSONDictionary
        self.link = URL(string: linkAttribuesJSON["href"] as! String)
        
        let categoryJSON = appInfoJSON["category"] as! JSONDictionary
        let categoryAttribuesJSON = categoryJSON["attributes"] as! JSONDictionary
        self.category = categoryAttribuesJSON["label"] as! String
        
        let releaseDataJSON = appInfoJSON["im:releaseDate"] as! JSONDictionary
        let releaseDataAttribuesJSON = releaseDataJSON["attributes"] as! JSONDictionary
        self.releaseDate = releaseDataAttribuesJSON["label"] as! String
    }
    
    static func getAppsInfoJSON(apiURL: String, completion: @escaping([JSONDictionary]?) -> Void) {
        if let requestURL = URL(string: apiURL) {
            Alamofire.request(requestURL).responseJSON { (respose) in
                switch (respose.result) {
                case .success(_):
                    guard let value  =  respose.result.value as? JSONDictionary else {
                        print("Error while fetching remote apps info")
                        completion(nil)
                        return
                    }
                    let feed = value["feed"] as! JSONDictionary
                    let appsInfoJSON = feed["entry"] as! [JSONDictionary]
                    completion(appsInfoJSON)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
