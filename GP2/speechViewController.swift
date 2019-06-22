//
//  speechViewController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/9/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import Alamofire
import Contacts
import EventKit
import MediaPlayer
import CoreData
class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,CLLocationManagerDelegate {
    
    
    
    @IBOutlet weak var myText: UITextField!
    @IBOutlet weak var myOutText: UILabel!
    
    
    @IBAction func micBtnPressed(_ sender: UIButton) {
    
        
        
     //   removeReminder()
        addReminder()

        /*  if (myText.text == "اضف مذكرة" || myText.text == "اضافة مذكرة" ){
         addReminder()
    }
        else    if (myText.text == "احذف مذكرة" || myText.text == "حذف المذكرات" ){
            removeReminder()
        }
        else    if (myText.text == "تحميل المذكرات" || myText.text == "تحميل المذكرة" ){
            removeReminder()
        }
        else    if (myText.text == "اضف مفكرة" || myText.text == "اضافة مفكرة" ){
            myOutText.text = " اضف مفكرات"
        }
        else    if (myText.text == " احذف المفكرة" || myText.text == " حذف المفكرات"){
            myOutText.text = " حذف المفكرة"
            
        }
        else    if (myText.text == "التقط صورة" || myText.text == "قم بالتقاط صورة"){
            myOutText.text = "التقط صورة"
            
        }*/

}
    
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var loadORremove : Bool = false //true for Remove
    // false  for Load
    var notes = [Note]()
    var playlistTitle: [String] = []
    var numOfSongs : [ Int ] = []
    let locationManager = CLLocationManager()
    var filterdItemsArray = [CONTACTS]()
    var smstext : String = ""
    let eventStore : EKEventStore = EKEventStore()
    var calendars: [EKCalendar]?
    var remindstoto = [EKReminder]()
    var events = [EKEvent]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // loadReminder()
        //LoadRemoveEvent()
       // loadNotes()
       // openPhotos()
        //when select weather only
        /*
         locationManager.requestWhenInUseAuthorization()
         locationManager.startUpdatingLocation()*/
        
    }
    // **********************to take photo and save photos ****************************
    func takePhotos (){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePickerController = UIImagePickerController()
            //imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage]as? UIImage{
            picker.dismiss(animated: true, completion: nil)
            UIImageWriteToSavedPhotosAlbum(pickedImage, nil, nil, nil)
            let alert = UIAlertController(title: "saved", message: "yourimage has been saved", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert,animated: true , completion: nil)
        }
    }
    //***************************    open photos   **************************************
    func openPhotos (){
        let url : NSURL = URL(string: "photos-redirect://")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    //**************************  GoogleSearch    *************************************
    func googleSearch(searchSent : String){
        print(searchSent.replacingOccurrences(of: " ", with: "+"))
        let myURLString =  "http://www.google.com/search?hl=ar&q=\(searchSent.replacingOccurrences(of: " ", with: "+"))"
        let url = myURLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let myURL = URL(string: url!)
        UIApplication.shared.open(myURL! , options: [:], completionHandler: nil)
    }
    //***************************   getWeather    *****************************************
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //last value in array will be more accurate
        let App_id = "1aceb2f3462bcbb96bb892abc52ab2cb"
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            print("long = \(location.coordinate.longitude), lat = \(location.coordinate.latitude) ")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let params : [String : String ] = [ "lat" : latitude , "lon" : longitude , "appid" : App_id ]
            getWeather( params: params)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("yess i fail")
        //hn7ot alert
        
    }
    func getWeather(params : [String : String]){
        let weatherURl = "http://api.openweathermap.org/data/2.5/weather"
        Alamofire.request(weatherURl,method: .get ,parameters: params).responseJSON {
            response in
            if response.result.isSuccess{
                print("success,got weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.UpdateWeatherData(json: weatherJSON)
                
            }else{
                // alert connection issues
                let alert = UIAlertController(title: "connection loss", message: "there is an issue in your connection", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                self.present(alert, animated: true, completion: nil)
                print("error,\(response.result.error ?? 0 as! Error)")
            }
        }
    }
    func UpdateWeatherData(json : JSON){
        let weatherModel = WeatherDataModel()
        if let temp = json["main"]["temp"].double{
            weatherModel.temp = Int(temp - 273.15)
            weatherModel.city = json["name"].stringValue
            weatherModel.condition = json["weather"][0]["id"].intValue
            weatherModel.weatherIcon = weatherModel.updateWeatherIcon(condition: weatherModel.condition)
            let alert = UIAlertController(title : "the Weather",message : "today , the weather is \(weatherModel.temp) in  \(weatherModel.city)",preferredStyle: .alert)
            
            alert.addImage(image: UIImage(named: weatherModel.weatherIcon)!)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }else{
            //alert city.text =  locationUNavailable
            let alert = UIAlertController(title: "Location unavailable", message: "can't reach to your location", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(OKAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    //*******************************    call contact     *************************************
    /**/func callContact (cont : String){
        print("ys")
        filterdItemsArray = fetchcontacts().filter { item in
            return item.fullname.lowercased().contains(cont.lowercased())
        }
        print(filterdItemsArray.count)
        if filterdItemsArray.count == 1{
            filterdItemsArray[0].number = filterdItemsArray[0].number.replacingOccurrences(of: " ", with: "")
            let url : NSURL = URL(string: "tel://\(filterdItemsArray[0].number)")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }else if filterdItemsArray.count > 1 {
            performSegue(withIdentifier: "callSegue", sender: self)}
        else {
            createcontactAlert(title: "not found ", message: "no matched name of contact found")
        }
    }
    func createcontactAlert (title : String , message : String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func fetchcontacts() -> [CONTACTS]{
        var fetcontacts = [CONTACTS]()
        let ContactStore = CNContactStore()
        let keys = [CNContactGivenNameKey,CNContactFamilyNameKey,CNContactPhoneNumbersKey]
        let fetchreq = CNContactFetchRequest.init(keysToFetch: keys as [CNKeyDescriptor] )
        do{
            try ContactStore.enumerateContacts(with: fetchreq) { (contact, end) in
                let datacontant = CONTACTS(NAME: "\(contact.givenName) \(contact.familyName)", phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "400")
                fetcontacts.append(datacontant)
                //    let dict = [ datacontant.fullname: datacontant.number]
                //    self.contactdic.append(dict)
                print(contact.givenName)
                print(contact.phoneNumbers.first?.value.stringValue ?? "")
            }}
        catch{
            print("failed to fetch")
        }
        return fetcontacts
    }
    //********************************  sendSMS    *******************************
    func sendSMS (cont : String , body : String){
        filterdItemsArray = fetchcontacts().filter { item in
            return item.fullname.lowercased().contains(cont.lowercased())
        }
        print(filterdItemsArray.count)
        guard let escapedBody = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        smstext = escapedBody
        if filterdItemsArray.count == 1{
            filterdItemsArray[0].number = filterdItemsArray[0].number.replacingOccurrences(of: " ", with: "")
            
            let url : NSURL = URL(string: "sms://\(filterdItemsArray[0].number)&body=\(escapedBody)")! as NSURL
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        }else if filterdItemsArray.count > 1 {
            performSegue(withIdentifier: "smsSegue", sender: self)}
        else {
            createcontactAlert(title: "not found ", message: "no matched name of contact found")
        }
    }
    //*******************************    AddReminder       **************************************
    func addReminder (title : String){
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let alert = UIAlertController(title: "Add date", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker)
        let DateTime = datePicker.date
        let ok = UIAlertAction(title: "ok", style: .default) { (action) in
            DispatchQueue.main.async{
                self.eventStore.requestAccess(to: EKEntityType.reminder) { (granted, error) in
                    if (granted) && (error == nil) {
                        let reminder:EKReminder = EKReminder(eventStore: self.eventStore)
                        reminder.title = title
                        reminder.priority = 2
                        reminder.notes = "...this is a note"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
                        
                        let alarm = EKAlarm(absoluteDate: DateTime)
                        reminder.addAlarm(alarm)
                        
                        reminder.calendar = self.eventStore.defaultCalendarForNewReminders()
                        do {
                            try self.eventStore.save(reminder, commit: true)
                            
                        } catch {
                            let alert = UIAlertController(title: "Reminder could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(OKAction)
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            }}
        alert.addAction(ok)
        let cancel = UIAlertAction(title: "cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 300)
        alert.view.addConstraint(height)
        self.present(alert, animated: true, completion: nil)
        
    }
    //********************************  remove Reminder **************************************
    func removeReminder (title : String){
        
        var count : Int = 0
        calendars = eventStore.calendars(for: EKEntityType.reminder)
        //  print("\(calendars?.count)")
        let predict = eventStore.predicateForReminders(in: calendars)
        
        self.eventStore.fetchReminders(matching: predict) { (reminders) in
            for remind in reminders! {
                if remind.title.lowercased().contains(title.lowercased()){
                    do{
                        // remind.isCompleted = true
                        try self.eventStore.remove(remind, commit: true)
                        DispatchQueue.main.async{
                            let alert = UIAlertController(title: "Reminder is successfully removed", message: "", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert.addAction(OKAction)
                            self.present(alert, animated: true, completion: nil)
                            count = count + 1 }
                    }catch{
                        
                    }
                    
                }
            }
            if count == 0 {
                DispatchQueue.main.async{
                    let alert = UIAlertController(title: "No remider with this title", message: "", preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true, completion: nil)}
            }
        }
    }
    //*******************************   load Reminders ********************************/
    func loadReminder(){
        prepareToLoadReminders()
        performSegue(withIdentifier: "ReminderSegue", sender: self)
    }
    func prepareToLoadReminders(){
        print("yes")
        calendars = eventStore.calendars(for: EKEntityType.reminder)
        let predict = eventStore.predicateForReminders(in: calendars)
        eventStore.fetchReminders(matching: predict) { (reminders) in
            self .remindstoto = reminders!
        }}
    //******************************    Add Event     ****************************************
    func addEvent(title : String){
        let datePicker1 = UIDatePicker()
        let datePicker2 = UIDatePicker()
        let evet : EKEvent = EKEvent(eventStore: self.eventStore)
        //let datePicker2 = UIDatePicker()
        datePicker1.datePickerMode = .dateAndTime
        datePicker2.datePickerMode = .dateAndTime
        
        let alert = UIAlertController(title: "Add startDate", message: nil, preferredStyle: .actionSheet)
        let alert2 = UIAlertController(title: "Add endDate", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker1)
        
        
        
        let Next = UIAlertAction(title: "Next", style: .default) { (action) in
            let DateTime1 = datePicker1.date
            DispatchQueue.main.async{
                self.eventStore.requestAccess(to: .event) { (granted, error) in
                    if (granted) && (error == nil ){
                        
                        evet.title = title
                        evet.startDate = DateTime1
                        alert2.view.addSubview(datePicker2)
                        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert2.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 350)
                        alert2.view.addConstraint(height)
                        let ok = UIAlertAction(title: "ok", style: .default){ (action) in
                            let DateTime2 = datePicker2.date
                            DispatchQueue.main.async{
                                evet.endDate = DateTime2
                                evet.addAlarm(.init(relativeOffset: -5*60))
                                evet.notes = "This is note"
                                evet.calendar = self.eventStore.defaultCalendarForNewEvents
                                do{
                                    try self.eventStore.save(evet, span: .thisEvent)
                                }catch let error as NSError{
                                    let alert3 = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                                    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                    alert3.addAction(OKAction)
                                    
                                    self.present(alert3, animated: true, completion: nil)
                                }
                            }
                            let alert3 = UIAlertController(title: "Event has been saved", message: "", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert3.addAction(OKAction)
                            
                            self.present(alert3, animated: true, completion: nil)
                        }
                        alert2.addAction(ok)
                        
                        let cancel = UIAlertAction(title: "cancel", style: .default){
                            (action) in
                            let alert3 = UIAlertController(title: "Event could not save", message: "", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert3.addAction(OKAction)
                            
                            self.present(alert3, animated: true, completion: nil)
                        }
                        alert2.addAction(cancel)
                        self.present(alert2, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        alert.addAction(Next)
        let cancel = UIAlertAction(title: "cancel", style: .default){
            (action) in
            let alert3 = UIAlertController(title: "Event could not save", message: "", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert3.addAction(OKAction)
            
            self.present(alert3, animated: true, completion: nil)
        }
        alert.addAction(cancel)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 350)
        alert.view.addConstraint(height)
        self.present(alert, animated: true, completion: nil)
    }
    //********************************   Load or remove event     **********************************
    func LoadRemoveEvent(){
        calendars = eventStore.calendars(for: EKEntityType.event)
        let datePicker1 = UIDatePicker()
        let datePicker2 = UIDatePicker()
        datePicker1.datePickerMode = .dateAndTime
        datePicker2.datePickerMode = .dateAndTime
        let alert = UIAlertController(title: "Add startDate", message: nil, preferredStyle: .actionSheet)
        let alert2 = UIAlertController(title: "Add endDate", message: nil, preferredStyle: .actionSheet)
        alert.view.addSubview(datePicker1)
        
        
        let Next = UIAlertAction(title: "Next", style: .default) { (action) in
            let DateTime1 = datePicker1.date
            DispatchQueue.main.async{
                let  startDate = DateTime1
                alert2.view.addSubview(datePicker2)
                let height: NSLayoutConstraint = NSLayoutConstraint(item: alert2.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 350)
                alert2.view.addConstraint(height)
                let ok = UIAlertAction(title: "ok", style: .default){ (action) in
                    let DateTime2 = datePicker2.date
                    DispatchQueue.main.async{
                        let   endDate = DateTime2
                        print(endDate)
                        let prediacte = self.eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: self.calendars!)
                        
                        self.events = self.eventStore.events(matching: prediacte)
                        print(self.events.count)
                        if self.loadORremove == true {
                            for i in self.events {
                                self.deleteevent(event: i)
                                print("+/")
                            }}
                        
                        if self.loadORremove == true{
                            let alert3 = UIAlertController(title: "all Event in this period has been deleted", message: "", preferredStyle: .alert)
                            let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                            alert3.addAction(OKAction)
                            
                            self.present(alert3, animated: true, completion: nil)}
                        if self.loadORremove == false{
                            if self.events.count > 0 {
                                self.performSegue(withIdentifier: "eventSegue", sender: self)}
                            else {
                                let alert3 = UIAlertController(title: "No Event in this period ", message: "", preferredStyle: .alert)
                                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                                alert3.addAction(OKAction)
                                
                                self.present(alert3, animated: true, completion: nil)
                            }
                        }
                    }}
                alert2.addAction(ok)
                let cancel = UIAlertAction(title: "cancel", style: .default){
                    (action) in
                    if self.loadORremove == true{
                        let alert3 = UIAlertController(title: "Event could not remove", message: "", preferredStyle: .alert)
                        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert3.addAction(OKAction)
                        
                        self.present(alert3, animated: true, completion: nil)
                    }}
                alert2.addAction(cancel)
                self.present(alert2, animated: true, completion: nil)
                
            }
        }
        alert.addAction(Next)
        let cancel = UIAlertAction(title: "cancel", style: .default){
            (action) in
            if self.loadORremove == true{
                let alert3 = UIAlertController(title: "Event could not remove", message: "", preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert3.addAction(OKAction)
                
                self.present(alert3, animated: true, completion: nil)}
        }
        alert.addAction(cancel)
        let height: NSLayoutConstraint = NSLayoutConstraint(item: alert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 350)
        alert.view.addConstraint(height)
        self.present(alert, animated: true, completion: nil)
        
    }
    func deleteevent(event : EKEvent){
        do{
            try eventStore.remove(event, span: EKSpan.thisEvent, commit: true)
            print("yes")
        }catch{
            print("Error while deleting event: \(error.localizedDescription)")
        }
    }
    ///****************************** playMusic   **************************************
    func playMusic(){
        let playlists = MPMediaQuery.playlists().collections
        for playlist in playlists! {
            //print(playlist.value(forProperty: MPMediaPlaylistPropertyName)!)
            playlistTitle.append(playlist.value(forProperty: MPMediaPlaylistPropertyName)! as! String)
            numOfSongs.append(playlist.count)
        }
        performSegue(withIdentifier: "musicSegue", sender: self)
    }
    //******************************* add Note **********************************
    func createNote (content : String){
        
        
        var TextField = UITextField()
        let newNote = Note(context: context)
        let alert = UIAlertController(title: "Add new note", message: "", preferredStyle: .alert)
        let addTitle = UIAlertAction(title: "Add Title", style: .default) { (action) in
            newNote.content = content
            let textTitle = TextField.text!
            if textTitle == "" {
                newNote.title = "Untitled Note"
            }else {
                newNote.title = textTitle
            }
            self.saveItem()
            
            let alert3 = UIAlertController(title: "Note is saved", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default , handler: nil)
            alert3.addAction(ok)
            self.present(alert3 , animated: true , completion: nil)
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "create new note"
            TextField = alertTextField
        }
        alert.addAction(addTitle)
        
        self.present(alert , animated: true, completion: nil)}
    
    //*********************    loadNotes       *********************
    func loadNotes(){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        do{
            notes = try context.fetch(request)
        }catch {
            print("Error fetching")
        }
        for note in notes {
            print(note.title)
        }
        performSegue(withIdentifier: "noteSegue", sender: self)
    }
    //*********************  func related to coreData ********************************
    func saveItem(){
        do{
            try context.save()
            
        } catch {
            print("error saving context \(error)")
        }
        
        
    }
    
    
    
    
    //******************************** prepare for all segues **********************************
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! oneTableViewController
        destination.contArray = filterdItemsArray
        if segue.identifier == "callSegue"{
            print("yes")
            destination.Seguesty = segue.identifier!}
        else if segue.identifier == "smsSegue" {
            destination.Seguesty = segue.identifier!
            destination.smstext2 = smstext
        } else if segue.identifier == "ReminderSegue" {
            destination.Seguesty = segue.identifier!
            destination.remindstoto = remindstoto
        } else if segue.identifier == "eventSegue" {
            print("hopaaa")
            destination.Seguesty = segue.identifier!
            destination.eventTa = events
        }else if segue.identifier == "musicSegue" {
            destination.Seguesty = segue.identifier!
            destination.playListTable = playlistTitle
            destination.numofSong = numOfSongs
        }else if segue.identifier == "noteSegue"{
            destination.Seguesty = segue.identifier!
            destination.noteTa = notes
        }
    }
    /************************************************mapping input texts***********************************/
   
    
    
    
    func addReminder(){
        let x:String = myText.text!
        let y =   "اضف مذكرات "
        print (x)
        let difference = zip(x , y).filter{ $0 != $1 }
        print(difference)
        let d = difference
        
        
        let lengh:Float = Float(d.count)
        print(lengh)
        
        // first word
        var z1 = " "
        var sum: Int = 0
        for chr in x {
            if (chr != " "){
                z1 = z1 + "\(chr)"
                sum = sum + 1
            }else {break}
        }
            print (z1)
    
        // 1st word main command
        var z2 = " "
        var sum2: Int = 0

        for i in y {
            if (i != " "){
                z2 = z2 + "\(i)"
                sum2 = sum2 + 1
            }else {break}
        }
        
        print (z2)

        // second word
        var end1:String  = " "
        if let c = x.firstIndex(of: " "){
            end1 = "\(x[c...])"
        }
        var z3 = " "
        var sum3 : Int = 0
        
        for i in end1 {
            z3 = z3 + "\(i)"
            sum3 = sum3 + 1
        }
        print(z3)
        
        
        
        
        
        
        
        
        // 2nd word main command
         var end2:String  = " "
        if let c = y.firstIndex(of: " "){
             end2 = "\(y[c...])"
            
            
        }
        var z4 = " "
        var sum4 : Int = 0
        
        for i in end2 {
            z4 = z4 + "\(i)"
            sum4 = sum4 + 1
        }
        print(z4)
        
        
        
        
       let difference1 = zip(z1 , z2).filter{ $0 != $1 }
        print(difference1.count)
        let dif1:Float = Float(difference1.count)
        let difference2 = zip(z3 , z4).filter{ $0 != $1 }
        print(difference2.count)
        let dif2:Float =  Float( difference2.count)

        
        
        
        let ln:Float = Float(y.count)
        print (ln)
        let err1:Float = Float( ( ( dif1 ) / (11)  * 100 ) )
        print (err1)
        let err2:Float = Float( ( ( dif2 ) / (11)  * 100 ) )
        let err:Float = err1 + err2
        print (err)
        if (err <= 10)
        { myOutText.text = "اضف مذكرات "
        }
        if (err > 10)
        { myOutText.text = " "
        }
    }
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  /*  func removeReminder(){
        let x:String = myText.text!
        let y =  "احذف مذكرات "
     
        let difference1 = zip(x , y).filter{ $0 != $1 }
        print(difference1)
        let d = difference1
        
        
        var z = [" "]
        for chr in x {
            z = z + ["\(chr)"]
        }
        print (z)
        let lengh:Float = Float(d.count)
        print(lengh)
        let ln:Float = Float(y.count)
        print (ln)
        let err:Float = Float((lengh/ln) * 100)
        print (err)
        if (err <= 20){
        myOutText.text = "احذف مذكرات"
            
    }
    }
    func LoadReminder(){
        
        let x:String = myText.text!
        let y = "تحميل المذكرات"
        var z = [" "]
        for chr in x {
            if (chr != nil){
            z = z + ["\(chr)"]
            }else {break}
        }
         myOutText.text = "تحميل المذكرات"
    }

    
    
    
    func addNotes(){
        myOutText.text  = "اضف مفكرة"
    }
    func removeNotes(){
        myOutText.text = "احذف مفكرة"
    }
    func LoadNotes(){
        myOutText.text = "تحميل المفكرات"
    }
  
    
    
    
    func addEvent(){
        myOutText.text = "اضف حدث"
    }
    func removeEvent(){
        myOutText.text = "احذف حدث"
    }
    func LoadEvent(){
        myOutText.text = "تحميل الاحداث"
    }
    
    
    
    func takePhoto(){
        myOutText.text = "التقط صورة"
    }
    func openGallery(){
        myOutText.text = "افتح معرض الصور"
    }
    
    
    func music(){
        myOutText.text = "تشغيل الموسيقي"
    }
    
    
    
    func smsMessages(){
        myOutText.text = "ارسال رسالة الي "
    }
    func callContacts(){
        myOutText.text = "الاتصال ب "
    }
    
    
    
    
 
    func wiki(){
         myOutText.text = "ابحث في ويكيبيديا عن"
    }
    func goog(){
        myOutText.text = "ابحث في جوجل عن"
    }*/

}
