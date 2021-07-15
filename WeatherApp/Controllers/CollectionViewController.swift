//
//  CollectionViewController.swift
//  WeatherApp
//
//  Created by Ольга Ерохина on 7/15/21.
//

import UIKit
import RealmSwift

class CollectionViewController: UIViewController {
    
    var notificationToken: NotificationToken?
    var dataSource: UICollectionViewDiffableDataSource<WeatherCollection, Weather>!

    @IBOutlet weak var weatherCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let realm = try! Realm()
        let results = realm.objects(Weather.self)
        
        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
            guard let collectionView = self?.weatherCollectionView else { return }
            switch changes {
            case .initial:
                self?.configureSnapshot(collection: WeatherCollection(name: "MyCollection", weatherItems: RealmManager().getObjects()))
            case .update(_, deletions: _, insertions: _, modifications: _):
                self?.configureSnapshot(collection: WeatherCollection(name: "MyCollection", weatherItems: RealmManager().getObjects()))
            case .error(let error):
            
                fatalError("\(error)")
            }
        }
            
    }
    

    private func setupView() {
        title = "Weather App"
        weatherCollectionView.collectionViewLayout = configureCollectionViewLayout()
        configureDataSource()
    }
    
    func fahrenheitToCelsius(_ num: Double) -> Double {
        num - 273.15
    }
}

// MARK: - Collection View -

extension CollectionViewController {
    
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
   
        
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<WeatherCollection, Weather>(collectionView: weatherCollectionView) { (collectionView, indexPath, weatherItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherViewCell.reuseIdentifier, for: indexPath) as? WeatherViewCell else {
                fatalError("Cannot create new cell")
            }
        
            cell.cityLabel.text = weatherItem.cityName
            cell.temeratureLabel.text = String(format: "%.1f",self.fahrenheitToCelsius( weatherItem.weatherTemperature.temp))
            
            return cell
        }
    }
    
    func configureSnapshot(collection: WeatherCollection) {
        var currentSnapshot = NSDiffableDataSourceSnapshot<WeatherCollection, Weather>()
        
        currentSnapshot.appendSections([collection])
        currentSnapshot.appendItems(collection.weatherItems)
        self.dataSource.apply(currentSnapshot, animatingDifferences: false)
    }
}
