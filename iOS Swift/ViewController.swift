//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import SwiftUI
import CoreData


struct TestCoreData: View {
    
    
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: false)])
//    @FetchRequest(sortDescriptors: [])
    private var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(tasks) { task in
                    Text(task.title ?? "Untitled")
                        .onTapGesture {
                            updateTask(task)
                        }
                }.onDelete(perform: deleteTasks)
            }

        }
        .navigationBarTitle(Text("Todo List"))
        .navigationBarItems(trailing: Button("Add Task") {
            addTask()
        })
//        return Text("")
        
        if #available(iOS 14.0, *) {

        } else {
            // Fallback on earlier versions
        }
    }
    
    private func addTask() {
        withAnimation {

        let newTask = Task(context: viewContext)
        newTask.title = "New Task \(Date())"
        newTask.date = Date()
        
        saveContext()
        }

    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch  {
            let error = error as NSError
            fatalError("unresolved Error\(error)")
        }
    }
    
    private func deleteTasks(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
    
    private func updateTask(_ task: FetchedResults<Task>.Element) {
        withAnimation {
            task.title = "Updatet"
            saveContext()
        }
    }
}


struct StartView: View {

    var body: some View {
        VStack {
            TestCoreData()
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
