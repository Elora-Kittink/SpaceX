//
//  CollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//

import UIKit


class UpcomingCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet private weak var imageView: UIImageView!
    
    static let identifier = "UpcomingCollectionViewCell"
    
    var data: FlightStruct! {
        didSet {
            guard let imageUrl = data.links.flickr.original.first else {
                self.imageView.image = UIImage(named: "upcomingFlight")
                return
            }
            imageView.loadImage(url: imageUrl)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
