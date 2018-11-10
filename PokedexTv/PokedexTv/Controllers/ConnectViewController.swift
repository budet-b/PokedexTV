//
//  ConnectViewController.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 09/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MultipeerService.shared.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ConnectButtonPressed(_ sender: Any) {
        MultipeerService.shared.start(false)
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

extension ConnectViewController: MultipeerServiceDelegate {
    func lostConnectedPeer(with name: String) {
        print("lost")
    }
    
    func found(peer name: String) {
        print("Found: \(name)")
        MultipeerService.shared.tryToConnect(to: name)
    }
    
    func receive(code: String) {
        print("Receive: \(code)")
    }
    
    func peerDidConnect(with name: String) {
        print("\(name)")
    }
}
