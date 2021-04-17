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
