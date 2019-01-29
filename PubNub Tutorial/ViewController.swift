//
//  ViewController.swift
//  PubNub Tutorial
//
//  Created by Samba Diallo on 1/28/19.
//  Copyright © 2019 Samba Diallo. All rights reserved.
//

import UIKit
import PubNub // <- Here is our PubNub module import.

class ViewController: UIViewController, PNObjectEventListener {

    
    // Stores reference on PubNub client to make sure what it won't be released.
    var client: PubNub!
    
    @IBOutlet weak var publishLabel: UILabel!
    
    
    @IBAction func publish(_ sender: UIButton) {
        
        self.client.publish("Got message!", toChannel: "my_channel") { (status) in
            if !status.isError{
                print("SUCCESS sending text")
            }else{
                print(status)
            }
        }
    }
    
    func setUpPubNub(){
        // Initialize and configure PubNub client instance
        let configuration = PNConfiguration(publishKey: "pub-c-813bf766-3792-4cf8-97ee-4ff425f25cb0", subscribeKey: "sub-c-b4528510-2292-11e9-8321-261899e2d3ad")
        configuration.stripMobilePayload = false
        self.client = PubNub.clientWithConfiguration(configuration)
        self.client.addListener(self)
        
        // Subscribe to demo channel with presence observation
        self.client.subscribeToChannels(["my_channel"], withPresence: true)
    }
    // Handle new message from one of channels on which client has been subscribed.
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        
        publishLabel.text = message.data.message as? String
        print("Received message: \(message.data.message ?? "default value") on channel \(message.data.channel) " +
            "at \(message.data.timetoken)")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpPubNub()
        
    }
    
    


}

