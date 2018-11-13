//
//  ConnectViewController.swift
//  PokedexTv
//
//  Created by Benjamin_Budet on 09/11/2018.
//  Copyright © 2018 Benjamin Budet. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController {
    
    var pokemonRes: PokemonArena?
    
    @IBOutlet weak var detectedDeviceTableView: UITableView!
    @IBOutlet weak var statusConnection: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var shinyLabel: UILabel!
    @IBOutlet weak var attacksTableView: UITableView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    // Holders
    @IBOutlet weak var nickameTextLabel: UILabel!
    @IBOutlet weak var levelTextLabel: UILabel!
    @IBOutlet weak var shinyTextLabel: UILabel!
    @IBOutlet weak var attacksTextLabel: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MultipeerService.shared.delegate = self
        detectedDeviceTableView.delegate = self
        detectedDeviceTableView.dataSource = self
        attacksTableView.delegate = self
        attacksTableView.dataSource = self

        attacksTableView.isHidden = true
        nickameTextLabel.isHidden = true
        levelTextLabel.isHidden = true
        attacksTextLabel.isHidden = true
        nicknameLabel.isHidden = true
        type1Label.isHidden = true
        type2Label.isHidden = true
        levelLabel.isHidden = true
        shinyLabel.isHidden = true
        shinyTextLabel.isHidden = true
        resultLabel.isHidden = true
        
        statusConnection.text = "Not Connected"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ConnectButtonPressed(_ sender: Any) {
        MultipeerService.shared.start(false)
        statusConnection.text = "Scanning..."
    }
    
    func UpdateUi() {
        attacksTableView.isHidden = false
        nickameTextLabel.isHidden = false
        levelTextLabel.isHidden = false
        attacksTextLabel.isHidden = false
        nicknameLabel.isHidden = false
        type1Label.isHidden = false
        type2Label.isHidden = false
        levelLabel.isHidden = false
        shinyLabel.isHidden = false
        shinyTextLabel.isHidden = false
        resultLabel.isHidden = false
        resultLabel.text = "\(pokemonRes?.species.name ?? "no name")"
        pokemonImage.sd_setImage(with: URL(string: "http://pokedex-mti.twitchytv.live/images/\(pokemonRes?.species.id ?? 1).png"), placeholderImage: UIImage(named: "pokeball"))
        if let nick = pokemonRes?.nickname {
            nicknameLabel.text = nick
        } else {
            nicknameLabel.text = nil
            nickameTextLabel.text = nil
        }
        shinyLabel.text = "\(pokemonRes?.shiny ?? false)"
        type1Label.backgroundColor = getColorFromType(type: pokemonRes?.species.type1.id ?? 1)
        type1Label.text = pokemonRes?.species.type1.name
        type1Label.layer.cornerRadius = type1Label.frame.size.height / 2
        type1Label.clipsToBounds = true
        type1Label.textColor = UIColor.white
        levelLabel.text = "\(pokemonRes?.level ?? 1)"
        if let type2 = pokemonRes?.species.type2 {
            type2Label.backgroundColor = getColorFromType(type: type2.id)
            type2Label.text = type2.name
            type2Label.layer.cornerRadius = type2Label.frame.size.height / 2
            type2Label.clipsToBounds = true
            type2Label.textColor = UIColor.white
        } else {
            type2Label.text = ""
            type2Label.backgroundColor = UIColor.clear
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
    }
    
    func found(peer name: String) {
        print("Found: \(name)")
    }
    
    func receive(code: PokemonArena) {
        print("Receive: \(code)")
        DispatchQueue.main.async {
            self.pokemonRes = code
            self.UpdateUi()
        }
    }
    
    func peerDidConnect(with name: String) {
        print("\(name)")
        DispatchQueue.main.async {
            self.statusConnection.text = "Connected to \(name)"
        }
        let al = UIAlertController.init(title: "Connect", message: "Connected to \(name)", preferredStyle: .alert)
        let aler = UIAlertAction(title: "ok", style: .default, handler: nil)
        al.addAction(aler)
        self.present(al, animated: true, completion: nil)
        
        
    }
}
