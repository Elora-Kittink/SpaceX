//
//  PastFlightController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class PastFlightViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var succesLabel: UILabel!
    @IBOutlet weak var succesResponseLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    @IBOutlet weak var recoveredResponseLabel: UILabel!
    @IBOutlet weak var reusedLabel: UILabel!
    @IBOutlet weak var reusedResponseLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var flightNumberResponseLabel: UILabel!

    
    var flight: FlightStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.dateLabel.text = "\(flight.dateUnix)"
        self.nameLabel.text = flight.name
        self.detailsLabel.text = flight.details
        self.succesResponseLabel.text = "\(String(describing: flight.success))"
        self.recoveredResponseLabel.text = "\(String(describing: flight.fairings?.recovered))"
        self.reusedResponseLabel.text = "\(String(describing: flight.cores[0].reused))"
        self.flightNumberResponseLabel.text = "\(flight.flightNumber )"
    }
}
