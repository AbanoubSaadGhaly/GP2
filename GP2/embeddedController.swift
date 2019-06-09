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

   
    @IBOutlet weak var lampRoomOne: UIButton!
    @IBOutlet weak var cameraRoomOne: UIButton!
    @IBOutlet weak var fanRoomOne: UIButton!
    @IBOutlet weak var fanOneLabel: UILabel!
    @IBOutlet weak var lampRoomTwo: UIButton!
    @IBOutlet weak var cameraRoomTwo: UIButton!
    @IBOutlet weak var fanRoomTwo: UIButton!
    @IBOutlet weak var fanTwoLabel: UILabel!
    @IBOutlet weak var lampSalon: UIButton!
    @IBOutlet weak var cameraSalon: UIButton!
    @IBOutlet weak var fanSalon: UIButton!
    @IBOutlet weak var fanSalonLabel: UILabel!
    @IBOutlet weak var openCloseDoor: UIButton!
    @IBOutlet weak var cameraDoor: UIButton!
    @IBOutlet weak var sensorWarnings: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  //shaping the buttons
        self.applyRoundCorner(lampRoomOne)
        self.applyRoundCorner(cameraRoomOne)
        self.applyRoundCorner(fanRoomOne)
        self.applyRoundCorner(fanOneLabel)
        
        self.applyRoundCorner(lampRoomTwo)
        self.applyRoundCorner(cameraRoomTwo)
        self.applyRoundCorner(fanRoomTwo)
        self.applyRoundCorner(fanTwoLabel)
       
        self.applyRoundCorner(lampSalon)
        self.applyRoundCorner(cameraSalon)
        self.applyRoundCorner(fanSalon)
        self.applyRoundCorner(fanSalonLabel)
       
        self.applyRoundCorner(openCloseDoor)
        self.applyRoundCorner(cameraDoor)
        self.applyRoundCorner(sensorWarnings)


    }
    
    func applyRoundCorner(_ object: AnyObject){
        
        object.layer.cornerRadius = object.frame.height / 2
        object.layer.masksToBounds = true
    }


}
