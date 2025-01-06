//
//  OrthogonalScrollingStepsViewController.swift
//  Modern Collection Views
//
//  Created by Don Mag on 1/6/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import UIKit

class OrthogonalScrollingStepsViewController: UIViewController {

	static let headerElementKind = "header-element-kind"
	
	var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
	var collectionView: UICollectionView! = nil
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.title = "Layout Steps"
		configureHierarchy()
		configureDataSource()
	}
}

extension OrthogonalScrollingStepsViewController {
	
	// MARK: Steps to change this:
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

	// MARK: to this:
	//   +------------------------------+                  These would be off-screen
	//   | +-------------------------+  |  +-------------------------+  +-------------------------+
	//   | |            1            |  |  |            4            |  |                         |
	//   | +-------------------------+  |  +-------------------------+  |                         |
	//   | +-------------------------+  |  +-------------------------+  |                         |
	//   | |            2            |  |  |            5            |  |            7            |
	//   | +-------------------------+  |  +-------------------------+  |                         |
	//   | +-------------------------+  |  +-------------------------+  |                         |
	//   | |            3            |  |  |            6            |  |                         |
	//   | +-------------------------+  |  +-------------------------+  +-------------------------+
	//   |                              |
	//   |                              |
	//   |                              |
	//   |     rest of the screen       |
	//   |                              |
	//   |                              |
	//   |                              |
	//   |                              |
	//   +------------------------------+

	
	func createLayout() -> UICollectionViewLayout {
		
		let config = UICollectionViewCompositionalLayoutConfiguration()
		config.interSectionSpacing = 20
		
		let layout = UICollectionViewCompositionalLayout(sectionProvider: {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			var section: NSCollectionLayoutSection!
			
			switch sectionIndex {
			case 1:
				// original layout
				// let's rename "leadingItem" to "singleItem"
				let singleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// let's rename "trailingItem" to "doubleItem"
				let doubleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					// when we're putting more than one item in a vertical group,
					// fractional height doesn't effect the layout ?!?!?!?
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				doubleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// let's rename "trailingGroup" to "doubleVerticalGroup"
				let doubleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 doubleItems, arranged vertically
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: doubleItem, count: 2)
				
				// let's rename "containerGroup" to "repeatingGroup"
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 "elements" arranged horiztonally ...
					//	singleItem followed by doubleVerticalGroup
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [singleItem, doubleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)
				
			case 2:
				// swap the order from
				//	1:2 1:2
				// to
				//	2:1 2:1
				let singleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// let's rename "trailingItem" to "doubleItem"
				let doubleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					// when we're putting more than one item in a vertical group,
					// fractional height doesn't effect the layout ?!?!?!?
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				doubleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// let's rename "trailingGroup" to "doubleVerticalGroup"
				let doubleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 doubleItems, arranged vertically
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: doubleItem, count: 2)
				
				// let's rename "containerGroup" to "repeatingGroup"
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 "elements" arranged horiztonally ...
					//	swap the order, so it is now doubleVerticalGroup followed by singleItem
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [doubleVerticalGroup, singleItem])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)
				
			case 3:
				// embed singleItem in singleVerticalGroup
				// we're going to put "singleItem" in a "singleVerticalGroup"
				//	so we change Width to 100%
				let singleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// no change to "doubleItem"
				let doubleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				doubleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// note that "singleItem" and "doubleItem" are now the same - we'll change that in the next step
				
				// let's create a "singleVerticalGroup" - based on "doubleVerticalGroup"
				let singleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 1 singleItem (count: 1), arranged vertically
					// width of this group is what the singleItem width used to be
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 1)
				
				// no change to "doubleVerticalGroup"
				let doubleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 doubleItems, arranged vertically
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: doubleItem, count: 2)
				
				// let's change "repeatingGroup" from
				//	[doubleVerticalGroup, singleItem]
				// to
				//	[doubleVerticalGroup, singleVerticalGroup]
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 "groups" arranged horiztonally ...
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [doubleVerticalGroup, singleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)

			case 4:
				// change repeating group to doubleVerticalGroup, doubleVerticalGroup, singleVerticalGroup
				// we're going to put "singleItem" in a "singleVerticalGroup"
				//	so we change Width to 100%
				let singleItem = NSCollectionLayoutItem(
					// width is percentage of "parent"
					// height is percentage of "parent"
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// because "singleItem" and "doubleItem" became identical,
				//	we don't need "doubleItem" anymore
				
				// here's our "singleVerticalGroup"
				let singleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 1 singleItem, arranged vertically
					// width of this group is what the singleItem width used to be
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 1)
				
				// our "doubleVerticalGroup" now contains 2 "singleItem" elements
				let doubleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is 2 singleItems, arranged vertically
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 2)
				
				// let's change "repeatingGroup" from
				//	[doubleVerticalGroup, singleVerticalGroup]
				// to
				//	[doubleVerticalGroup, doubleVerticalGroup, singleVerticalGroup]
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is now 3 "groups" arranged horiztonally ...
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [doubleVerticalGroup, doubleVerticalGroup, singleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)

			case 5:
				// fix element widths
				let singleItem = NSCollectionLayoutItem(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				// because we're putting 3 elements into our repeating group, instead of 2,
				//	we need to change the relative width of our groups
				//	from 70%, 30%
				//	to 33%, 33%, 33%
				
				let fWidth: CGFloat = 1.0 / 3.0
				
				let singleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width of this group is now 1/3
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 1)
				
				let doubleVerticalGroup = NSCollectionLayoutGroup.vertical(
					// width of this group is now 1/3
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 2)
				
				// no change to "repeatingGroup"
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is now 3 "groups" arranged horiztonally ...
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [doubleVerticalGroup, doubleVerticalGroup, singleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)

			case 6:
				// change "columns" from 2 items to 3 items
				let singleItem = NSCollectionLayoutItem(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				let fWidth: CGFloat = 1.0 / 3.0
				
				let singleVerticalGroup = NSCollectionLayoutGroup.vertical(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 1)
				
				// we want 3 elements arranged vertically,
				//	so let's rename this for readability
				//	and change count from 2 to 3
				let tripleVerticalGroup = NSCollectionLayoutGroup.vertical(
					//	subitem is 3 singleItems, arranged vertically
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 3)
				
				// no change to "repeatingGroup"
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					// width is percentage of "parent"
					// height is percentage of "parent"
					//	subitem is now 3 "groups" arranged horiztonally ...
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [tripleVerticalGroup, tripleVerticalGroup, singleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)
				
			case 0, 7:
				// each element in repeating group should fill width
				let singleItem = NSCollectionLayoutItem(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
													   heightDimension: .fractionalHeight(1.0)))
				
				singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
				
				let fWidth: CGFloat = 1.0 / 3.0
				
				let singleVerticalGroup = NSCollectionLayoutGroup.vertical(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 1)
				
				let tripleVerticalGroup = NSCollectionLayoutGroup.vertical(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
													   heightDimension: .fractionalHeight(1.0)),
					subitem: singleItem, count: 3)
				
				// to make each group fill the width of the frame,
				//	we need to set repeatingGroup Width to 3 x 100%
				let repeatingGroup = NSCollectionLayoutGroup.horizontal(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(3.0),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [tripleVerticalGroup, tripleVerticalGroup, singleVerticalGroup])
				
				section = NSCollectionLayoutSection(group: repeatingGroup)

			default:
				fatalError("No layout defined for Section \(sectionIndex)!")
			}

			let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .estimated(44)),
				elementKind: OrthogonalScrollBehaviorViewController.headerElementKind,
				alignment: .top)
			section.boundarySupplementaryItems = [sectionHeader]
			
			section.orthogonalScrollingBehavior = .continuous
			return section

		}, configuration: config)
		return layout
	}
}

extension OrthogonalScrollingStepsViewController {
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
			let titles: [String] = [
				"Target Layout - scroll horizontally to see 3:3:1",
				"Original Layout - 1:2",
				"Swap the Order - 2:1",
				"Embed singleItem (no visible change)",
				"Double Double Single",
				"Fix Element Widths",
				"Change \"columns\" from 2 items to 3 items",
				"Final: Each Element in repeating group fills width",
			]
			supplementaryView.label.text = titles[indexPath.section]
		}
		
		dataSource.supplementaryViewProvider = { (view, kind, index) in
			return self.collectionView.dequeueConfiguredReusableSupplementary(
				using: supplementaryRegistration, for: index)
		}
		
		// initial data
		var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
		var identifierOffset = 0
		let itemsPerSection = 18
		for i in 0..<8 {
			snapshot.appendSections([i])
			let maxIdentifier = identifierOffset + itemsPerSection
			snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
			identifierOffset += itemsPerSection
		}
		dataSource.apply(snapshot, animatingDifferences: false)
	}
}

extension OrthogonalScrollingStepsViewController: UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		collectionView.deselectItem(at: indexPath, animated: true)
	}
}
