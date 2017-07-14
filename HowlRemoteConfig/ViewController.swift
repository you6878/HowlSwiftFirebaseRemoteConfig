//
//  ViewController.swift
//  HowlRemoteConfig
//
//  Created by 유명식 on 2017. 7. 14..
//  Copyright © 2017년 swift. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var remoteConfg :FIRRemoteConfig!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remoteConfg = FIRRemoteConfig.remoteConfig()
        remoteConfg.setDefaultsFromPlistFileName("FireSwiftRemoteConfigDefaults")
        
        
        fetchConfig()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchConfig(){
        
        let remoteConfigsettings = FIRRemoteConfigSettings(developerModeEnabled: true)
        remoteConfg.configSettings = remoteConfigsettings!
        
        remoteConfg.fetch(withExpirationDuration: 0) { (status, error) in
            
            
            if status == .success{
                self.remoteConfg.activateFetched()
            }
            self.displayMessage()
        }
        
        
        
    }
    
    func displayMessage(){
        let message = remoteConfg["welcome_message"].stringValue
        let caps = remoteConfg["welcome_message_caps"].boolValue
        let color = remoteConfg["backgroundColor"].numberValue
        
        
        if(caps){
            
            let alert = UIAlertController(title: "공지사항", message: message, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (action) in
                exit(0)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        if(color == 1){
            self.view.backgroundColor = UIColor.black
        }
        
        
        
        
        
        
        
        
    }
    
    
}

