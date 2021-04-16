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
    var roomID = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        roomIDText.text = "ROOM ID: \(roomID)"
        // Do any additional setup after loading the view.
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
