//
//  OrdersTableViewController.swift
//  HotCoffe
//
//  Created by ivica petrsoric on 26/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    
    private var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateOrders()
    }
    
    private func populateOrders() {
//        guard let coffeeOrdersURL = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { return }
//        let resource = Resource<[Order]>(url: coffeeOrdersURL)
        
        Webservice().load(resource: Order.all) { [weak self] (result) in
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.tableView.reloadData()
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        cell.textLabel?.text = viewModel.type
        cell.detailTextLabel?.text = viewModel.size
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
            let addCoffeeOrderVC = navController.viewControllers.first as? AddOrderViewController
            else {
                fatalError("Error performing segue!")
        }
        
        addCoffeeOrderVC.delegate = self
    }
    
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func addCoffeeOrderViewControllerDiddSave(order: Order, controller: UIViewController) {
        controller.dismiss(animated: true, completion: nil)

        let orderViewModel = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderViewModel)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
    }
    
}
