//
//  HomeController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class HomeViewController: UIViewController {
    var homeService: HomeService!
    var upComingFLights: [FlightStruct] = []
    var pastFlights: [FlightStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeService = HomeService(delegate: self)
    }
    
  
  @IBAction private func tapButton(_ sender: Any) {
        Task {
           _ = await self.homeService.fetchFlights()
        }
    }
}

extension HomeViewController: HomeServiceDelegate {
    func didFinish(result: Flightcase) {
        print(result)
        self.upComingFLights = result.upcoming
        self.pastFlights = result.past
    }
    func didFail(error: Error) {
        print("☠️ Error: \(error.localizedDescription)")
    }
}
