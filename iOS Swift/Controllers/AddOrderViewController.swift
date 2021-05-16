//
//  AddOrderViewController.swift
//  HotCoffe
//
//  Created by ivica petrsoric on 26/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

protocol AddCoffeeOrderDelegate: class {
    func addCoffeeOrderViewControllerDiddSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: AddCoffeeOrderDelegate?
    
    private var viewModel = AddCoffeeOrderViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupUI()
    }
    
    private func setupUI() {
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(coffeeSizesSegmentedControl)
        
        coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20).isActive = true
        coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    @IBAction func save() {
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else { fatalError("Errpr on selecting coffe!") }
        
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        Webservice().load(resource: Order.create(viewModel: self.viewModel)) { (result) in
            switch result {
            case .success(let order):
                if let order = order {
                    DispatchQueue.main.async {
                        self.delegate?.addCoffeeOrderViewControllerDiddSave(order: order, controller: self)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func close() {
        delegate?.addCoffeeOrderViewControllerDidClose(controller: self)
    }
    
}
