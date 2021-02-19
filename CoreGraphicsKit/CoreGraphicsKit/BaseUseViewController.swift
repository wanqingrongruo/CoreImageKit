//
//  BaseUseViewController.swift
//  Created on 2021/2/19
//  Description <#文件描述#>

import UIKit

class BaseUseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "基本使用"
        view.backgroundColor = .white
        configureUI()
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
}

extension BaseUseViewController {
    func configureUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
}

class PathView: UIView {
    // 利用 UIView 的 layer graphics context 进行绘制操作
    // layer graphics context 只能从 draw() 方法中获取, 不能自己创建
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 1. 获取上下文对象
        let context = UIGraphicsGetCurrentContext()
        
        // 2. 创建并设置路径
        // 法 1: 通过 path 创建路径
        
    }
}
