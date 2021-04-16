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

    @IBAction func resumeGame(_ sender: Any) {
        loadGame(config: UserConfig.resumeGame())
    }

    @IBAction func coopGame(_ sender: Any) {
        loadGame(config: UserConfig(isCoop: true, isNewGame: true, diffLevel: .medium))
    }
    func loadGame(config: UserConfig) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "GameVC")
        viewController.modalPresentationStyle = .fullScreen
        guard let gameVC = viewController as? GameViewController else {
            return
        }
        gameVC.userConfig = config
        present(gameVC, animated: true, completion: nil)
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
