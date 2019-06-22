//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UITableViewController {

    let cellId = "cellId"
    
    // use cutom delegation!
    func someMethodIWantToCall(cell: UITableViewCell){
        // we are going to figure out wwhich name we are clickin on
        
        guard let indexPathTapped = tableView.indexPath(for: cell) else{
            return
        }
        
        let contact = twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row]
        
        let hasFavorited = contact.hasFavorite
        twoDimensionalArray[indexPathTapped.section].names[indexPathTapped.row].hasFavorite = !hasFavorited
        
        cell.accessoryView?.tintColor = hasFavorited ? UIColor.lightGray : .red
    }
    
    var twoDimensionalArray = [ExpandableNames]()
    
    private func fetchContacts(){
        print("Fetch phone numbers")
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts) { (granted, err) in
            if let err = err{
                print("Failed to request acess: ", err)
                return
            }
            
            if granted{
                print("Acess granted")
                
                var favoritableContacts = [FavoritableContact]()
                
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do{
                    try store.enumerateContacts(with: request, usingBlock: { (contact, stopPoinnterIfYouWantToStopEnumerating) in
                        //                        print(contact.givenName)
                        //                        print(contact.familyName)
                        //                        print(contact.phoneNumbers.first?.value.stringValue as Any)
                        
                        favoritableContacts.append(FavoritableContact(contact: contact, hasFavorite: false))
                        //                        favoritableContacts.append(FavoritableContact(name: contact.givenName + " " + contact.familyName, hasFavorite: false))
                    })
                    
                    let names = ExpandableNames(isExpanded: true, names: favoritableContacts)
                    self.twoDimensionalArray = [names]
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }catch let err{
                    print("failed to catch contacts ", err)
                }
                
            }else{
                print("Acess denied...")
            }
        }
    }
    
    var showIndexPaths = false
    
    @objc func handleShowIndexPath(){
        print("Attempting reload animation of indexPath...")
        
        // build all the inexPaths we want to reload
        var indexPathsReload = [IndexPath]()
        
        for section in twoDimensionalArray.indices{
            //            print(section)
            
            let isExpanded = twoDimensionalArray[section].isExpanded
            
            if isExpanded{
                //            for row in twoDimensionalArray[section].indices{
                for row in twoDimensionalArray[section].names.indices{
                    //                print(section, row)
                    let indexPath = IndexPath(row: row, section: section)
                    indexPathsReload.append(indexPath)
                }
            }
        }
        
        showIndexPaths = !showIndexPaths
        
        let animationStyle = showIndexPaths ? UITableView.RowAnimation.right : .left
        tableView.reloadRows(at: indexPathsReload, with: animationStyle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchContacts()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(handleShowIndexPath))
        
        navigationItem.title = "Contacts"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(ContactCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.yellow
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandClose(button: UIButton){
        print("Trying to exapnd and close in row")
        
        let section = button.tag
        
        var indexPaths = [IndexPath]()
        for row in twoDimensionalArray[section].names.indices{
            print(0, row)
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        
        let isExpanded = twoDimensionalArray[section].isExpanded
        twoDimensionalArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        
        if isExpanded{
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        else{
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionalArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionalArray[section].isExpanded{
            return 0
        }
        
        return twoDimensionalArray[section].names.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ContactCell(style: .subtitle, reuseIdentifier: cellId)
        let favoritableContact = twoDimensionalArray[indexPath.section].names[indexPath.row]
        let name = favoritableContact.contact.givenName + " " + favoritableContact.contact.familyName
        
        cell.link = self
        cell.accessoryView?.tintColor = favoritableContact.hasFavorite ? UIColor.red: .lightGray
        cell.detailTextLabel?.text = favoritableContact.contact.phoneNumbers.first?.value.stringValue
        
        if showIndexPaths{
            cell.textLabel?.text = "\(name) Section:\(indexPath.section) Row: \(indexPath.row)"
        }
        else{
            cell.textLabel?.text = name
        }
        
        return cell
    }


}

