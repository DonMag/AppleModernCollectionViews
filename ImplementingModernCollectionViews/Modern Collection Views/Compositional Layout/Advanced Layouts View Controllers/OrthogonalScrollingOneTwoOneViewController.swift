//
//  OrthogonalScrollingOneTwoOneViewController.swift
//  Modern Collection Views
//
//  Created by Don Mag on 1/5/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import UIKit

class OrthogonalScrollingOneTwoOneViewController: UIViewController {

	static let headerElementKind = "header-element-kind"
	
	/// - Tag: OrthogonalBehavior
	enum SectionKind: Int, CaseIterable {
		case continuous, continuousGroupLeadingBoundary, paging, groupPaging, groupPagingCentered, none
		func orthogonalScrollingBehavior() -> UICollectionLayoutSectionOrthogonalScrollingBehavior {
			switch self {
			case .none:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.none
			case .continuous:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuous
			case .continuousGroupLeadingBoundary:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.continuousGroupLeadingBoundary
			case .paging:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.paging
			case .groupPaging:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPaging
			case .groupPagingCentered:
				return UICollectionLayoutSectionOrthogonalScrollingBehavior.groupPagingCentered
			}
		}
	}
	var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
	var collectionView: UICollectionView! = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Orthogonal Section Behaviors"
		configureHierarchy()
		configureDataSource()
	}
}

extension OrthogonalScrollingOneTwoOneViewController {
	
	//   +-----------------------------------------------------+
	//   | +---------------------------------+  +-----------+  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |     1     |  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |           |  |
	//   | |                                 |  +-----------+  |
	//   | |               0                 |                 |
	//   | |                                 |  +-----------+  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |     2     |  |
	//   | |                                 |  |           |  |
	//   | |                                 |  |           |  |
	//   | +---------------------------------+  +-----------+  |
	//   +-----------------------------------------------------+
	
	func createLayout() -> UICollectionViewLayout {
		
		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = 20
		
		let layout = UICollectionViewCompositionalLayout(sectionProvider: {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			guard let sectionKind = SectionKind(rawValue: sectionIndex) else { fatalError("unknown section kind") }
			print(sectionKind, sectionIndex)
			let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
				widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0)),
																 subitem: trailingItem,
																 count: sectionIndex % 2 == 0 ? 1 : 2)
																 //count: 2)
			
			let orthogonallyScrolls = sectionKind.orthogonalScrollingBehavior() != .none
			let containerGroupFractionalWidth = orthogonallyScrolls ? CGFloat(0.45) : CGFloat(1.0)
			let containerGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(containerGroupFractionalWidth),
												   heightDimension: .fractionalHeight(0.4)),
				subitems: [trailingGroup])
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = sectionKind.orthogonalScrollingBehavior()
			
			let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .estimated(44)),
				elementKind: OrthogonalScrollBehaviorViewController.headerElementKind,
				alignment: .top)
			section.boundarySupplementaryItems = [sectionHeader]
			return section
			
		}, configuration: config)
		return layout
	}
}

extension OrthogonalScrollingOneTwoOneViewController {
	func configureHierarchy() {
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
		collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		collectionView.backgroundColor = .systemBackground
		view.addSubview(collectionView)
		collectionView.delegate = self
	}
	func configureDataSource() {
		
		let cellRegistration = UICollectionView.CellRegistration<TextCell, Int> { (cell, indexPath, identifier) in
			// Populate the cell with our item description.
			cell.label.text = "\(indexPath.section), \(indexPath.item)"
			cell.contentView.backgroundColor = .cornflowerBlue
			cell.contentView.layer.borderColor = UIColor.black.cgColor
			cell.contentView.layer.borderWidth = 1
			cell.contentView.layer.cornerRadius = 8
			cell.label.textAlignment = .center
			cell.label.font = UIFont.preferredFont(forTextStyle: .title1)
		}
		
		dataSource = UICollectionViewDiffableDataSource<Int, Int>(collectionView: collectionView) {
			(collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
			// Return the cell.
			return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
		}
		
		let supplementaryRegistration = UICollectionView.SupplementaryRegistration
		<TitleSupplementaryView>(elementKind: OrthogonalScrollBehaviorViewController.headerElementKind) {
			(supplementaryView, string, indexPath) in
			let sectionKind = SectionKind(rawValue: indexPath.section)!
			supplementaryView.label.text = "." + String(describing: sectionKind)
		}
		
		dataSource.supplementaryViewProvider = { (view, kind, index) in
			return self.collectionView.dequeueConfiguredReusableSupplementary(
				using: supplementaryRegistration, for: index)
		}
		
		// initial data
		var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
		var identifierOffset = 0
		let itemsPerSection = 18
		SectionKind.allCases.forEach {
			snapshot.appendSections([$0.rawValue])
			let maxIdentifier = identifierOffset + itemsPerSection
			snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
			identifierOffset += itemsPerSection
		}
		dataSource.apply(snapshot, animatingDifferences: false)
	}
}

extension OrthogonalScrollingOneTwoOneViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
}
