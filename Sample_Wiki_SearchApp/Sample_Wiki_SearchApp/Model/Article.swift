//
//  Article.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation

class Article {
    
    var title :String
    var description :String
    var avatarURL :String? = ""
    
    init(title :String, description :String, avatarUrl :String) {
        self.title = title
        self.description = description
        self.avatarURL = avatarUrl
    }
    
    
    init?(dictionary :JSONDictionary) {
        
        guard let title = dictionary["title"] as? String, let des = dictionary["terms"] as? JSONDictionary, let describ = des["description"] as? [String] else {
            return nil
        }
        self.title = title
        self.description = describ.joined(separator: ",")
        
        if let thumbnail = dictionary["thumbnail"] as? JSONDictionary{
            guard let avatarURL = thumbnail["source"] as? String else {
                return nil
            }
            self.avatarURL = avatarURL
        }

    }
    
}
