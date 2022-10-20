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
        case upcomingType, pastType
    }
    
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var homeService: HomeService!
    var upComingFlights: [FlightStruct] = []
    var pastFlights: [FlightStruct] = []
    var selectedIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.homeService = HomeService(delegate: self)
        
        collectionView.register(UINib(nibName: "PastCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: PastCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: "UpcomingCollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: UpcomingCollectionViewCell.identifier)

        collectionView.register(UINib(nibName: "HomeHeader",
                                      bundle: nil),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: HomeHeader.identifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = self.generateLayout()
        
        Task {
           _ = await self.homeService.fetchFlights()
        }
    }

    
    func generateLayout() -> UICollectionViewLayout {
      let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment)
          -> NSCollectionLayoutSection? in

        let sectionLayoutKind = SectionType.allCases[sectionIndex]
        switch sectionLayoutKind {
        case .upcomingType: return self.createUpcomingLayout()
        case .pastType: return self.createPastLayout()
        }
      }
      return layout
    }
    
     func createUpcomingLayout() -> NSCollectionLayoutSection {
//        Items
        let upcomingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .estimated(268),
            heightDimension: .fractionalHeight(1)))

        
//        Groups
        let upcomingGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(208)
            ),
            subitem: upcomingItem,
            count: 1)
         
//        Sections
         
        let upcomingSection = NSCollectionLayoutSection(group: upcomingGroup)
         upcomingSection.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
         upcomingSection.orthogonalScrollingBehavior = .continuous
         
//        return
        return upcomingSection
    }
    
     func createPastLayout() -> NSCollectionLayoutSection {
//        Items

        let pastItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1 / 2),
            heightDimension: .fractionalHeight(1 / 2)))
         
        
//        Groups

        let pastGroupe = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(400)
            ),
            subitems: [pastItem])

//        Sections
        
        let pastSection = NSCollectionLayoutSection(group: pastGroupe)

         pastSection.boundarySupplementaryItems = [self.supplementaryHeaderItem()]
         
//        return
        return pastSection
    }
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(50)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }

    
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

// MARK: DELEGATE

extension HomeViewController: HomeServiceDelegate {
    func didFinish(result: Flightcase) {
        self.upComingFlights = result.upcoming
        self.pastFlights = result.past
        print("upcoming flights \(upComingFlights)")
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func didFail(error: Error) {
        print("☠️ Error: \(error.localizedDescription)")
    }
}


extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 { return upComingFlights.count } else { return pastFlights.count }
    }
    
// MARK: Header
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: HomeHeader.identifier,
            for: indexPath) as? HomeHeader
        
        if indexPath.section == 1 {
            header?.configure(title: "Old Flight")
        } else {
            header?.configure(title: "Upcoming Flight")
        }
        
       
        return header ?? UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: view.frame.size.width / 2)
    }
    
// MARK: - Cell For Item At

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("index \(indexPath.section)")
        if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PastCollectionViewCell.identifier,
                for: indexPath) as? PastCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.data = pastFlights[indexPath.row]
            return cell
        } else {
           guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UpcomingCollectionViewCell.identifier,
                for: indexPath) as? UpcomingCollectionViewCell
            else {
               return UICollectionViewCell()
           }
            cell.data = upComingFlights[indexPath.row]
            return cell
        }
    }
    
    
// MARK: - Did Select Item At - ce qui se passe au clique sur une cell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(
                withIdentifier: "UpComingFlightViewController") as? UpComingFlightViewController
            else {
                return
            }
            print(indexPath.row)
            controller.flight = upComingFlights[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        } else {
//            self.selectedIndex = indexPath.row
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(
                withIdentifier: "PastFlightViewController") as? PastFlightViewController
            else {
                return
            }
            controller.flight = pastFlights[indexPath.row]
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
