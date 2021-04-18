//
//  CoopRoomViewController.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/4/21.
//

import UIKit

class CoopRoomViewController: UIViewController {

    @IBOutlet var roomIDText: UITextField!
    var isHost = false
    var roomManager: RoomManager!
    var roomID = ""
    var username = ""

    @IBOutlet var playerText: UITextView!
    var refreshTimer: Timer?
    var locallyStarted = false

    override func viewDidLoad() {
        super.viewDidLoad()
        roomIDText.text = "ROOM ID: \(roomID)"
        loadRoomData()
        refreshTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    func loadRoomData() {
        roomManager.fetchRoom(roomCode: roomID) { [self] in
            var string = "List Of Players: \n"
            self.roomManager.room?.players.forEach({ string.append($0 + "\n") })
            self.playerText.text = string
            if self.roomManager.room?.started ?? false {
                if !self.locallyStarted {
                    self.locallyStarted  = true
                    loadClientGame()
                }
            }
        }
    }

    func loadClientGame() {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "ClientVC")
        viewController.modalPresentationStyle = .fullScreen
        guard let clientVC = viewController as? ClientViewController else {
            return
        }
        clientVC.roomManager = roomManager
        clientVC.clientId = username
        present(clientVC, animated: true, completion: nil)
    }

    @objc func fireTimer() {
        loadRoomData()
    }

    @IBAction func loadNewGame(_ sender: Any) {
        if isHost {
            loadGame(difficulty: .coop)
        }
    }

    func loadGame(difficulty: LevelListTypeEnum) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "GameVC")
        viewController.modalPresentationStyle = .fullScreen
        guard let gameVC = viewController as? GameViewController else {
            return
        }

        gameVC.userConfig = UserConfig(isCoop: true, isNewGame: true, diffLevel: difficulty,
                                       isHost: isHost, roomManager: roomManager)
        if isHost {
            present(gameVC, animated: true, completion: {
                self.roomManager.startRoom {
                }
            })
        }
    }

}
