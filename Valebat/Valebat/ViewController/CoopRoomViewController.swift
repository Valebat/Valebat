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
    @IBOutlet var playerText: UITextField!
    var refreshTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        roomIDText.text = "ROOM ID: \(roomID)"
        // Do any additional setup after loading the view.
        print(roomID)
        print(username)
        loadPlayerText()
        refreshTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }

    func loadPlayerText() {
        roomManager.fetchRoom(roomCode: roomID) {
            var string = "List Of Players: \n"
            self.roomManager.room?.players.forEach({ string.append($0 + "\n") })
            self.playerText.text = string
        }

    }
    @objc func fireTimer() {
        loadPlayerText()
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
        present(gameVC, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
