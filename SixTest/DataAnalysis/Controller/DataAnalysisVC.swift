//
//  DataAnalysisVC.swift
//  SixTest
//
//  Created by IMAC on 2017/5/29.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJRefresh

class DataAnalysisVC: UIViewController {

    // MARK: 懒加载
    lazy var viewModel:DataAnalysisViewModel = DataAnalysisViewModel()
    
    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
 
        let frame  = CGRect(x: 0, y: 64, width: ScreenWidth, height: ScreenHeight - 64 - 49)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(HotDataCell.self, forCellWithReuseIdentifier: "HotDataCell")
        collectionView.register(DataYypeCell.self, forCellWithReuseIdentifier: "DataYypeCell")
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        return collectionView
    }()
    
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel.loadHotData()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
        title = "资料库"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        collectionView.delegate = viewModel
        collectionView.dataSource = viewModel
        collectionView.mj_footer = MJRefreshAutoFooter(refreshingBlock: {
            [weak self] () in
            self?.viewModel.pageNum += 1
            self?.viewModel.loadTypeData()
        })
        viewModel.superVC = self
        viewModel.collectionView = collectionView
        view.addSubview(collectionView)
    }
    
    // MARK: Target方法
    
    // MARK: HTTP请求
    
    // MARK: 代理和协议

}

 
