//
//  CoopViewController.swift
//  Valebat
//
//  Created by Aloysius Lim on 16/4/21.
//

import UIKit

class CoopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func hostRoom(_ sender: Any) {
        let roomManager = RoomManager()
        roomManager.createNewRoom { [self] in
            guard let hostedRoom = roomManager.room else {
                return
            }
            let roomID = hostedRoom.code

            joinRoom(isHost: true, roomID: roomID)
        }
    }

    func joinRoom(isHost: Bool, roomID: String) {
        let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "CoopRoomVC")
        viewController.modalPresentationStyle = .fullScreen
        guard let roomVC = viewController as? CoopRoomViewController else {
            return
        }
        roomVC.isHost = isHost
        roomVC.roomID = roomID
        present(roomVC, animated: true, completion: nil)
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
