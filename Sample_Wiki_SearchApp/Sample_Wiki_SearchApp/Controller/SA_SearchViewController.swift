//
//  SA_SearchViewController.swift
//  Sample_Wiki_SearchApp
//
//  Created by Shankar K on 28/10/18.
//  Copyright © 2018 Shankar. All rights reserved.
//

import UIKit
import SDWebImage

class SA_SearchViewController: UIViewController {

    @IBOutlet weak var NoresultsLable: UILabel!
    var isFromSavedValue: Bool = false
    private var viewModel :ArticleListViewModel = ArticleListViewModel()  {
        
        didSet {
            self.searchlistTableView.reloadData()
            self.searchlistTableView.isHidden = false
        }
    }
    var search = UISearchController(searchResultsController: nil)

    var didSelect: (ArticleViewModel) -> () = { Article in
        
    }

    
    @IBOutlet var searchlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NoresultsLable.text = "Start Searching for Results"
        self.NoresultsLable.isHidden = false
        self.searchlistTableView.isHidden = true
        self.title = self.viewModel.title
        self.searchlistTableView.estimatedRowHeight = 90
        self.searchlistTableView.rowHeight = UITableView.automaticDimension
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white

        search.searchResultsUpdater = self
        search.delegate = self
        search.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = search
        self.navigationItem.hidesSearchBarWhenScrolling = false

        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.fetchData()
    }
    
    
    private func loadArticles(string: String) {
        
        let searchString: String = string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let url = URL(string: "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=100&pilimit=30&wbptterms=description&gpssearch="+"\(searchString)"+"&gpslimit=30")!
        if self.checkForConnection(){
            
            Webservice().getArticles(url: url) { articles in
                
                let articles = articles.map { article in
                    return ArticleViewModel(article :article)
                }
                
                self.viewModel = ArticleListViewModel(articles :articles)
                self.searchlistTableView.isHidden = false
                self.searchlistTableView.reloadData()
                if self.viewModel.articles.count != 0 {
                    self.NoresultsLable.text = ""
                }else{
                    self.NoresultsLable.text = "No result Found"
                }

            }
        }else{
            search.isActive = false
            self.view.makeToast("No Internet,please check your network or WiFi connection", duration: 3.0, position: .center)
        }
    }
    
}


extension SA_SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        search.isActive = false
        
        let articleViewModel = self.viewModel.articles[indexPath.row]
        let art_String : String = String.init(format: "%@ ,  %@ ,  %@", articleViewModel.title,articleViewModel.description,articleViewModel.avatarURL!)
        DataManager().updateData(articles: [art_String])
        
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "SA_DetailViewController") as! SA_DetailViewController
        let urlString = articleViewModel.title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        detailsViewController.URL_String = "https://en.wikipedia.org/wiki/"+"\(urlString ?? "")"
        
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Common.CellIdentifier.searchCell , for: indexPath) as! SA_SearchTableViewCell
        let articleViewModel = self.viewModel.articles[indexPath.row]
        
        cell.title?.text = articleViewModel.title
        cell.detailDescription?.text = articleViewModel.description
        if articleViewModel.avatarURL != "" {
            let url = URL.init(string: articleViewModel.avatarURL!)
            cell.avatarImage!.sd_setImage(with: url, completed: nil)
        }
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.searchlistTableView.beginUpdates()

        if editingStyle == .delete {
            if isFromSavedValue {
                var article: [String] = DataManager().getArticle
                let art_String : String = String.init(format: "%@ ,  %@ ,  %@", self.viewModel.articles[indexPath.row].title,self.viewModel.articles[indexPath.row].description,self.viewModel.articles[indexPath.row].avatarURL!)
                
                var count = 0
                for art in article {
                    if art == art_String {
                        article.remove(at: count)
                    }
                    count = count+1
                }
                DataManager().saveData(articles: article)
            }
            self.viewModel.articles.remove(at: indexPath.row)
            self.searchlistTableView.deleteRows(at: [indexPath], with: .automatic)
            DispatchQueue.main.async {
                if self.viewModel.articles.count == 0 {
                    self.isFromSavedValue = false
                    self.searchlistTableView.isHidden = true
                    self.NoresultsLable.isHidden = false
                    self.viewModel = ArticleListViewModel()
                }
            }
            self.searchlistTableView.endUpdates()

        }
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
////            self.tableArray.remove(at: indexPath.row)
////            tableView.deleteRows(at: [indexPath], with: .fade)
////            print(self.tableArray)
//        }
//
//    }
}

extension SA_SearchViewController: UISearchControllerDelegate, UISearchResultsUpdating,UISearchBarDelegate {
    
    private func fetchData() {
        if DataManager().getArticle.count > 0 {
            var articles = [ArticleViewModel]()
             articles = DataManager().getArticle.compactMap { article in
                let ar: [String] = article.components(separatedBy: " ,  ")
                let art: Article = Article.init(title: ar[0], description: ar[1], avatarUrl: ar[2])
                
                return ArticleViewModel(article : art)
            }
            self.viewModel = ArticleListViewModel(articles :articles)
            self.searchlistTableView.isHidden = false
            self.NoresultsLable.isHidden = true
            isFromSavedValue = true
            self.searchlistTableView.reloadData()
        }else{
            isFromSavedValue = false
            self.searchlistTableView.isHidden = true
            self.NoresultsLable.isHidden = false
            self.viewModel = ArticleListViewModel()
        }
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        self.fetchData()
    }
    func didDismissSearchController(_ searchController: UISearchController) {
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("\(String(describing: searchController.searchBar.text))")
        if let text = searchController.searchBar.text, !text.isEmpty {
            self.loadArticles(string: searchController.searchBar.text!)
        }
        else {
        }

    }
}

