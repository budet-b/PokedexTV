//
//  ConnectViewController.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 09/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {
    
    @IBOutlet weak var detectedDeviceTableView: UITableView!
    @IBOutlet weak var statusConnection: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        MultipeerService.shared.delegate = self
        detectedDeviceTableView.delegate = self
        detectedDeviceTableView.dataSource = self
        statusConnection.text = "Not Connected"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ConnectButtonPressed(_ sender: Any) {
        MultipeerService.shared.start(false)
        statusConnection.text = "Scanning..."
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

extension ConnectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MultipeerService.shared.foundPeerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! UITableViewCell
        cell.textLabel?.text = "\(MultipeerService.shared.foundPeerArray[indexPath.row].displayName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MultipeerService.shared.tryToConnect(to: "\(MultipeerService.shared.foundPeerArray[indexPath.row].displayName)")
    }
}

extension ConnectViewController: MultipeerServiceDelegate {
    func updatePeers() {
        self.detectedDeviceTableView.reloadData()
    }
    
    func lostConnectedPeer(with name: String) {
        print("lost \(name)")
        //MultipeerService.shared.tryToConnect(to: name)
    }
    
    func found(peer name: String) {
        print("Found: \(name)")
    }
    
    func receive(code: String) {
        print("Receive: \(code)")
        self.resultLabel.text = code
    }
    
    func peerDidConnect(with name: String) {
        print("\(name)")
        DispatchQueue.main.async { // Correct
            self.statusConnection.text = "Connected to \(name)"
        }
        let al = UIAlertController.init(title: "Connect", message: "Connected to \(name)", preferredStyle: .alert)
        let aler = UIAlertAction(title: "ok", style: .default, handler: nil)
        al.addAction(aler)
        self.present(al, animated: true, completion: nil)
        
        
    }
}
