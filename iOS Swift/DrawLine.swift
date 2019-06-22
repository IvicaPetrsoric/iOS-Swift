//
//  DrawLine.swift
//  TicTacToe
//
//  Created by ivica petrsoric on 22/06/2019.
//  Copyright © 2019 Ivica Petrsoric. All rights reserved.
//

import UIKit

class DrawLine: UIView {
    
    private let path = UIBezierPath()
    
    func removeBaziethPath(){
        path.removeAllPoints()
    }
    
    override func draw(_ rect: CGRect) {
        UIColor.black.setStroke()
        path.lineWidth = 5
        path.stroke()
    }
    
    func drawPath(rect: UIButton, endRect: UIButton){
        path.move(to: CGPoint(x: rect.frame.origin.x + rect.frame.width / 2, y:rect.frame.origin.y + rect.frame.height / 2))
        path.addLine(to: CGPoint(x: rect.frame.origin.x + endRect.frame.width / 2, y: rect.frame.origin.y + endRect.frame.height / 2))
        
    }
}
