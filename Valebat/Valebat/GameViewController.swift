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

        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        let scene = GameScene(size: CGSize(width: 640 * aspectRatio, height: 640))
        scene.scaleMode = .aspectFill

        guard let skView = self.view as? SKView else {
            assertionFailure("View failed to load.")
            return
        }
        skView.showsFPS = true

        skView.presentScene(scene)
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
