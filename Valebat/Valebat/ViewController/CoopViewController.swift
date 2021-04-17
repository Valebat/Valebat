//
//  CoopViewController.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/4/21.
//

import UIKit

class CoopViewController: UIViewController {
    var roomManager = RoomManager()
    var usernameManager = UsernameManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func joinRoomButton(_ sender: Any) {
        let alert = UIAlertController(title: "Join Room", message: "Enter a room ID", preferredStyle: .alert)

        // 2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = ""
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            if let roomID = alert?.textFields?[0].text {
                print(roomID)
                self.joinRoom(isHost: false, roomID: roomID)
            } // Force unwrapping because we know it exists.

        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func hostRoom(_ sender: Any) {
        roomManager.setupNewRoom { [self] in
            guard let hostedRoom = roomManager.room else {
                return
            }
            let roomID = hostedRoom.code

            joinRoom(isHost: true, roomID: roomID)
        }
    }

//    @IBAction func joinRoom(_ sender: Any) {
//        joinRoom(isHost: false, roomID: "just for testing clientVC")
//    }

    func joinRoom(isHost: Bool, roomID: String) {
        usernameManager.setupUser { [self] in
            guard let username = usernameManager.username else {
                return
            }

            roomManager.joinRoom(username: username.username, roomCode: roomID) {

                let viewController = UIStoryboard(name: "Main", bundle: nil)
                    .instantiateViewController(identifier: "CoopRoomVC")
                viewController.modalPresentationStyle = .fullScreen
                guard let roomVC = viewController as? CoopRoomViewController else {
                    return
                }
                roomVC.isHost = isHost
                roomVC.roomID = roomID
                roomVC.roomManager = roomManager
                roomVC.username = username.username
                present(roomVC, animated: true, completion: nil)

            }
        }
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
