/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Orthogonal scrolling section example
*/

import UIKit

class OrthogonalScrollingViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Int, Int>! = nil
    var collectionView: UICollectionView! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Orthogonal Sections"
        configureHierarchy()
        configureDataSource()
    }
}

extension OrthogonalScrollingViewController {

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

    /// - Tag: Orthogonal
	///
    func originalCreateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                  heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

			let trailingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.3)))

			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                  heightDimension: .fractionalHeight(1.0)),
                subitem: trailingItem, count: 2)

            let containerGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
                                                  heightDimension: .fractionalHeight(0.4)),
                subitems: [leadingItem, trailingGroup])
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.orthogonalScrollingBehavior = .continuous

            return section

        }
        return layout
    }
	
	// MARK: Steps to change layout to this:
	//
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
	//
	//
	// change desired layout in configureHierarchy()
	//
	
	// MARK: Step 1 - property renaming for clarity
	func step1CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

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

			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 2 - swap order
	func step2CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
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
				//	swap the order, so it is now doubleVerticalGroup followed by singleItem
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
												   heightDimension: .fractionalHeight(0.4)),
				subitems: [doubleVerticalGroup, singleItem])
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 3 - embed singleItem in singleVerticalGroup
	func step3CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
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
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 4 - change repeating group to doubleVerticalGroup, doubleVerticalGroup, singleVerticalGroup
	func step4CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
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
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 5 - fix element widths
	func step5CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
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
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 6 - change "columns" from 2 items to 3 items
	func step6CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
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
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// MARK: Step 7 - each element in repeating group should fill width
	func step7CreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

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
			
			let section = NSCollectionLayoutSection(group: repeatingGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	// experimenting with variable number of items, where desired layout is
	//	all vertical columns of 3 items
	//	with *last* column either 1, 2 or 3 items
	// change:
	//	let itemsPerSection = 7
	// to a larger (or smaller) number to see the results
	func experimentalCreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			print(self.collectionView.numberOfItems(inSection: 0))
			
			let nItems = self.collectionView.numberOfItems(inSection: 0)
			
			let num3: Int = nItems / 3
			let rem: Int = nItems % 3
			let numTotal: Int = num3 + (rem > 0 ? 1 : 0)
			
			let fWidth: CGFloat = 1.0 / CGFloat(numTotal)
			
			let tripleItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.3)))
			tripleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

			let doubleItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.5)))
			doubleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			
			let singleItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(1.0)))
			singleItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

			let tripleGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth * CGFloat(num3)),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: tripleItem, count: 3)
			
			let doubleGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: doubleItem, count: 2)
			
			let singleGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: singleItem, count: 1)
			
			let leadingGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth * CGFloat(num3)),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: tripleGroup, count: num3)
			
			var containerGroup: NSCollectionLayoutGroup!
			
			if rem == 2 {
				containerGroup = NSCollectionLayoutGroup.horizontal(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(numTotal)),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [leadingGroup, doubleGroup])
			} else if rem == 1 {
				containerGroup = NSCollectionLayoutGroup.horizontal(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(numTotal)),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [leadingGroup, singleGroup])
			} else {
				containerGroup = NSCollectionLayoutGroup.horizontal(
					layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(numTotal)),
													   heightDimension: .fractionalHeight(0.4)),
					subitems: [leadingGroup])
			}
			
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}

	func zcreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			let leadingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.30)))
			leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			let leadingGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: leadingItem, count: 3)

			let trailingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(1.0)))
			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			let trailingGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: trailingItem, count: 4)
			
			let containerGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.85),
												   heightDimension: .fractionalHeight(0.4)),
				subitems: [leadingGroup, trailingGroup])
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	

}

extension OrthogonalScrollingViewController {
	func configureHierarchy() {
		// change Layout Step here
		collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: step7CreateLayout())
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
		
		// initial data
		var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
		var identifierOffset = 0
		
		// using just 1 section with 7 items
		let itemsPerSection = 7
		for section in 0..<1 {
			snapshot.appendSections([section])
			let maxIdentifier = identifierOffset + itemsPerSection
			snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
			identifierOffset += itemsPerSection
		}
		dataSource.apply(snapshot, animatingDifferences: false)
	}
}


extension OrthogonalScrollingViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

/*
// original
extension OrthogonalScrollingViewController {
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
		
		// initial data
		var snapshot = NSDiffableDataSourceSnapshot<Int, Int>()
		var identifierOffset = 0
		let itemsPerSection = 30
		for section in 0..<5 {
			snapshot.appendSections([section])
			let maxIdentifier = identifierOffset + itemsPerSection
			snapshot.appendItems(Array(identifierOffset..<maxIdentifier))
			identifierOffset += itemsPerSection
		}
		dataSource.apply(snapshot, animatingDifferences: false)
	}
}
*/
