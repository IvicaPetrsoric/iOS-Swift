//
//  CompaniesController.swift
//  CodeSpeedRun
//
//  Created by Ivica Petrsoric on 09/04/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import UIKit

class CompanyCell: GenericCell<Company> {
    
    override var item: Company!{
        didSet{
//            textLabel?.text = item.name
            
            nameLabel.text = item.name
            ceoLabel.text = item.ceo
        }
    }
    
    let nameLabel = UILabel()
    let ceoLabel = UILabel()
    
    override func setupViews() {
        super.setupViews()
        
        let stackVew = UIStackView(arrangedSubviews: [nameLabel, ceoLabel])
        stackVew.distribution = .fillEqually
        addSubview(stackVew)
        stackVew.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
    }
    
}

class CompaniesController: GenericTableViewController<CompanyCell, Company> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Companies"
        tableView.rowHeight = 50
        
        items = Company.companies
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let employeesController = EmployeesController()
        let company = items[indexPath.item]
        employeesController.company = company
        
        navigationController?.pushViewController(employeesController, animated: true)
    }
    
}

class EmployeeCell: GenericCell<Employee> {
    override var item: Employee! {
        didSet{
            textLabel?.text = item.name
        }
    }
}

class EmployeesController: GenericTableViewController<EmployeeCell, Employee> {
    
    var company: Company! {
        didSet{
            navigationItem.title = company.name
            self.items = company.employees
        }
    }
    
}
