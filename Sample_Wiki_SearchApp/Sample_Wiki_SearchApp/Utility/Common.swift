//
//  Common.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation
import UIKit
import Reachability

struct Common {
    // MARK: - Storyboards
    struct Storyboards {
        static let MainStoryboard = "Main"
    }
    
    // MARK: - Cell Identifier
    struct CellIdentifier {
        static let searchCell = "SearchCell"
    }
    
    // MARK: - Stored Data Key
    struct StoreData {
        static let Saved_Articles = "Articles"
    }

}

extension UIViewController {
    
    func showAlert(with title: String, and message: String, withButtonTitle buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    func checkForConnection() -> Bool
    {
        let reachability = Reachability()!
        switch reachability.connection {
        case .cellular,.wifi:
            return true
        case .none:
            return false
        }
    }


}
