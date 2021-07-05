//
//  Extension.swift
//  SecretRoom
//
//  Created by Ivica Petrsoric on 08/03/2018.
//  Copyright © 2018 Ivica Petrsoric. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

var width: CGFloat = 0.02
var height: CGFloat = 1
var length: CGFloat = 1

var doorLength: CGFloat = 0.3

func createBox(isDoor: Bool) -> SCNNode {
    let node = SCNNode()
    
    // add first box
    let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBoxNode.renderingOrder = 200
    
    node.addChildNode(firstBoxNode)

    // add masked box
    let maskedBox = SCNBox(width: width, height: height, length:  isDoor ? doorLength : length, chamferRadius: 0)
    maskedBox.firstMaterial?.diffuse.contents = UIColor.white
    maskedBox.firstMaterial?.transparency = 0.00001
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100
    maskedBoxNode.position = SCNVector3.init(width, 0, 0)
    
    node.addChildNode(maskedBoxNode)

    
    return node
}

extension FloatingPoint {
    var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}
