//
//  UpComingController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//https://www.youtube.com/c/SpaceX
//https://twitter.com/SpaceX?t=BrFWVAbStmW6Zd4AJm6GQA&s=09

import UIKit

class UpComingFlightViewController: UIViewController {
    
    
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var youtubeButton: UIButton!
    @IBOutlet private weak var twitterButton: UIButton!
    

    
    var flight: FlightStruct!
    var testtitle: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.detailsLabel.text = flight.details
//        self.dateLabel.text = "\(flight.dateUnix)"
        self.dateLabel.text = flight.dateUnix.convertDate()
        self.nameLabel.text = flight.name
        self.logoImageView.loadImage(url: flight.links.patch.small ?? "pas de logo")
    }
    
    @IBAction func twiterAction() {
        guard let appURL = NSURL(string: 
                                 "twitter://www.twitter.com/SpaceX?t=BrFWVAbStmW6Zd4AJm6GQA&s=09"),
              let webURL = NSURL(string: "https://twitter.com/SpaceX?t=BrFWVAbStmW6Zd4AJm6GQA&s=09") else {
            return
        }
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
    
    @IBAction func youtubeAction() {
        guard let appURL = NSURL(string: "youtube://www.youtube.com/c/SpaceX"),
              let webURL = NSURL(string: "https://www.youtube.com/c/SpaceX") else {
            return
        }
        
        let application = UIApplication.shared
        
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
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
