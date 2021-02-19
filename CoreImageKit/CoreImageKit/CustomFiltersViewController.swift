//
//  CustomFiltersViewController.swift
//  Created on 2021/1/20
//  Description <#文件描述#>

import UIKit

class CustomFiltersViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "自定义滤镜"
        view.backgroundColor = .white
    }
    
    override func configureItems() {
        items = []
    }
}
