//
//  ViewController.swift
//  QuestionTableView
//
//  Created by Ivica Petrsoric on 29/11/2017.
//  Copyright © 2017 Ivica Petrsoric. All rights reserved.
//

import UIKit

class QuestionController: UITableViewController {

    let cellId = "cellId"
    let headerId = "headerId"
    
    var questionList: [Question] = [
        Question(questionString: "What is your favorite type of food", answers: ["Sandwiches", "Pizza", "Seafood", "Umagi"], selectedAnswerIndex: nil),
        Question(questionString: "What do you do for leaving", answers: ["Nothing", "Chef", "Balot", "asd"], selectedAnswerIndex: nil),
        Question(questionString: "were you on a break?", answers: ["Yes", "No"], selectedAnswerIndex: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Question"
        
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        tableView.register(AnswerCell.self, forCellReuseIdentifier: cellId)
        tableView.register(QuestionHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.sectionHeaderHeight = 50
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            if let count = question.answers?.count{
                return count
            }
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnswerCell
        
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            cell.nameLabel.text = question.answers?[indexPath.row]
        }
        
        return  cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! QuestionHeader
        
        if let index = navigationController?.viewControllers.index(of: self){
            let question = questionList[index]
            header.nameLabel.text = question.questionString
        }
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let index = navigationController?.viewControllers.index(of: self){
            questionList[index].selectedAnswerIndex = indexPath.row
            
            if index < questionList.count - 1{
                let questionController = QuestionController()
                navigationController?.pushViewController(questionController, animated: true)
            } else{
                let controller = ResultsController()
                controller.questionList = self.questionList
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }

}






