//
//  PastCollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//


import UIKit

class PastCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet private weak var imageView: UIImageView!
    
    static let identifier = "PastCollectionViewCell"
    
    var data: FlightStruct! {
        didSet {
            guard let imageUrl = data.links.flickr.original.first else {
                self.imageView.image = UIImage(named: "pastFlight")
                return
            }
            imageView.loadImage(url: imageUrl)
        }
    }
}
