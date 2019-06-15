//
//  speechController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/4/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit
import Firebase
class speechController: UIViewController {


    @IBOutlet weak var lang: UILabel!
    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doChange(_ sender: Any) {
        if LocalizationSystem.sharedInstance.getLanguage() == "ar"{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            LocalizationSystem.sharedInstance.setLanguage(languageCode: "ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft

        }
    
     let vm = self.storyboard?.instantiateViewController(withIdentifier: "vm2")   as! MainTabBarController
       let appDlg = UIApplication.shared.delegate as? AppDelegate
     appDlg?.window?.rootViewController = vm
   




    }
    
  
    
    
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
        }catch {
            print(error)
        }
    }
    
}
