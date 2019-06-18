//
//  SignUpController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/4/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class SignUpController: UIViewController {

    @IBOutlet weak var signUpBotn: UIButton!
    @IBOutlet weak var signUpLogo: UILabel!
    @IBOutlet weak var userEmailTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var userPasswordTF: UITextField!
    @IBOutlet weak var backToSignIn: UIButton!
   
    @IBOutlet weak var logo2: UILabel!
    
    // @IBOutlet var gifView: UIImageView!
    
    @IBAction func signUp(_ sender: Any) {
        
        guard let username = userNameTF.text,
        username != " " ,
        
        let email = userEmailTF.text,
        email != " " ,
    
        let password = userPasswordTF.text,
        password != " "
              else  {
                
                alertController.showAlert(self, title: "missing info", message: "please fill out all fields")
                
                return
                
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard error == nil else{
                
                alertController.showAlert(self, title: "Error", message: error!.localizedDescription )
                return
            }
            guard let user = user  else {return}
         
            print( user.user.email ?? "MISSING EMAIL" )
            print(user.user.uid)
            let changeRequest = user.user.createProfileChangeRequest()
            changeRequest.displayName = username
            changeRequest.commitChanges(completion: { (error) in
                guard error == nil else{
                    
                    alertController.showAlert(self, title: "Error", message: error!.localizedDescription )
                    return
                }
                self.performSegue(withIdentifier: "signUpSegue", sender: nil)
            })
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let emailImage = UIImage(named: "email-7")
        addLeftImageToTextField(txtField: userEmailTF, andImage: emailImage! )
        
        let passwordImage = UIImage(named: "lock-7")
        addLeftImageToTextField(txtField: userPasswordTF, andImage: passwordImage! )
        
        let userImage = UIImage(named: "man")
        addLeftImageToTextField(txtField: userNameTF, andImage: userImage! )
       // gifView.loadGif(name: "launchScreen")
        
     //   Logo.text  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "9SK-x3-uK0.text", comment: " ")
         logo2.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "9SK-x3-uK0.text", comment: " ")
        signUpLogo.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: "Sm9-zd-8mV.text", comment: " ")
        
        signUpBotn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "kst-bi-9T8.normalTitle", comment: " "), for: .normal)
        backToSignIn.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "gZP-Zx-2LA.normalTitle", comment: " "), for: .normal)

       // loginLogo.setTitle(LocalizationSystem.sharedInstance.localizedStringForKey(key: "MAK-Cb-VAo.normalTitle", comment: " "), for: .normal)
        userEmailTF.placeholder  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "8fv-nj-wKn.placeholder", comment: " ")
        userPasswordTF.placeholder  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "7Jx-Ro-PHb.placeholder", comment: " ")
       userNameTF.placeholder  = LocalizationSystem.sharedInstance.localizedStringForKey(key: "jrh-Po-KE6.placeholder", comment: " ")
    }
    func addLeftImageToTextField(txtField: UITextField, andImage img: UIImage){
        let leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
        
    }
}
