//
//  HomeHeader.swift
//  SpaceX
//
//  Created by Elora on 12/10/2022.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    
    @IBOutlet private weak var headerLabel: UILabel!
    
    static let identifier = "HomeHeader"
    
    func configure(title: String) {
        backgroundColor = .blue
        headerLabel.text = title
    }
}
