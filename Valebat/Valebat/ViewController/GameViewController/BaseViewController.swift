//
//  BaseViewController.swift
//  Valebat
//
//  Created by Jing Lin Shi on 17/4/21.
//

import UIKit
import SpriteKit
import GameplayKit

class BaseViewController: UIViewController {

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
