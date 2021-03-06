//
//  DataAnalysisViewModel.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MJExtension

class DataAnalysisViewModel: NSObject{
    
    fileprivate var topArr = [HotDataModel]()
    fileprivate var bottomArr = [DataTypeModel]()
    var superVC:UIViewController?
    
    var collectionView:UICollectionView?
    
    var pageNum:Int = 1
    
    // MARK: HTTP请求
    func loadHotData() -> () {
        
        let url = kDataHotListPort;
        var parameters = [String:Any]()
        parameters["pageNum"] = (1)
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in
            
            let responseObject = httpModel.data as? NSDictionary ?? [:]
            
            let arr:[HotDataModel] = HotDataModel.mj_objectArray(withKeyValuesArray: responseObject["list"]) as! [HotDataModel]
      
            self?.topArr += arr
            self?.loadTypeData()
        }) { (httpModel:HttpModel) in
            print(httpModel.message ?? "")
        }
        
    }
    
    func loadTypeData() -> () {
        
        let url = kDataTypeListPort;
        var parameters = [String:Any]()
        parameters["pageNum"] = pageNum
        
        HttpNetWorkTools.shareNetWorkTools().postAFNHttp(urlStr: url, parameters: parameters, success: {
            [weak self]
            (httpModel:HttpModel) in

            let responseObject = httpModel.data as? NSDictionary ?? [:]
            
            let arr:[DataTypeModel] = DataTypeModel.mj_objectArray(withKeyValuesArray: responseObject["list"]) as! [DataTypeModel]
            self?.bottomArr += arr
            self?.collectionView?.reloadData()
            self?.collectionView?.mj_footer.endRefreshing()
            if arr.count == 0 {
                self?.collectionView?.mj_footer.endRefreshingWithNoMoreData()
            }
        }) {
            [weak self]
            (httpModel:HttpModel) in
            self?.collectionView?.mj_footer.endRefreshing()
            print(httpModel.message ?? "")
        }
        
    }
    
}

extension DataAnalysisViewModel:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.topArr.count
        }
        return self.bottomArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell:HotDataCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotDataCell", for: indexPath) as! HotDataCell
            cell.model = self.topArr[indexPath.item]
            return cell
        }else{
            let cell:DataYypeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DataYypeCell", for: indexPath) as! DataYypeCell
            cell.model = self.bottomArr[indexPath.item]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: ScreenWidth, height: scaleY(y: 35))
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var view:UICollectionReusableView! = nil
        
        if kind == UICollectionElementKindSectionHeader{
            view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", for: indexPath)
            view.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
          
            var label:UILabel? = view.viewWithTag(10) as? UILabel
            if label == nil {
                label = UILabel.addLabel(fontSize: 12, textColor: UIColorFromRGB(rgbValue: kBlackFontColor))
                label?.tag = 10
                label?.textAlignment = .left
                label?.frame = CGRect(x: scaleX(x: 15), y: scaleY(y: 0), width: scaleX(x: 150), height: scaleY(y: 35))
                view.addSubview(label!)
            }
            label?.text = indexPath.section == 0 ? "精选热门资料" : "资料类别";
        }
        return view!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: ScreenWidth, height: scaleY(y: 45))
        }
        return CGSize(width: ScreenWidth / 2 , height: scaleY(y: 45))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let model = self.topArr[indexPath.item]
//            let vc = DataHtmlVC()
//            vc.titleName = "详情\(model.typeName ?? "")"
//            vc.content = model.content ?? ""
//            superVC?.navigationController?.pushViewController(vc, animated: true)
//
            
            let vc = CommentVC()
            vc.idStr = model.ID ?? "";
            vc.title = "详情\(model.typeName ?? "")"
            vc.h5ContentStr = model.content ?? ""

//            let head = UIView()
//            head.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: 200)
//            head.backgroundColor = UIColor.red
//            vc.headView = label
            superVC?.navigationController?.pushViewController(vc, animated: true)
        }else{
            let model = self.bottomArr[indexPath.item]
            let vc = DataAnalysisListVC()
            vc.title = model.name
            vc.typeId = model.ID
            superVC?.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
