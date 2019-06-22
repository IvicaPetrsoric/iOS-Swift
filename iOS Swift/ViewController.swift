//
//  ViewController.swift
//  iOS Swift
//
//  Created by ivica petrsoric on 21/06/2019.
//  Copyright © 2019 ivica petrsoric. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    var trackerNode: SCNNode!
    var dice1Node: SCNNode!
    var dice2Node: SCNNode!
    var trackingPosition = SCNVector3Make(0, 0, 0)
    var started = false
    var foundSurface = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/dice.scn")!
        
        // Set the scene to the view
        sceneView.scene = scene
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func rollDice(dice: SCNNode) {
        if dice.physicsBody == nil {
            dice.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        }
        
        dice.physicsBody?.applyForce(SCNVector3Make(0.0, 3.0, 0.0), asImpulse: true)
        dice.physicsBody?.applyTorque(SCNVector4Make(0.5, 0.5, 0.5, 0.075), asImpulse: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if foundSurface {
            if started {
                // dice rolling
                rollDice(dice: dice1Node)
                rollDice(dice: dice2Node)
            } else {
                started = true
                
                trackerNode.removeFromParentNode()
                
                let floorPlane = SCNPlane(width: 50, height: 50)
                floorPlane.firstMaterial?.diffuse.contents = UIColor.clear
                
                let floorNode = SCNNode(geometry: floorPlane)
                floorNode.position = trackingPosition
                floorNode.eulerAngles.x = -.pi * 0.5
                
                sceneView.scene.rootNode.addChildNode(floorNode)
                floorNode.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
                
                guard let dice = sceneView.scene.rootNode.childNode(withName: "dice", recursively: false) else { return }
                dice1Node = dice
                dice1Node.position = SCNVector3Make(trackingPosition.x, trackingPosition.y, trackingPosition.z)
                dice1Node.isHidden = false
                
                dice2Node = dice1Node.clone()
                dice2Node.position.x = trackingPosition.x + 0.4
                
                sceneView.scene.rootNode.addChildNode(dice2Node)
            }
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard !started else { return }
        DispatchQueue.main.async { [weak self] in
            guard let hitTest = self?.sceneView.hitTest(CGPoint(x: (self?.view.frame.midX)!, y: (self?.view.frame.midY)!), types: [.existingPlane, .featurePoint]).first else { return }
            
            let trans = SCNMatrix4(hitTest.worldTransform)
            
            self?.setSurface(trans: trans)
        }
        
        
        //        trackingPosition = SCNVector3Make(trans.m41, trans.m42, trans.m43)
        //
        //        if !foundSurface {
        //            foundSurface = true
        //
        //            let trackerPlane = SCNPlane(width: 0.2, height: 0.2)
        //            trackerPlane.firstMaterial?.diffuse.contents = UIColor.red
        //            trackerPlane.firstMaterial?.isDoubleSided = true
        //
        //            trackerNode = SCNNode(geometry: trackerPlane)
        //            trackerNode.eulerAngles.x = -.pi * 0.5
        //
        //            sceneView.scene.rootNode.addChildNode(trackerNode)
        //        }
        //
        //        trackerNode.position = trackingPosition
    }
    
    private func setSurface(trans: SCNMatrix4) {
        trackingPosition = SCNVector3Make(trans.m41, trans.m42, trans.m43)
        
        if !foundSurface {
            foundSurface = true
            
            let trackerPlane = SCNPlane(width: 0.2, height: 0.2)
            trackerPlane.firstMaterial?.diffuse.contents = UIColor.red
            trackerPlane.firstMaterial?.isDoubleSided = true
            
            trackerNode = SCNNode(geometry: trackerPlane)
            trackerNode.eulerAngles.x = -.pi * 0.5
            
            sceneView.scene.rootNode.addChildNode(trackerNode)
        }
        
        trackerNode.position = trackingPosition
    }
    
    
}
