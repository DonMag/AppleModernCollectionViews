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
    func origcreateLayout() -> UICollectionViewLayout {
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
	
	func pcreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			let leadingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
												   heightDimension: .fractionalHeight(1.0)))
			leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			
			let trailingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.3)))
			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			let trailingGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: trailingItem, count: 3)
			
			let containerGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(3.0),
												   heightDimension: .fractionalHeight(0.4)),
				subitems: [trailingGroup, trailingGroup, leadingItem])
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	func bcreateLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout {
			(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			print(self.collectionView.numberOfItems(inSection: 0))
			
			let nItems = self.collectionView.numberOfItems(inSection: 0)
			
			let num3: Int = nItems / 3

			let fWidth: CGFloat = 1.0 / CGFloat(num3 + 1)
			
			let trailingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth), //(0.33),
												   heightDimension: .fractionalHeight(1.0)))
			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			
			let leadingItem = NSCollectionLayoutItem(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(0.3)))
			leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
			
			let leadingGroup = NSCollectionLayoutGroup.vertical(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: leadingItem, count: 3)
			
			let n3leadingGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(fWidth * CGFloat(num3)),
												   heightDimension: .fractionalHeight(1.0)),
				subitem: leadingGroup, count: num3)

			let containerGroup = NSCollectionLayoutGroup.horizontal(
				layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(CGFloat(num3 + 1)),
												   heightDimension: .fractionalHeight(0.4)),
				subitems: [n3leadingGroup, trailingItem])
			let section = NSCollectionLayoutSection(group: containerGroup)
			section.orthogonalScrollingBehavior = .continuous
			
			return section
			
		}
		return layout
	}
	
	func createLayout() -> UICollectionViewLayout {
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
/*
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
		let itemsPerSection = 13
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
