//
//  HomeController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    let service = HomeService()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
//    @IBOutlet weak var button: UIButton!
    
  
    @IBAction func tapButton(_ sender: Any) {
        Task {
           _ = await self.service.fetchFlights()
        }
    }
    

}
