//
//  ViewController.swift
//  Created on 2021/1/15
//  Description <#文件描述#>

//  Copyright © 2021 Huami inc. All rights reserved.
//  @author zhengwenxiang(zhengwenxiang@huami.com)  

import UIKit

enum Section: Hashable {
    case main
}

enum FilterCategory {
    case none, motionBLur, boxBlur
    
    var filterName: String {
        switch self {
        case .motionBLur:
            return "CIMotionBlur"
        case .boxBlur:
            return "CIBoxBlur"
        default:
            return ""
        }
    }
}

class CICase: Hashable {
    let title: String
    let filterCategoty: FilterCategory
    let destinationViewController: UIViewController.Type?
    init(title: String, filterCategoty: FilterCategory, viewController: UIViewController.Type? = nil) {
        self.title = title
        self.filterCategoty = filterCategoty
        self.destinationViewController = viewController
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifer)
    }
    
    static func == (lhs: CICase, rhs: CICase) -> Bool {
        return lhs.identifer == rhs.identifer
    }
    
    private let identifer = UUID()
}

class ViewController: UIViewController {
    
    var dataSource: UICollectionViewDiffableDataSource<Section, CICase>! = nil
    var collectionView: UICollectionView! = nil
    
    var items: [CICase] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Core Image"
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
            CICase(title: "自带滤镜", filterCategoty: .none, viewController: FiltersViewController.self),
            CICase(title: "自定义滤镜", filterCategoty: .none, viewController: CustomFiltersViewController.self)
        ]
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CICase> { (cell, IndexPath, item) in
            var content = cell.defaultContentConfiguration()
            content.text = item.title
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, CICase>(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, CICase>()
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
