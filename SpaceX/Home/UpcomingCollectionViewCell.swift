//
//  CollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//

import UIKit


class UpcomingCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UpcomingCollectionViewCell"
    
//    var data: FlightStruct! {
//        didSet {
//            guard let urlImage = URL(string: data.links.patch.small)
//            else {
//                return
//            }
//            
//        }
//    }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        let images: [UIImage] = [
            UIImage(named: "dog1"),
            UIImage(named: "dog2"),
            UIImage(named: "dog3"),
            UIImage(named: "dog4"),
            UIImage(named: "dog5"),
            UIImage(named: "dog6"),
            UIImage(named: "dog7"),
        ].compactMap({ $0 })
        imageView.image = images.randomElement()
        contentView.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
//        fatalError()
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
}
