//
//  ContentView.swift
//  StackingEssentials
//
//  Created by ivica petrsoric on 07/02/2020.
//  Copyright © 2020 ivica petrsoric. All rights reserved.
//

let apiUrl = "https://api.letsbuildthatapp.com/static/courses.json"

import SwiftUI

struct Course: Identifiable, Decodable {
    
    let id = UUID()
    let name: String
    
}

class CoursesViewModel: ObservableObject {
    
    @Published var messages = "Messages inside obserable object"
    
    @Published var courses: [Course] = [
    .init(name: "Course 1"),
    .init(name: "Course 2"),
    ]
    
    func fetchCourses() {
        guard let url = URL(string: apiUrl) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            DispatchQueue.main.async {
                self.courses = try! JSONDecoder().decode([Course].self, from: data!)
            }
        }.resume()
    }
    
}

struct ContentView: View {
    
    @ObservedObject var coursesVM = CoursesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                Text(coursesVM.messages)
                
                ForEach(coursesVM.courses) { course in
                    Text(course.name)
                }
        }.navigationBarTitle("Courses")
        .navigationBarItems(trailing: Button(action: {
                print("Fetching json data")
            self.coursesVM.messages = "Something else"
            self.coursesVM.fetchCourses()
            }, label: {
                Text("Fetch Courses")
            }))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
