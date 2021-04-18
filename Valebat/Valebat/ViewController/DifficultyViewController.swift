//
//  DifficultyViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 16/4/21.
//

import UIKit

class DifficultyViewController: UIViewController {

    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    @IBAction func loadEasyGame(_ sender: Any) {
        loadGame(difficulty: .easy)
    }

    @IBAction func loadNormalGame(_ sender: Any) {
        loadGame(difficulty: .medium)
    }

    @IBAction func loadHardGame(_ sender: Any) {
        loadGame(difficulty: .hard)
    }

    func loadGame(difficulty: LevelListTypeEnum) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "GameVC")
        viewController.modalPresentationStyle = .fullScreen
        guard let gameVC = viewController as? GameViewController else {
            return
        }
        gameVC.userConfig = UserConfig(isCoop: false, isNewGame: true, diffLevel: difficulty)
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
