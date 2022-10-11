//
//  UpComingController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class UpComingFlightViewController: UIViewController {

    @IBOutlet weak var testlabel: UILabel!
    
    var testtitle: String? 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.testlabel.text = self.testtitle
        // Do any additional setup after loading the view.
    }
}
