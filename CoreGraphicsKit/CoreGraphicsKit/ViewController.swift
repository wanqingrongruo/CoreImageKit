//
//  ViewController.swift
//  Created on 2021/1/15
//  Description <#文件描述#>

import UIKit

enum Section: Hashable {
    case main
}

class CGCase: Hashable {
    let title: String
    let destinationViewController: UIViewController.Type?
    init(title: String, viewController: UIViewController.Type? = nil) {
        self.title = title
        self.destinationViewController = viewController
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifer)
    }
    
    static func == (lhs: CGCase, rhs: CGCase) -> Bool {
        return lhs.identifer == rhs.identifer
    }
    
    private let identifer = UUID()
}

class ViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CGCase>! = nil
    var collectionView: UICollectionView! = nil
    
    var items: [CGCase] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Core Graphics"
        configureHierarchy()
        configureItems()
        configureDataSource()
    }
}

extension ViewController {
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(collectionView)
        collectionView.delegate = self
    }
    
    @objc func configureItems() {
        items = [
            CGCase(title: "基础", viewController: BaseUseViewController.self)
        ]
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CGCase> { (cell, IndexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, CGCase>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CGCase>()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let viewController = item.destinationViewController {
            navigationController?.pushViewController(viewController.init(), animated: true)
        }
    }
}

