//
//  ViewController.swift
//  AppStore
//
//  Created by Evandro Rodrigo Minamoto
//

import UIKit

class ViewController: UIViewController {
    
    let sections = [Section].parse(jsonFile: "sampleData")
    
    lazy var colletionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionaLayout())
    lazy var dataSource: UICollectionViewDiffableDataSource<Section, App> = createDataSource()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setup()
        registerCells()
        createHeader()
        reloadSnapshotData()
    }
    
    func reloadSnapshotData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, App>()
        snapshot.appendSections(sections)
        sections.forEach { section in
            snapshot.appendItems(section.items, toSection: section)
        }
        dataSource.apply(snapshot)
    }
    
    func createDataSource() -> UICollectionViewDiffableDataSource<Section, App> {
        UICollectionViewDiffableDataSource<Section, App>(collectionView: colletionView) { colletionView, indexPath, app in
            
            switch self.sections[indexPath.section].type {
                
            case "downloadTable":
                return colletionView.configure(DownloadTableCell.self, with: app, for: indexPath)
                
            case "listTable":
                return colletionView.configure(ListTableCell.self, with: app, for: indexPath)
                
            default:
                return colletionView.configure(FeatureCell.self, with: app, for: indexPath)
            }
        }
    }
    
    func createHeader() {
        dataSource.supplementaryViewProvider = { [weak self] colletionView, kind, indexPath in
            guard let self = self else { return nil }
            switch self.sections[indexPath.section].type {
    
            case "listTable", "downloadTable":
                guard let sectionHeader = colletionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                         withReuseIdentifier: SectionHeader.reuseIdentifier,
                                                                                         for: indexPath) as? SectionHeader
                else {
                    return nil
                }
                guard let app = self.dataSource.itemIdentifier(for: indexPath)
                else {
                    return nil
                }
                guard let section = self.dataSource.snapshot().sectionIdentifier(containingItem: app)
                else {
                    return nil
                }
                guard !section.title.isEmpty
                else {
                    return nil
                }
                
                sectionHeader.titleLabel.text = section.title
                sectionHeader.subtitleLabel.text = section.subtitle
                
                return sectionHeader
                
            default:
                return nil
            }
        }
    }
    
    func registerCells() {
        
        colletionView.register(FeatureCell.self, forCellWithReuseIdentifier: FeatureCell.reuseIdentifier)
        colletionView.register(ListTableCell.self, forCellWithReuseIdentifier: ListTableCell.reuseIdentifier)
        colletionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseIdentifier)
        colletionView.register(DownloadTableCell.self, forCellWithReuseIdentifier: DownloadTableCell.reuseIdentifier)
    }
    
    func createCompositionaLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = self.sections[sectionIndex]
            switch section.type {
            
            case "downloadTable":
                return self.createDownloadSection()
                
            case "listTable":
                return self.createListTableSection()
                
            default:
                return self.createFeatureSection()
            }
        }
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        
        return layout
    }
    
    func createDownloadSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.3))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                           leading: 5,
                                                           bottom: 0,
                                                           trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                               heightDimension: .fractionalWidth(0.5))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: groupSize,
                                                           subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        let sectionHeader = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [sectionHeader]
        
        return layoutSection
    }
    
    func createListTableSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(0.2))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                           leading: 20,
                                                           bottom: 5,
                                                           trailing: 0)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                     heightDimension: .estimated(200))
        let layoutGroup = NSCollectionLayoutGroup.vertical(layoutSize: layoutGroupSize,
                                                           subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        
        let header = createSectionHeader()
        layoutSection.boundarySupplementaryItems = [header]
        
        return layoutSection
        
    }
    
    func createFeatureSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 0,
                                                           leading: 5,
                                                           bottom: 0,
                                                           trailing: 5)
        let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                     heightDimension: .estimated(350))
        let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize,
                                                             subitems: [layoutItem])
        let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
        layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
        
        return layoutSection
    }

    func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let layoutSectionHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9),
                                                             heightDimension: .estimated(80))
        let layoutSectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutSectionHeaderSize,
                                                                              elementKind: UICollectionView.elementKindSectionHeader,
                                                                              alignment: .top)
        return layoutSectionHeader
    }
}

extension ViewController: ViewCode {
    func buildViewHierarchy() {
    
        view.addSubview(colletionView)
    }
    
    func addConstraints() {
        
        colletionView.fillSuperview()
    }
    
    
}
