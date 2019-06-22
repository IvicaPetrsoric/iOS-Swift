//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        self.sceneView.automaticallyUpdatesLighting = true
    }
    
    @IBAction func add(_ sender: UIButton) {
        let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
        doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.white
        
        //        let cylinderNode = SCNNode(geometry: SCNCylinder(radius: 0.05, height: 0.05))
        //        cylinderNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        let boxNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
        boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        
        let node = SCNNode()
        
        // capsule
        //        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
        
        // cone
        //        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 1)
        
        // cylinder
        //        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
        
        // sphere
        //        node.geometry = SCNSphere(radius: 0.1)
        
        // tube
        //        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
        
        // torus
        //        node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.2)
        
        // plane
        //        node.geometry = SCNPlane(width: 0.2, height: 0.2)
        
        // pyramid
        node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        // box
        //        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        
        //        let path = UIBezierPath()
        //        path.move(to: CGPoint(x: 0, y: 0))
        //        path.addLine(to: CGPoint(x: 0, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.2, y: 0.3))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0.2))
        //        path.addLine(to: CGPoint(x: 0.4, y: 0))
        //
        //        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        //
        //        node.geometry = shape
        
        node.geometry?.firstMaterial?.specular.contents = UIColor.orange
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //        let x = randomNumbers(firstNum: -0.3, secondNumb: 0.3)
        //        let y = randomNumbers(firstNum: -0.3, secondNumb: 0.3)
        //        let z = randomNumbers(firstNum: -0.3, secondNumb: 0.3)
        
        //        node.position = SCNVector3(x, y, z)
        
        node.position = SCNVector3(0.2, 0.3, -0.2)
        boxNode.position = SCNVector3(0, -0.05, 0)
        doorNode.position = SCNVector3(0, -0.02, 0.053)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        node.addChildNode(boxNode)
        boxNode.addChildNode(doorNode)
        
        //        self.sceneView.scene.rootNode..addChildNode(cylinderNode)
        
    }
    
    @IBAction func reset(_ sender: UIButton) {
        restartSession()
    }
    
    func restartSession() {
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateHierarchy { (node, _) in
            node.removeFromParentNode()
        }
        
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNumb: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNumb) + min(firstNum, secondNumb)
    }
    
    
}

