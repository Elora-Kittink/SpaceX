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
    var upComingFlights: [FlightStruct] = []
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
        collectionView.delegate = self
        Task {
           _ = await self.homeService.fetchFlights()
        }
        
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
    
    var selectedIndex: Int = 0
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "upcomingSegue" {
            if let upcomingVC = segue.destination as? UpComingFlightViewController {
                upcomingVC.testtitle = "\(upComingFlights[selectedIndex].flightNumber)"
            } else {
                print("segue destination error")
//                faire gestion de l'erreur
            }
        }
    }
    
}

extension HomeViewController: HomeServiceDelegate {
    func didFinish(result: Flightcase) {
        self.upComingFlights = result.upcoming
        self.pastFlights = result.past
        print("upcoming flights \(upComingFlights)")
    }
    func didFail(error: Error) {
        print("☠️ Error: \(error.localizedDescription)")
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return 10 } else { return 10 }
//        if section == 0 { return upComingFlights.count } else { return pastFlights.count }
    }
    
//    MARK: - View Supplementary Element of Kind
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        quelque chose comme ça pour les headers?
//    }
    
//    MARK: - Cell For Item At
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("index \(indexPath.section)")
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PastCollectionViewCell.identifier, for: indexPath)
//            je passe les data ici? genre cell.data = pastFlights[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCollectionViewCell.identifier, for: indexPath)
            //            je passe les data ici? genre cell.data = upcomingFlights[indexPath.row]
            return cell
        }
    }
    
    
//     MARK: - Did Select Item At - ce qui se passe au clique sur une cell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "UpComingFlightViewController") as? UpComingFlightViewController
            else {
                return
            }
            controller.flight = upComingFlights[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
//            self.selectedIndex = indexPath.row
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "PastFlightViewController") as? PastFlightViewController
            else {
                return
            }
            controller.flight = pastFlights[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
