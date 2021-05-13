//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI

struct User: Decodable, Identifiable {
    let id: Int
    let name: String
}



struct StartView: View {
    
    @StateObject var viewModel: ViewModel
    
    init(viewModel: ViewModel = .init()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        List(viewModel.users) { user in
            Text(user.name)
        }.onAppear(perform: viewModel.getUsers)
    }
    
}



extension StartView {
    
    class ViewModel: ObservableObject {
        @Published var users = [User]()
        
        let dataService: DataService
        
        init(dataService: DataService = AppDataService()) {
            self.dataService = dataService
        }
        
        func getUsers() {
            dataService.getUsers { [weak self] (users) in
                self?.users = users
            }
        }
        
    }
    

    
}



struct StartView_Previews: PreviewProvider {
    static var previews: some View {
            let user = User(id: 0, name: "Dummy")
            let viewModel = StartView.ViewModel()
            viewModel.users = [user]
            return StartView(viewModel: viewModel)
    }
}

protocol DataService {
    func getUsers(completion: @escaping ([User]) -> Void)
}


class AppDataService: DataService {
    
    func getUsers(completion: @escaping ([User]) -> Void) {
        DispatchQueue.main.async {
            completion([
                User(id: 1, name: "Kyle"),
                User(id: 2, name: "Jamal"),
                User(id: 2, name: "Lee"),
            ])
        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//
//        }
    }
    
}
