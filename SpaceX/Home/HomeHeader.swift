//
//  HomeHeader.swift
//  SpaceX
//
//  Created by Elora on 12/10/2022.
//

import UIKit

class HomeHeader: UICollectionReusableView {
    
    static let identifier = "HomeHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("erreur fatale")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure() {
        backgroundColor = .blue
    }
}
