//
//  GameViewController.swift
//  Valebat
//
//  Created by Aloysius Lim on 13/3/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: BaseViewController {

    var currentScene: GameScene?
    var userConfig: UserConfig?

    override func viewDidLoad() {
        super.viewDidLoad()
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        guard let userConfig = self.userConfig else {
            return
        }

        let aspectRatio = view.bounds.size.width / view.bounds.size.height
        ViewConstants.sceneWidth = ViewConstants.sceneHeight * aspectRatio
        let gameScene = GameScene(size: CGSize(width: ViewConstants.sceneWidth,
                                           height: ViewConstants.sceneHeight),
                                  userConfig: userConfig)
        self.currentScene = gameScene
        currentScene?.viewController = self

        gameScene.scaleMode = .aspectFill

        guard let skView = self.view as? SKView else {
            assertionFailure("View failed to load.")
            return
        }
        skView.showsFPS = true

        skView.presentScene(gameScene)

    }

}
