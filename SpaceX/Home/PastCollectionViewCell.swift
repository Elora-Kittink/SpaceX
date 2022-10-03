//
//  PastCollectionViewCell.swift
//  SpaceX
//
//  Created by Elora on 03/10/2022.
//


import UIKit

class PastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PastCollectionViewCell"
    
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
            UIImage(named: "cat1"),
            UIImage(named: "cat2"),
            UIImage(named: "cat3"),
            UIImage(named: "cat4"),
            UIImage(named: "cat5"),
            UIImage(named: "cat6"),
            UIImage(named: "cat7"),
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
