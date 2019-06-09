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


  
    
    
    
    
    
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "signOutSegue", sender: nil)
        }catch {
            print(error)
        }
    }
    
}
