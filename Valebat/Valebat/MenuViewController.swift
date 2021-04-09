//
//  MenuViewController.swift
//  Valebat
//
//  Created by Zhang Yifan on 8/4/21.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var newGameButton: UIImageView!

    override func viewDidLoad() {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")

        let newGameTapGesture = UITapGestureRecognizer(target: self, action: #selector(newGameTapped))
        newGameButton.addGestureRecognizer(newGameTapGesture)
        newGameButton.isUserInteractionEnabled = true
    }

    @objc func newGameTapped(gesture: UIGestureRecognizer) {
        print("hey")
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
