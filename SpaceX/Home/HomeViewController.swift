//
//  HomeController.swift
//  SpaceX
//
//  Created by Elora on 22/09/2022.
// https://www.donnywals.com/using-compositional-collection-view-layouts-in-ios-13/
// https://github.com/alexpaul/Compositional-Layout/blob/master/Multiple-Sections.md

import UIKit

class HomeViewController: UIViewController {
    
    enum SectionType: CaseIterable {
        case catType, dogType
    }
    
    var homeService: HomeService!
    var upComingFLights: [FlightStruct] = []
    var pastFlights: [FlightStruct] = []
    var collectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeService = HomeService(delegate: self)
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: self.generateLayout()
        )
        view.addSubview(collectionView)
        collectionView.register(UpcomingCollectionViewCell.self,
                                forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)
        collectionView.register(PastCollectionViewCell.self,
                                forCellWithReuseIdentifier: PastCollectionViewCell.identifier)
        collectionView.frame = view.bounds
        collectionView.backgroundColor = .brown
        collectionView.dataSource = self
    }

    
    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
        layoutEnvironment: NSCollectionLayoutEnvironment)
          -> NSCollectionLayoutSection? in

        let sectionLayoutKind = SectionType.allCases[sectionIndex]
        switch sectionLayoutKind {
        case .catType: return self.createCatLayout()
        case .dogType: return self.createDogLayout()
        }
      }
      return layout
    }
    
     func createCatLayout() -> NSCollectionLayoutSection {
//        Items
        let catItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .estimated(268),
            heightDimension: .estimated(172)))

        
//        Groups
        let catGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(208)
            ),
            subitem: catItem,
            count: 1)
         
//        Sections
        let catSection = NSCollectionLayoutSection(group: catGroup)
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
         let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Potichat", alignment: .top)
         catSection.boundarySupplementaryItems = [headerElement]
         catSection.orthogonalScrollingBehavior = .continuous
         
//        return
        return catSection
    }
    
     func createDogLayout() -> NSCollectionLayoutSection {
//        Items

        let dogItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/2),
            heightDimension: .estimated(158)))
        
//        Groups

        let dogGroupe = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(400)
            ),
            subitems: [dogItem])

//        Sections
        
        let dogSection = NSCollectionLayoutSection(group: dogGroupe)
         let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44))
         let headerElement = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: "Potichien", alignment: .top)
         dogSection.boundarySupplementaryItems = [headerElement]
//        return
        return dogSection
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 10 } else { return 10 }
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        
//    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        dequeueConfiguredReusableCell
        
        print("index \(indexPath.section)")
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastCollectionViewCell.identifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath)
            return cell
        }
    }
}
