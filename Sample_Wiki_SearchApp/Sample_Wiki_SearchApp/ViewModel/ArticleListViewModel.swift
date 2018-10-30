//
//  ArticleListViewModel.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import Foundation


struct ArticleListViewModel {
    
    var title :String? = "WikiPedia Search"
    var articles :[ArticleViewModel] = [ArticleViewModel]()
}

extension ArticleListViewModel {
    
    init(articles :[ArticleViewModel]) {
        self.articles = articles
    }
    
}

struct ArticleViewModel {
    
    var title :String
    var description :String
    var avatarURL: String? = ""
}

extension ArticleViewModel {
    
    init(article :Article) {
        self.title = article.title
        self.description = article.description
        self.avatarURL = article.avatarURL
        
    }
}
