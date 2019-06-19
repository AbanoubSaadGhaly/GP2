//
//  webViewController.swift
//  GP2
//
//  Created by Abanoub S. Ghaly on 6/19/19.
//  Copyright © 2019 Abanoub S. Ghaly. All rights reserved.
//

import UIKit

class webViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let mySecurityCam = URL (string: "https://drive.google.com/file/d/1HnImSVw_z1qAQ1h1L8qDxgDrpFOTQmE7/view?usp=sharing") else { return  }
        let request = URLRequest(url: mySecurityCam )
        webView.loadRequest(request)
    }
    


}
