//
//  GameViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 9/3/21.
//

import Foundation
import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
    var sceneView: SCNView!
    var scene: SCNScene!
    
    var characterNode: SCNNode!
    var levelNode: SCNNode!
    var cameraNode: SCNNode!
    var mapObjectNodes: [MapObjectEnum:SCNNode] = [:]

    override func viewDidLoad() {
        setupScene()
        setupNodes()
    }
    
    func setupScene() {
        sceneView = self.view as? SCNView
        assert(sceneView != nil, "SceneView is nil.")
        
        sceneView.delegate = self
        sceneView.isPlaying = true
        sceneView.preferredFramesPerSecond = 60
        
        scene = SCNScene(named: "art.scnassets/MainScene.scn")
        assert(scene != nil, "Scene is nil.")
        
        sceneView.scene = scene
        
        scene.physicsWorld.contactDelegate = self
    }
    
    func setupNodes() {
        characterNode = scene.rootNode.childNode(withName: "character", recursively: true)!
        levelNode = scene.rootNode.childNode(withName: "level", recursively: true)!
        cameraNode = scene.rootNode.childNode(withName: "camera", recursively: true)!
        
        let rockNode = scene.rootNode.childNode(withName: "rock", recursively: true)!
        mapObjectNodes[MapObjectEnum.ROCK] = rockNode
        
        let map = TestConstants.TEST_MAP
        
        for mObj in map.objects {
            let node = MapUtil.createNodeFromObject(mObj, nodeMap: mapObjectNodes)
            scene.rootNode.addChildNode(node)
        }
        
        // These nodes function as nodes to clone from, so we hide the originals.
        for node in mapObjectNodes.values {
            node.isHidden = true
        }
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension GameViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        let character = characterNode.presentation
        var characterPosition = character.position
        
        let targetPosition = SCNVector3(x: characterPosition.x, y: ViewConstants.CAMERA_HEIGHT, z: characterPosition.z)
        var cameraPosition = cameraNode.position
        
        let xCam = cameraPosition.x * (1.0 - ViewConstants.CAMERA_DAMPING)
            + targetPosition.x * ViewConstants.CAMERA_DAMPING
        let zCam = cameraPosition.z * (1.0 - ViewConstants.CAMERA_DAMPING)
            + targetPosition.z * ViewConstants.CAMERA_DAMPING
        
        cameraPosition = SCNVector3(x: xCam, y: ViewConstants.CAMERA_HEIGHT, z: zCam)
        cameraNode.position = cameraPosition
        
        let xCha = characterPosition.x + ((Float(arc4random()) / Float(UINT32_MAX)) * 0.1)
        let yCha = characterPosition.y
        let zCha = characterPosition.z + ((Float(arc4random()) / Float(UINT32_MAX)) * 0.1)
        
        characterPosition = SCNVector3(x: xCha, y: yCha, z: zCha)
        characterNode.position = characterPosition
    }
}

extension GameViewController: SCNPhysicsContactDelegate {
    
}
