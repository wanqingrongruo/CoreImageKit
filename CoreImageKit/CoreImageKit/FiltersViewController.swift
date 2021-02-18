//
//  FiltersViewController.swift
//  Created on 2021/1/20
//  Description <#文件描述#>

//  Copyright © 2021 Huami inc. All rights reserved.
//  @author zhengwenxiang(zhengwenxiang@huami.com)  

import UIKit

class FiltersViewController: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "自带滤镜"
        view.backgroundColor = .white
    }
    
    override func configureItems() {
        items = [
            creator("动态模糊", .motionBLur),
            creator("盒子模糊", .boxBlur)
        ]
        
        getAllFilters()
    }
    
    func getAllFilters() {
        let keys = [kCICategoryGeometryAdjustment]
        var filters = [String]()
        for key in keys {
            let names = CIFilter.filterNames(inCategory: key)
            filters.append(contentsOf: names)
        }
        
        print(filters)
    }
    
    func creator(_ title: String, _ filterCategoty: FilterCategory) -> CICase {
        return CICase(title: title, filterCategoty: filterCategoty, viewController: FilterResultViewController.self)
    }
}

extension FiltersViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if let viewController = item.destinationViewController as? FilterResultViewController.Type {
            navigationController?.pushViewController(viewController.init(item: item), animated: true)
        }
    }
}
