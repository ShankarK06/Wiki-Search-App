//
//  SA_DetailViewController.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import UIKit
import WebKit

class SA_DetailViewController: UIViewController,WKNavigationDelegate {

    @IBOutlet weak var searchResultWebView: WKWebView!
    var URL_String: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URLRequest.init(url: URL.init(string: URL_String!)!)
        searchResultWebView.navigationDelegate = self
        searchResultWebView.load(url)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }


    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}