//
//  DataManager.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation

struct DataManager {
    
    var getArticle : [Article] {
        
        get {
            let decoded  = UserDefaults.standard.object(forKey: Common.StoreData.Saved_Articles) as! Data
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Article] ?? []
            return decodedTeams
        }
    }
    
    func updateData(articles: [Article]) {
//        let decoded  = UserDefaults.standard.object(forKey: Common.StoreData.Saved_Articles) as! Data
//        var decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Article] ?? []
//        if decodedTeams.count == 0 {
//            saveData(articles: articles)
//        }else{
//            decodedTeams.append(contentsOf: articles)
//            saveData(articles: decodedTeams)
//        }
    }
        
    
    func saveData(articles: [Article]) {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: articles, requiringSecureCoding: false)
        userDefaults.set(encodedData, forKey: Common.StoreData.Saved_Articles)
        userDefaults.synchronize()
    }
    
    
}
