//
//  GameViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 9/3/21.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var characterNode: SCNNode!
    var levelNode: SCNNode!

    override func viewDidLoad() {
        setupScene()
        setupNodes()
    }
    
    func setupScene() {
        sceneView = self.view as? SCNView
        assert(sceneView != nil, "SceneView is nil.")
        
        sceneView.delegate = self
        
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        assert(scene != nil, "Scene is nil.")
        
        sceneView.scene = scene
        
        scene.physicsWorld.contactDelegate = self
    }
    
    func setupNodes() {
        characterNode = scene.rootNode.childNode(withName: "character", recursively: true)!
        levelNode = scene.rootNode.childNode(withName: "level", recursively: true)!
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    
}

extension GameViewController: SCNPhysicsContactDelegate {
    
}
