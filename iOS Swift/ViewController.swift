//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var items = ["Item 1", "Item 2", "Item 3"]
    
    let cellId = "cellId"
    let headerId = "headerId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "My TableView"
        
        tableView.register(MyCell.self, forCellReuseIdentifier: cellId)
        tableView.register(HeaderCell.self, forHeaderFooterViewReuseIdentifier: headerId)
        
        tableView.sectionHeaderHeight = 50
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: #selector(insert))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Batch Insert", style: .plain, target: self, action: #selector(batchInsert))
    }
    
    @objc func insert(){
        items.append("Item \(items.count + 1)")
        
        let intesrtionIndexPath = IndexPath(row: items.count - 1, section: 0)
        tableView.insertRows(at: [intesrtionIndexPath], with: .automatic)
        tableView.reloadData()
    }
    
    @objc func batchInsert(){
        var indexPaths = [IndexPath]()
        for i in items.count...items.count + 5{
            items.append("Item \(i + 1)")
            indexPaths.append(IndexPath(row: i, section: 0))
        }
        
        var bottomHaldIndexPath = [IndexPath]()
        for _ in 0...indexPaths.count / 2 - 1{
            bottomHaldIndexPath.append(indexPaths.removeLast())
        }
        
        tableView.beginUpdates()
        tableView.insertRows(at: indexPaths, with: .right)
        tableView.insertRows(at: bottomHaldIndexPath, with: .left)
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MyCell
        cell.nameLabel.text = items[indexPath.row]
        cell.myTableViewController = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func deleteCell(cell: UITableViewCell){
        if let deletionIndexPath = tableView.indexPath(for: cell){
            items.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
    
}
