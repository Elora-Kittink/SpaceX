//
//  PastCollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//


import UIKit

class PastCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var pastCellNameLabel: UILabel!
    @IBOutlet private weak var pastCellDateLabel: UILabel!
    
    
    static let identifier = "PastCollectionViewCell"
    
    var data: FlightStruct! {
        didSet {
            pastCellNameLabel.text = data.name
            pastCellDateLabel.text = data.dateUnix.convertDate()
            guard let imageUrl = data.links.flickr.original.first else {
                self.imageView.image = #imageLiteral(resourceName: "upcomingFlight")
                return
            }
            imageView.loadImage(url: imageUrl)
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
}
