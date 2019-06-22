//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numViewPerRow = 15
    
    var cells = [String: UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let totalBoxesY = view.frame.height / width
        
        for j in 0...Int(totalBoxesY){
            for i in 0...numViewPerRow{
                let cellView = UIView()
                cellView.backgroundColor = randomColor()
                cellView.frame = CGRect(x: CGFloat(i) * width, y: CGFloat(j) * width,
                                        width: width, height: width)
                
                cellView.layer.borderWidth = 0.5
                cellView.layer.borderColor = UIColor.black.cgColor
                
                view.addSubview(cellView)
                
                let key = "\(i)|\(j)"
                cells[key] = cellView
            }
        }
        
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    var selectedCell: UIView?
    
    @objc func handlePan(gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: view)
        
        //optimizacija jer for loop trenutno previše ide (sto smo nize onda iterira po 400x)
        let width = view.frame.width / CGFloat(numViewPerRow)
        
        let i = Int(location.x / width)
        let j = Int(location.y / width)
        
        print("row: \(j), col: \(i)")
        
        let key = "\(i)|\(j)"
        guard let cellView = cells[key] else{ return }
        
        if selectedCell != cellView{
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.selectedCell?.layer.transform = CATransform3DIdentity
            }, completion: nil)
        }
        
        selectedCell = cellView
        
        view.bringSubviewToFront(cellView)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            cellView.layer.transform = CATransform3DMakeScale(3, 3, 3)
        })
        
        
        if gesture.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cellView.layer.transform = CATransform3DIdentity
            })
        }
    }
    
    private func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
}

