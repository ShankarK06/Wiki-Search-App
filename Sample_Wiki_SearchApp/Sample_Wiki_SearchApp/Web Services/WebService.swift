//
//  WebService.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String:Any]

class Webservice {
    
    func getArticles(url :URL, callback :@escaping ([Article]) -> ()) {
        
        var articles = [Article]()
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                
                var dictionary = json as! JSONDictionary
                dictionary = dictionary["query"] as! JSONDictionary
                print(dictionary)
                let articleDictionaries = dictionary["pages"] as! [JSONDictionary]

                articles = articleDictionaries.flatMap { dictionary in
                    return Article(dictionary :dictionary)
                }
                DispatchQueue.main.async {
                    callback(articles)
                }

            }
            
            
            }.resume()
        
    }
    
}
