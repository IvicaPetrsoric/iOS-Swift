//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI
import Combine

struct User: Decodable, Identifiable {
    let id: Int
    let name: String
}

final class ViewModel: ObservableObject {
    
    @Published var time = ""
//    private var ancCancallable: AnyCancellable?
    private var cancallables = Set<AnyCancellable>()
    
    @Published var users: [User] = []
    
    let formatter: DateFormatter = {
        let df = DateFormatter()
        df.timeStyle = .medium
        return df
    }()
    
    init() {
        setupPublisher()
    }
    
    private func setupPublisher() {
        setupTimerPublisher()
        setupDataTaskPublisher()
    }
    
    private func setupTimerPublisher() {
//        ancCancallable = Timer.publish(every: 1, on: .main, in: .default)
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .receive(on: RunLoop.main)
            .sink { value in
                self.time = self.formatter.string(from: value)
            }
            .store(in: &cancallables)
    }
    
    private func setupDataTaskPublisher() {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data  in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(URLError.badServerResponse)
                }
                
                return data
            }
            .decode(type: [User].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }) { (users) in
                self.users = users
            }
            .store(in: &cancallables)
    }
    
}

struct StartView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.time)
                .padding()
            
            List(viewModel.users) { user in
                Text(user.name)
            }
        }
    }
    
}




struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            StartView()
        }
    }
}
