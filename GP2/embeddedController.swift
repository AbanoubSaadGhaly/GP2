//
//  embeddedController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/4/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit
import Firebase
class embeddedController: UIViewController {

   //button outlets
 
    @IBOutlet weak var roomOne: UILabel!
    @IBOutlet weak var lampRoomOne: UIButton!
    @IBOutlet weak var cameraRoomOne: UIButton!
    @IBOutlet weak var fanOne: UILabel!
    
   
    @IBOutlet weak var roomTwo: UILabel!
    @IBOutlet weak var lampRoomTwo: UIButton!
    @IBOutlet weak var cameraRoomTwo: UIButton!
    @IBOutlet weak var fanTwo: UILabel!
    
   
    @IBOutlet weak var salon: UILabel!
    @IBOutlet weak var lampSalon: UIButton!
    @IBOutlet weak var cameraSalon: UIButton!
    @IBOutlet weak var fanSalon: UILabel!
    
    @IBOutlet weak var door: UILabel!
    @IBOutlet weak var openCloseDoor: UIButton!
    @IBOutlet weak var cameraDoor: UIButton!
   
    
    @IBOutlet weak var notifications: UILabel!
    @IBOutlet weak var sensorWarnings: UILabel!
    
    //Button actions
    //flags
    var flag0 = 1
    var flag1 = 1
    var flag2 = 1

    @IBAction func lampRoom1(_ sender: UIButton) {
        
        if (flag0 == 1){
            room1Light(state: "010101")
            flag0 = 0
        }
        else if (flag0 == 0){
            room1Light(state: "101010")
            flag0 = 1
        }
        
        
    }
    
    
    @IBAction func cameraRoom1(_ sender: UIButton) {
   
        
        if (flag1 == 1){
            room1Fan (state: "010101")

            flag1 = 0
        }
        else if (flag1 == 0){
            room1Fan (state: "101010")

            flag1 = 1
        }
        
        
    }
    
    
    @IBAction func fanRoom1(_ sender: UISlider) {
        
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room1Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room1Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room1Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room1Fan (state: "101001")
        }
        
    }
    
    
  
    
    
    @IBAction func lampRoom2(_ sender: UIButton){
    }
    
    
    @IBAction func cameraRoom2(_ sender: UIButton) {
    }
    
    
    @IBAction func fanRoom2(_ sender: UISlider) {
    }
    
    
    
  
    
    
    @IBAction func lampSalon(_ sender: UIButton) {
    }
    
    
    @IBAction func cameraSalon(_ sender: UIButton) {
    }
    
    
    @IBAction func fanSalon(_ sender: UISlider) {
    }
    
    
    
    
    @IBAction func openCloseDoor(_ sender: UIButton) {
    }
    
    
    @IBAction func cameraDoor(_ sender: UIButton) {
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //shaping the buttons
        self.applyRoundCorner(lampRoomOne)
        self.applyRoundCorner(cameraRoomOne)
       
        
        self.applyRoundCorner(lampRoomTwo)
        self.applyRoundCorner(cameraRoomTwo)
        
       
        self.applyRoundCorner(lampSalon)
        self.applyRoundCorner(cameraSalon)
       
       
        self.applyRoundCorner(openCloseDoor)
        self.applyRoundCorner(cameraDoor)
        self.applyRoundCorner(sensorWarnings)

        roomOne.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "YzQ-if-bXT.text" , comment: " ")
        lampRoomOne.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomOne.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanOne.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        roomTwo.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NSN-0q-GoP.text" , comment: " ")
        lampRoomTwo.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomTwo.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanTwo.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        salon.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "yEk-r9-re3.text" , comment: " ")
        lampSalon.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraSalon.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanSalon.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        door.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key:"hgV-tR-k1g.text", comment: " ")
        openCloseDoor.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "E9f-eH-9S4.normalTitle", comment: " "), for: .normal)
        cameraDoor.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        
        
        
        notifications.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "1CW-A6-L6f.text", comment: " ")
         sensorWarnings.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "iQS-VN-0D6.text", comment: " ")
    }
    
    func applyRoundCorner(_ object: AnyObject){
        
        object.layer.cornerRadius = object.frame.height / 2
        object.layer.masksToBounds = true
    }
  func room1Light (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Room1").child("Light").setValue(post)
        
    
    }
    func room1Fan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Room1").child("Fan").setValue(post)
          //let post2 : [String : AnyObject] = ["Fan" :state as AnyObject]
        // ref.child("Room1").setValue(post2)
    }

    
}
    
    

