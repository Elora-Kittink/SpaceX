//
//  HomeController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
// https://www.donnywals.com/using-compositional-collection-view-layouts-in-ios-13/

import UIKit

class HomeViewController: UIViewController {
    var homeService: HomeService!
    var upComingFLights: [FlightStruct] = []
    var pastFlights: [FlightStruct] = []

    private let collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: HomeViewController.createLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeService = HomeService(delegate: self)
        view.addSubview(collectionView)
        collectionView.register(UpcomingCollectionViewCell.self,
                                forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        collectionView.register(PastCollectionViewCell.self,
                                forCellWithReuseIdentifier: PastCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.dataSource = self
    }
    
    static func createLayout() -> UICollectionViewCompositionalLayout {
//        Items
        let catItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .estimated(268),
            heightDimension: .estimated(172)))
        let dogItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .estimated(160),
            heightDimension: .estimated(158)))
        
//        Groups
        let catGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(390),
                heightDimension: .estimated(208)
            ),
            subitem: catItem,
            count: 1)
        let dogGroupe = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(390),
                heightDimension: .estimated(400)
            ),
            subitem: dogItem,
            count: 2)
        let combineGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(390),
                heightDimension: .estimated(800)
            ),
            subitems: [catGroup, dogGroupe])
//        Sections
        let section = NSCollectionLayoutSection(group: combineGroup)
//        return
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    
  @IBAction private func tapButton(_ sender: Any) {
        Task {
           _ = await self.homeService.fetchFlights()
        }
    }
}

extension HomeViewController: HomeServiceDelegate {
    func didFinish(result: Flightcase) {
        self.upComingFLights = result.upcoming
        self.pastFlights = result.past
    }
    func didFail(error: Error) {
        print("☠️ Error: \(error.localizedDescription)")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        dequeueConfiguredReusableCell
        
        print("index \(indexPath.section)")
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastCollectionViewCell.identifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
}
