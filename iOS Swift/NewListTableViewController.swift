//
//  NewListTableViewController.swift
//  GoodNews
//
//  Created by ivica petrsoric on 25/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class NewListTableViewController: UITableViewController {
    
    private var articleListViewModel: ArticleListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    private func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=be061bb8a6194c94837f62995cba9641") else { return }
        
        Webservice().getArticles(url: url) { articles in
            guard let articles = articles else { return }
            self.articleListViewModel = ArticleListViewModel(articles: articles)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListViewModel == nil ? 0 : self.articleListViewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListViewModel.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleViewModel = self.articleListViewModel.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleViewModel.title
        cell.descriptionLabel.text = articleViewModel.description
        return cell
    }
}
