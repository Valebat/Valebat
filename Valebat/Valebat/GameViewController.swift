//
//  GameViewController.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/3/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        ViewConstants.sceneWidth = ViewConstants.sceneHeight * aspectRatio
        let scene = GameScene(size: CGSize(width: ViewConstants.sceneWidth,
                                           height: ViewConstants.sceneHeight))
        scene.scaleMode = .aspectFill

        guard let skView = self.view as? SKView else {
            assertionFailure("View failed to load.")
            return
        }
        skView.showsFPS = true

        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .landscape
    }

}
