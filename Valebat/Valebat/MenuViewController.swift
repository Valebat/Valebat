//
//  MenuViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 8/4/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var resumeGameButton: UIButton!
    @IBOutlet weak var coopModeButton: UIButton!

    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameViewController = segue.destination as? GameViewController
        let buttonClicked = sender as? NSObject
        gameViewController?.isNewGame = true
        if buttonClicked == newGameButton {
            gameViewController?.isNewGame = true
            gameViewController?.isCoop = false
        } else if buttonClicked == resumeGameButton {
            gameViewController?.isNewGame = false
            gameViewController?.isCoop = false
        } else if buttonClicked == coopModeButton {
            gameViewController?.isNewGame = false
            gameViewController?.isCoop = true
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
