//
//  speechViewController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/9/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit

class speechViewController: UIViewController {

    @IBOutlet var microphone: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var flag = 0
    @IBAction func micPressed(_ sender: Any) {
        if(flag == 0){
        microphone.loadGif(name: "ezgif-2-9678d06e66db")
            flag = 1
        }
        else if (flag == 1){
            self.microphone.image = UIImage(named: "Untitled-3")
            flag = 0
        }
    }


 
}
