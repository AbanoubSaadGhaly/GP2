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

/*************************************************buttons & label outlets*************************************************************************************************/
    

    @IBOutlet weak var roomOne: UILabel!
    @IBOutlet weak var lampRoomOne: UIButton!
    @IBOutlet weak var cameraRoomOne: UIButton!
    @IBOutlet weak var fanOne: UILabel!
    @IBOutlet weak var fanRoomOne: UISlider!
    
   
    @IBOutlet weak var roomTwo: UILabel!
    @IBOutlet weak var lampRoomTwo: UIButton!
    @IBOutlet weak var cameraRoomTwo: UIButton!
    @IBOutlet weak var fanTwo: UILabel!
    @IBOutlet weak var fanRoomTwo: UISlider!
    
    
    @IBOutlet weak var roomThree: UILabel!
    @IBOutlet weak var lampRoomThree: UIButton!
    @IBOutlet weak var cameraRoomThree: UIButton!
    @IBOutlet weak var fanThree: UILabel!
    @IBOutlet weak var fanRoomThree: UISlider!
    
    
    @IBOutlet weak var roomFour: UILabel!
    @IBOutlet weak var lampRoomFour: UIButton!
    @IBOutlet weak var cameraRoomFour: UIButton!
    @IBOutlet weak var fanFour: UILabel!
    @IBOutlet weak var fanRoomFour: UISlider!
    
    
    
    @IBOutlet weak var roomFive: UILabel!
    @IBOutlet weak var lampRoomFive: UIButton!
    @IBOutlet weak var cameraRoomFive: UIButton!
    @IBOutlet weak var fanFive: UILabel!
    @IBOutlet weak var fanRoomFive: UISlider!
    
    
    @IBOutlet weak var salon: UILabel!
    @IBOutlet weak var lampSalon: UIButton!
    @IBOutlet weak var cameraSalon: UIButton!
    @IBOutlet weak var fanSalon: UILabel!
    @IBOutlet weak var fanInSalon: UISlider!
    
    
    @IBOutlet weak var door: UILabel!
    @IBOutlet weak var openCloseDoor: UIButton!
    @IBOutlet weak var cameraDoor: UIButton!
   
    
    @IBOutlet weak var notifications: UILabel!
    @IBOutlet weak var sensorWarnings: UILabel!
    
    
    @IBOutlet weak var settingForRooms: UIButton!
    @IBOutlet weak var rm2: UIButton!
    @IBOutlet weak var rm3: UIButton!
    @IBOutlet weak var rm4: UIButton!
    
    /************************************************************************************************************************************************************************/
    

    //Button actions
    //flags
    var flag0 = 1
    var flag1 = 1
    var flag2 = 1
    var flag3 = 1
    var flag4 = 1
    var flag5 = 1
    var flag6 = 1
    var flag7 = 1
    override func viewWillAppear (_ animated: Bool){
rm2.isHidden = true
    rm3.isHidden = true
    rm4.isHidden = true
    
    
    
    }
        
       
    
@IBAction func settings(_ sender: UIButton) {
        if (flag7 == 1){
         rm2.isHidden = false
              rm3.isHidden = false
              rm4.isHidden = false
        }
   
        }
    
    @IBAction func tworom(_ sender: UIButton) {
        twoRoom()
        rm2.isHidden = true
        rm3.isHidden = true
        rm4.isHidden = true
    }
    
    @IBAction func threerom(_ sender: Any) {
        threeRoom()
        rm2.isHidden = true
        rm3.isHidden = true
        rm4.isHidden = true
    }
    
    @IBAction func fourrom(_ sender: UIButton) {
        fourRoom()
        rm2.isHidden = true
        rm3.isHidden = true
        rm4.isHidden = true
    }
    /************************************************************************************************************************************************************************/
    

    

    

    
/****************************************buttons action to control lamps & fans & door***********************************************************************************/
    

    
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

    
    
    @IBAction func fanRoom1(_ sender: UISlider) {
        
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room1Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room1Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room1Fan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room1Fan (state: "1010220")
        }
        
    }
    
    
  
    
    
    @IBAction func lampRoom2(_ sender: UIButton){
        if (flag1 == 1){
            room2Light(state: "010101")
            flag1 = 0
        }
        else if (flag1 == 0){
            room2Light(state: "101010")
            flag1 = 1
        }
        
    }
 
    
    
    @IBAction func fanRoom2(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room2Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room2Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room2Fan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room2Fan (state: "1010220")
        }
    }
    
    
    
    @IBAction func lampRoom3(_ sender: UIButton) {
        if (flag2 == 1){
            room3Light(state: "010101")
            flag2 = 0
        }
        else if (flag2 == 0){
            room3Light(state: "101010")
            flag2 = 1
        }
        
    }

    
    
    @IBAction func fanRoom3(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room3Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room3Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room3Fan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room3Fan (state: "1010220")
        }
    }
    
    
    
    
    @IBAction func lampRoom4(_ sender: UIButton) {
        if (flag3 == 1){
            room4Light(state: "010101")
            flag3 = 0
        }
        else if (flag3 == 0){
            room4Light(state: "101010")
            flag3 = 1
        }
        
    }
 
    
    
    @IBAction func fanRoom4(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room4Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room4Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room4Fan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room4Fan (state: "1010220")
        }
    }
    
    
    
    
    @IBAction func lampRoom5(_ sender: UIButton) {
        if (flag4 == 1){
            room5Light(state: "010101")
            flag4 = 0
        }
        else if (flag4 == 0){
            room5Light(state: "101010")
            flag4 = 1
        }
        
    }
 
    
    
    @IBAction func fanRoom5(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   room5Fan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   room5Fan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   room5Fan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   room5Fan (state: "1010220")
        }
    }
    
    
    
    
    
    @IBAction func lampSalon(_ sender: UIButton) {
        if (flag5 == 1){
            salonLight(state: "010101")
            flag5 = 0
        }
        else if (flag5 == 0){
            salonLight(state: "101010")
            flag5 = 1
        }
        
    }
 
    
    
    @IBAction func fanSalon(_ sender: UISlider) {
        let currentValue = Float(sender.value)
        if (currentValue <= Float(0.25) && currentValue >= Float(0.0))
        {   salonFan (state: "010101")
        }
        else    if (currentValue >= Float(0.25) && currentValue <= Float(0.5))
        {   salonFan (state: "101001")
        }
        else    if (currentValue >= Float(0.5) && currentValue <= Float(0.75))
        {   salonFan (state: "1001101")
        }
        else    if (currentValue >= Float(0.75) && currentValue <= Float(1.0))
        {   salonFan (state: "1010220")
        }
    }
    
    
    
    
    
    
    @IBAction func openCloseDoor(_ sender: UIButton) {
        if (flag6 == 1){
           openClose(state: "010101")
            flag6 = 0
        }
        else if (flag6 == 0){
            openClose(state: "101010")
            flag6 = 1
        }
    }

/************************************************************************************************************************************************************************/
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        
        
        
        
        
        
        
        
        
        
        /**************************************************************shapping the buttons**************************************************************************************/
        
        self.applyRoundCorner(lampRoomOne)
        self.applyRoundCorner(cameraRoomOne)
       
        
        self.applyRoundCorner(lampRoomTwo)
        self.applyRoundCorner(cameraRoomTwo)
        
        self.applyRoundCorner(lampRoomThree)
        self.applyRoundCorner(cameraRoomThree)
        
        self.applyRoundCorner(lampRoomFour)
        self.applyRoundCorner(cameraRoomFour)
        
        self.applyRoundCorner(lampRoomFive)
        self.applyRoundCorner(cameraRoomFive)
        
        self.applyRoundCorner(lampSalon)
        self.applyRoundCorner(cameraSalon)
       
       
        self.applyRoundCorner(openCloseDoor)
        self.applyRoundCorner(cameraDoor)
        self.applyRoundCorner(sensorWarnings)
    /************************************************************************************************************************************************************************/
        

    /******************************************************localizing outlets ***********************************************************************************************/
        
        roomOne.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "YzQ-if-bXT.text" , comment: " ")
        lampRoomOne.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomOne.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanOne.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
     
        
        
        roomTwo.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "NSN-0q-GoP.text" , comment: " ")
        lampRoomTwo.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomTwo.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanTwo.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        
        
        
        roomThree.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "hKL-tq-hPh.text" , comment: " ")
        lampRoomThree.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomThree.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanThree.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        
        roomFour.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "TXB-rf-fYI.text", comment: " ")
        lampRoomFour.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomFour.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanFour.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        
        roomFive.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "CjL-Eu-zb5.text" , comment: " ")
        lampRoomFive.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraRoomFive.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanFive.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
        
        
        
        salon.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "yEk-r9-re3.text" , comment: " ")
        lampSalon.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "P7A-ga-Myf.normalTitle", comment: " "), for: .normal)
        cameraSalon.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        fanSalon.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Nxv-SX-w9T.text", comment: " ")
        
       
        
        
        door.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key:"hgV-tR-k1g.text", comment: " ")
        openCloseDoor.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "E9f-eH-9S4.normalTitle", comment: " "), for: .normal)
        cameraDoor.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "TfX-ba-qIA.normalTitle", comment: " "), for: .normal)
        
        
        
      
        
        
        notifications.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "1CW-A6-L6f.text", comment: " ")
         sensorWarnings.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "iQS-VN-0D6.text", comment: " ")
        
        
        

    /************************************************************************************************************************************************************************/
        

    /**********************************************************Getting warnings**********************************************************************************************/
        

        
        let ref1 = Database.database().reference()
        ref1.child("Room1").child("Fan").observe(.childChanged) { (snapshot) in
        let warn = snapshot.value as? String
        self.sensorWarnings.text = warn
        }
    /************************************************************************************************************************************************************************/
        

    /****************************************************settongs of the rooms***********************************************************************************************/
        

        /*    let ref2 = Database.database().reference()
            ref2.child("roomsMode").child("noRooms").observe(.childChanged) { (snapshot) in
            let noOfRooms = snapshot.value as? String
             self.noOfRoooms.text = noOfRooms
        }
        if ( noOfRoooms.text == "0"){
          twoRoom()
        }
        else if( noOfRoooms.text == "1"){
        threeRoom()
            
        }
        else if( noOfRoooms.text == "2"){
           fourRoom()
        }*/
    /************************************************************************************************************************************************************************/
        

    }
    /*******************************************************firebase database functions**************************************************************************************/

    func applyRoundCorner(_ object: AnyObject){
        
        object.layer.cornerRadius = object.frame.height / 2
        object.layer.masksToBounds = true
    }
     /********firebase database functions*********/
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
    }

    func room2Light (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Room2").child("Light").setValue(post)
        
        
    }
    func room2Fan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Room2").child("Fan").setValue(post)
    }
    
    func room3Light (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Room3").child("Light").setValue(post)
        
        
    }
    func room3Fan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Room3").child("Fan").setValue(post)
    }
    
    func room4Light (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Room4").child("Light").setValue(post)
        
        
    }
    func room4Fan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Room4").child("Fan").setValue(post)
    }
    
    func room5Light (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Room5").child("Light").setValue(post)
        
        
    }
    func room5Fan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Room5").child("Fan").setValue(post)
    }
    
    
    func salonLight (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Light" :state as AnyObject]
        ref.child("Salon").child("Light").setValue(post)
        
        
    }
    
    
    func salonFan (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Salon").child("Fan").setValue(post)
    }
  
    
    func openClose (state : String)
    {
        let ref = Database.database().reference()
        let post : [String : AnyObject] = ["Fan" :state as AnyObject]
        ref.child("Door").child("open/close").setValue(post)
    }
    
    /************************************************************************************************************************************************************************/
    
    
    
    
    
    
    /*******************************************************setting functions************************************************************************************************/
    func twoRoom(){
        roomThree.textColor = .gray
        lampRoomThree.backgroundColor = .gray
        cameraRoomThree.backgroundColor = .gray
        fanThree.textColor = .gray
        
        
        roomFour.textColor = .gray
        lampRoomFour.backgroundColor = .gray
        cameraRoomFour.backgroundColor = .gray
        fanFour.textColor = .gray
        
        
        roomFive.textColor = .gray
        lampRoomFive.backgroundColor = .gray
        cameraRoomFive.backgroundColor = .gray
        fanFive.textColor = .gray
    }
    func threeRoom(){
        roomFour.textColor = .gray
        lampRoomFour.backgroundColor = .gray
        cameraRoomFour.backgroundColor = .gray
        fanFour.textColor = .gray
        
        
        roomFive.textColor = .gray
        lampRoomFive.backgroundColor = .gray
        cameraRoomFive.backgroundColor = .gray
        fanFive.textColor = .gray
    }
    func fourRoom(){
        roomFive.textColor = .gray
        lampRoomFive.backgroundColor = .gray
        cameraRoomFive.backgroundColor = .gray
        fanFive.textColor = .gray
    }
    /************************************************************************************************************************************************************************/
    

}
    
    

