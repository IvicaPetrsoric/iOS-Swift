//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var inputTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.isScrollEnabled = false
        textView.font = UIFont.preferredFont(forTextStyle: .headline)
        textView.delegate = self
        textView.text = "Enter text to change height constraint"
        return textView
    }()
    
    fileprivate var inputTextViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(inputTextView)
        inputTextViewHeightConstraint = inputTextView.anchor(top: nil, leading: view.leadingAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor,
                             size: .init(width: 0, height: 50)).height

        textViewDidChange(inputTextView)
    }
    
}

extension ViewController: UITextViewDelegate{
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: view.frame.width, height: .infinity)
        let estimetedSize = textView.sizeThatFits(size)
        
        // #1
//        textView.constraints.forEach { (constraint) in
//            if constraint.firstAttribute == .height{
//                constraint.constant = estimetedSize.height
//            }
//        }
        
        // #2
        inputTextViewHeightConstraint.constant = estimetedSize.height
    }
    
}

