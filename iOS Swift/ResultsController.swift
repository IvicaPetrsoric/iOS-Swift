//
//  ResultsController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ResultsController: UIViewController{
    
    var questionList: [Question]! {
        didSet {
            let names = ["Ross", "Joey", "Chandler", "Monica", "Reachel", "Phoebe"]
            var score = 0
            
            for question in questionList {
                if let index = question.selectedAnswerIndex {
                    score = score + index
                }
            }
            
            let result = names[score % names.count]
            resultsLabel.text = "Congratulation, you're a total \(result)!"
        }
    }
    
    private let resultsLabel: UILabel = {
        let label = UILabel()
        label.text = "Congratulation, you're a total Ross"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        
        navigationItem.title = "Result"
        
        view.backgroundColor = .white
        
        view.addSubview(resultsLabel)
        resultsLabel.fillSuperview()
        

    }
    
    @objc func done(){
        navigationController?.popToRootViewController(animated: true)
    }
    
}
