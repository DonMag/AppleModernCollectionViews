/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Section headers and footers example
*/

import UIKit

class SectionHeadersFootersViewController: UIViewController {

    static let sectionHeaderElementKind = "section-header-element-kind"
    static let sectionFooterElementKind = "section-footer-element-kind"

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil

	var selectCounts: [Int] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Section Headers/Footers"
        configureHierarchy()
        configureDataSource()
		
		let n = self.collectionView.numberOfSections
		selectCounts = Array(repeating: 0, count: n)
		print("end of viewDidLoad", n)
    }
}

extension SectionHeadersFootersViewController {
    /// - Tag: HeaderFooter
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                             heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(44))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)

        let headerFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                     heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterSize,
            elementKind: SectionHeadersFootersViewController.sectionHeaderElementKind, alignment: .top)

		let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
			layoutSize: headerFooterSize,
			elementKind: SectionHeadersFootersViewController.sectionFooterElementKind, alignment: .bottom)
		
		
		// original
		//section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
		
		// headers only
		section.boundarySupplementaryItems = [sectionHeader]

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

extension SectionHeadersFootersViewController {
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    /// - Tag: SupplementaryRegistration
    func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<ListCell, Int> { (cell, indexPath, identifier) in
            // Populate the cell with our item description.
            cell.label.text = "\(indexPath.section),\(indexPath.item)"
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: SectionHeadersFootersViewController.sectionHeaderElementKind) {
            (supplementaryView, string, indexPath) in

			// original
			//supplementaryView.label.text = "\(string) for section \(indexPath.section)"
			//supplementaryView.backgroundColor = .lightGray
			//supplementaryView.layer.borderColor = UIColor.black.cgColor
			//supplementaryView.layer.borderWidth = 1.0
			
			print("get header for section:", indexPath.section)
			
			//supplementaryView.label.text = "\(string) for section \(indexPath.section)"
			supplementaryView.label.text = "sCount: \(self.selectCounts[indexPath.section]) for section \(indexPath.section)"

			// default background color / corner radius /
			//	text color / border color / border width
			supplementaryView.backgroundColor = .lightGray
			supplementaryView.layer.cornerRadius = 0.0

			supplementaryView.layer.borderColor = UIColor.black.cgColor
			supplementaryView.layer.borderWidth = 1.0
			supplementaryView.label.textColor = .black

			// specific background color / corner radius /
			//	text color / border color / border width
			//	for sections 0, 1, 2 (all the rest use default
			switch indexPath.section {
			case 0:
				supplementaryView.backgroundColor = .cyan
				supplementaryView.layer.cornerRadius = 6.0
				()
			case 1:
				supplementaryView.backgroundColor = .systemBlue
				supplementaryView.label.textColor = .white
				supplementaryView.layer.cornerRadius = 12.0
				()
			case 2:
				supplementaryView.backgroundColor = .yellow
				supplementaryView.layer.cornerRadius = 16.0
				supplementaryView.layer.borderWidth = 0.0
				supplementaryView.layer.borderColor = UIColor.red.cgColor
				()
			default:
				()
			}
			
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <TitleSupplementaryView>(elementKind: SectionHeadersFootersViewController.sectionFooterElementKind) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = "\(string) for section \(indexPath.section)"
            supplementaryView.backgroundColor = .lightGray
            supplementaryView.layer.borderColor = UIColor.black.cgColor
            supplementaryView.layer.borderWidth = 1.0
        }
            
        dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        dataSource.supplementaryViewProvider = { (view, kind, index) in
            return self.collectionView.dequeueConfiguredReusableSupplementary(
                using: kind == SectionHeadersFootersViewController.sectionHeaderElementKind ? headerRegistration : footerRegistration, for: index)
        }

        // initial data
        let itemsPerSection = 3 //5
        let sections = Array(0..<25)
        var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
        var itemOffset = 0
        sections.forEach {
            snapshot.appendSections([$0])
            snapshot.appendItems(Array(itemOffset..<itemOffset + itemsPerSection))
            itemOffset += itemsPerSection
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SectionHeadersFootersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
		selectCounts[indexPath.section] += 1
		//collectionView.reloadSections([indexPath.section])
    }
}
