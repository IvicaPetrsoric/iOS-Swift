//
//  Order.swift
//  HotCoffe
//
//  Created by ivica petrsoric on 26/10/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import Foundation

enum CoffeType: String, Codable, CaseIterable {
    case cappuccino
    case lattee
    case espreessino
    case cortado
}

enum CoffeSize: String , Codable, CaseIterable {
    case small
    case medium
    case large
}

struct Order: Codable {
    
    let name: String
    let email: String
    let type: CoffeType
    let size: CoffeSize
    
    init?(_ viewModel: AddCoffeeOrderViewModel) {
        guard let name = viewModel.name,
        let email = viewModel.email,
        let selectedType = CoffeType(rawValue: viewModel.selectedType!.lowercased()),
        let selectedSize = CoffeSize(rawValue: viewModel.selectedSize!.lowercased())
        else { return nil }
        
        self.name = name
        self.email = email
        self.type = selectedType
        self.size = selectedSize
    }
    
    static var all: Resource<[Order]> = {
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("URL is incorrect!") }

        return Resource<[Order]>(url: url)
    }()
    
    static func create(viewModel: AddCoffeeOrderViewModel) -> Resource<Order?> {
        let order = Order(viewModel)
        
        guard let url = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else { fatalError("URL is incorrect!") }
        
        guard let data = try? JSONEncoder().encode(order) else { fatalError("Error encoding order!") }
        
        var resource = Resource<Order?>(url: url)
        resource.httpMethod = HttpMethod.post
        resource.body = data
        
        return resource
    }
    
}
