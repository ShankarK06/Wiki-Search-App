//
//  DataManager.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation

struct DataManager {
    
    var getArticle : [String] {
        
        get {
            if UserDefaults.standard.object(forKey: Common.StoreData.Saved_Articles) != nil {
                return UserDefaults.standard.object(forKey: Common.StoreData.Saved_Articles) as! [String]
            }
            return []
        }
    }
    
    func updateData(articles: [String]) {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: Common.StoreData.Saved_Articles) != nil {
          var art: [String] = userDefaults.object(forKey: Common.StoreData.Saved_Articles) as! [String]
            for element in articles{
                if !art.contains(element){
                    art.append(element)
                }
            }
            self.saveData(articles: art)
        }else{
            self.saveData(articles: articles)
        }
    }
        
    
    func saveData(articles: [String]) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(articles, forKey: Common.StoreData.Saved_Articles)
        userDefaults.synchronize()
    }
    
    
}
