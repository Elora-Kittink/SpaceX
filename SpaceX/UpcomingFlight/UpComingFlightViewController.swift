//
//  UpComingController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class UpComingFlightViewController: UIViewController {


    
    var flight: FlightStruct!
    
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    
    
    var testtitle: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailsLabel.text = flight.details
        self.dateLabel.text = "\(flight.dateUnix)"
        self.nameLabel.text = flight.name
        self.logoImageView.loadImage(url: flight.links.patch.small ?? "pas de logo")
    }
}

extension UIImageView {
     
    func loadImage(url: String) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                guard let url = URL(string: url) else {
                    return
                }
                guard let data = try? Data(contentsOf: url) else {
                    return
                }
                self.image = UIImage(data: data)
            }
        }
    }
}
