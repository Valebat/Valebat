//
//  DifficultyViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 16/4/21.
//

import UIKit

class DifficultyViewController: UIViewController {

    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!

    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameViewController = segue.destination as? GameViewController {
//            let buttonClicked = sender as? NSObject
//            var userConfig = UserConfig(isCoop: false, isNewGame: true)
//            if buttonClicked == newGameButton {
//                userConfig.isCoop = false
//                userConfig.isNewGame = true
//            } else if buttonClicked == resumeGameButton {
//                userConfig.isCoop = false
//                userConfig.isNewGame = false
//            }
        }
    }

    override var shouldAutorotate: Bool {
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
      return .landscape
    }

}
