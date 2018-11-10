//
//  MultipeerService.swift
//
//  Created by Cédric EUGENI on 11/04/2018.
//

import MultipeerConnectivity

public class MultipeerService: NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {
    
    // *********************************************************************
    // MARK: - Properties
    
    private static let serviceType = "stc-class-vip"
    public static let shared = MultipeerService()
    
    private let localPeerId: MCPeerID
    private var localSession: MCSession?
    private var foundPeerArray: [MCPeerID] = []
    
    private var localBrowser: MCNearbyServiceBrowser?
    private var localAdvertiser: MCNearbyServiceAdvertiser?
    
    public weak var delegate: MultipeerServiceDelegate?
    
    // *********************************************************************
    // MARK: - Methods
    
    override init() {
        self.localPeerId = MCPeerID(displayName: String(UIDevice.current.name.prefix(63)))
        super.init()
    }
    
    deinit {
        self.stop()
    }
    
    public func start(_ isMaster: Bool) {
        guard localSession == nil else { return }
        
        localSession = MCSession(peer: localPeerId, securityIdentity: nil, encryptionPreference: .optional)
        localSession?.delegate = self
        
        if isMaster {
            guard localAdvertiser == nil else { return }
            
            localAdvertiser = MCNearbyServiceAdvertiser(peer: localPeerId, discoveryInfo: [:], serviceType: MultipeerService.serviceType)
            localAdvertiser?.delegate = self
            localAdvertiser?.startAdvertisingPeer()
        } else {
            guard localBrowser == nil else { return }
            
            localBrowser = MCNearbyServiceBrowser(peer: localPeerId, serviceType: MultipeerService.serviceType)
            localBrowser?.delegate = self
            localBrowser?.startBrowsingForPeers()
            print(foundPeerArray)
        }
    }
    
    public func stopBrowseAdvertise() {
        localBrowser?.stopBrowsingForPeers()
        localAdvertiser?.stopAdvertisingPeer()
        localAdvertiser = nil
        localBrowser = nil
        foundPeerArray = []
    }
    
    public func stop() {
        localSession?.disconnect()
        localSession = nil
        stopBrowseAdvertise()
    }
    
    public func send(message: MultipeerMessage, to peers: [String]) {
        let tPeers: [MCPeerID] = (localSession?.connectedPeers ?? []).filter { (peer) -> Bool in
            return peers.contains(peer.displayName)
        }
        
        do {
            let jsonData = try JSONEncoder().encode(message)
            
            try localSession?.send(jsonData, toPeers: tPeers, with: .reliable)
        } catch {
            debugPrint("serialization for multipeer should work")
        }
    }
    
    public func tryToConnect(to peerName: String) {
        let peer: MCPeerID? = foundPeerArray.first { (p) -> Bool in
            p.displayName == peerName
        }
        
        guard let p = peer, let lSession = self.localSession else { return }
        
        localBrowser?.invitePeer(p, to: lSession, withContext: nil, timeout: 10000)
    }
    
    // *********************************************************************
    // MARK: - MCSessionDelegate
    
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        
        if let message = try? JSONDecoder().decode(MultipeerMessage.self, from: data) {
            switch message.type {
            case .sendCode:
                if let str: String = message.content {
                    delegate?.receive(code: str)
                }
            default:
                break
            }
        }
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        //Not used in this app
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        //Not used in this app
    }
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        //Not used in this app
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case .connected:
            delegate?.peerDidConnect(with: peerID.displayName)
        case .connecting:
            break
        case .notConnected:
            delegate?.lostConnectedPeer(with: peerID.displayName)
        }
    }
    
    public func session(_ session: MCSession, didReceiveCertificate certificate: [Any]?, fromPeer peerID: MCPeerID, certificateHandler: @escaping (Bool) -> Void) {
        certificateHandler(true)
    }
    
    // *********************************************************************
    // MARK: - MCNearbyServiceAdvertiserDelegate
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("adv")
        
    }
    
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, localSession)
    }
    
    // *********************************************************************
    // MARK: - MCNearbyServiceBrowserDelegate
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        foundPeerArray.append(peerID)
        delegate?.found(peer: peerID.displayName)
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        delegate?.lost(foundPeer: peerID.displayName)
        foundPeerArray = foundPeerArray.filter({ (peer) -> Bool in
            return peer != peerID
        })
    }
}

public protocol MultipeerServiceDelegate: class {
    func receive(code: String)
    func found(peer name: String)
    func lost(foundPeer name: String)
    func peerDidConnect(with name: String)
    func lostConnectedPeer(with name: String)
}

public extension MultipeerServiceDelegate {
    func receive(code: String) { }
    func found(peer name: String) { }
    func lost(foundPeer name: String) { }
    func peerDidConnect(with name: String) { }
}


public enum MultipeerMessageType: Int, Codable {
    case sendCode
    case unknown
    
    public init(from decoder: Decoder) throws {
        self = MultipeerMessageType(rawValue: try decoder.singleValueContainer().decode(Int.self)) ?? .unknown
    }
}

open class MultipeerMessage: Codable {
    
    // *********************************************************************
    // MARK: - Properties
    
    public let type: MultipeerMessageType
    public let content: String?
    
    // *********************************************************************
    // MARK: - Parsing
    
    // Useless because all parameters have same name as JSON file
    // enum CodingKeys: String, CodingKey {}
    
    // *********************************************************************
    // MARK: - Methods
    
    public init(type: MultipeerMessageType, content: String? = nil) {
        self.type = type
        self.content = content
    }
    
}
