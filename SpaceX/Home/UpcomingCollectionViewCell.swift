//
//  CollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//

import UIKit


class UpcomingCollectionViewCell: UICollectionViewCell {
    

    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var upcomingCellDateLabel: UILabel!
    @IBOutlet private weak var upcomingCellNameLabel: UILabel!
    
    static let identifier = "UpcomingCollectionViewCell"
    
    var data: FlightStruct! {
        didSet {
            upcomingCellNameLabel.text = data.name
            upcomingCellDateLabel.text = data.dateUnix.convertDate()
            guard let imageUrl = data.links.flickr.original.first else {
                self.imageView.image = #imageLiteral(resourceName: "pasFlight")
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


