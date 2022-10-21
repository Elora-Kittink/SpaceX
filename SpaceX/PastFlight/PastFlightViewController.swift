//
//  PastFlightController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
//

import UIKit

class PastFlightViewController: UIViewController {
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var succesLabel: UILabel!
    @IBOutlet private weak var succesResponseLabel: UILabel!
    @IBOutlet private weak var recoveredLabel: UILabel!
    @IBOutlet private weak var recoveredResponseLabel: UILabel!
    @IBOutlet private weak var reusedLabel: UILabel!
    @IBOutlet private weak var reusedResponseLabel: UILabel!
    @IBOutlet private weak var flightNumberLabel: UILabel!
    @IBOutlet private weak var flightNumberResponseLabel: UILabel!

    @IBOutlet private weak var youtubeLink: UIImageView! {
        didSet {
            self.youtubeLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(youtubeAction)))
        }
    }
    
    @IBOutlet weak var wikipediaLink: UIImageView! {
        didSet {
            self.wikipediaLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(wikipediaAction)))
        }
    }
    
    @IBOutlet weak var articleLink: UIImageView! {
        didSet {
            self.articleLink.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(articleAction)))
        }
    }
    
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    var flight: FlightStruct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.dateLabel.text = flight.dateUnix.convertDate()
        self.nameLabel.text = flight.name
        self.detailsLabel.text = flight.details
        self.succesResponseLabel.text = succes(bool: flight.success)
        self.recoveredResponseLabel.text = succes(bool: flight.fairings?.recovered)
        self.reusedResponseLabel.text = succes(bool: flight.cores.first?.reused)
        self.flightNumberResponseLabel.text = "\(flight.flightNumber )"
        
    }
    
    func succes(bool: Bool?) -> String {
        guard let succes = bool else {
            return "information manquante"
        }
        let succesTrue = succes ?  "valid" :  "no"
        return succesTrue
    }
    
    
    
    @objc func youtubeAction() {
        if let youtubeURL = flight.links.webcast {
            self.launchUrl(test: .youtube, url: youtubeURL)
        }
    }
    
    @objc func wikipediaAction() {
        if let wikiUrl = flight.links.wikipedia {
            self.launchUrl(test: .other, url: wikiUrl)
        }
    }
    
    @objc func articleAction() {
        if let articleLink = flight.links.article {
            self.launchUrl(test: .other, url: articleLink)
        }
    }
    
    func loadImages() {
//        faire en sorte de remplir avec les 4 premières images et si y en a moins n'afficher que celles qui existent et cacher l'UIImageView
    }
    
    func launchUrl(test: LaunchAppName, url: String) {
                
        guard let requestURL = URL(string: url) else {
            return
        }
        
        guard let name = test.base else {
            UIApplication.shared.openURL(requestURL)
            print("passe1 \(requestURL)")
            return
        }
        
        if let appURL = URL(string: "\(name)\(url)") {
            print("passe2 \(name)\(url))")
            if UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else {
                UIApplication.shared.open(requestURL)
                print("passe2 \(requestURL)")
            }
        }
    }
}

enum LaunchAppName {
    case youtube, twitter, other, wikipedia
    
    var base: String? {
        switch self {
        case .youtube:
            return "youtube://"
        case .twitter:
            return "twitter://"
        default:
            return nil
        }
    }
}
