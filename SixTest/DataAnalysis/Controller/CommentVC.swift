//
//  CommentVC.swift
//  SixTest
//
//  Created by IMAC on 2017/7/31.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh

class CommentVC: UIViewController {

    @IBOutlet weak var bottomCons: NSLayoutConstraint!
    @IBOutlet weak var bottomHCons: NSLayoutConstraint!
    @IBOutlet weak var InputView: XSInputView!
    @IBOutlet weak var tabelView: UITableView!
    
    @IBOutlet weak var InputButton: UIButton!
    var idStr:String = ""
    var headView:UIView?
    var h5ContentStr:String?
    // MARK: 懒加载
    lazy var viewModel:CommentViewModel = {
        let viewModel = CommentViewModel()
        viewModel.pageNum = 1
        viewModel.idStr = self.idStr
        viewModel.tabelView = self.tabelView
        viewModel.superVC = self
        viewModel.inputView = self.InputView
        viewModel.inputButton = self.InputButton
        return viewModel
    }()
 
    // MARK: 初始化和生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setupUI()
        
        viewModel.loadMainReplyData()
    }
    
    // MARK: 自定义方法
    func setupUI() -> () {
   
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        
        tabelView.dataSource = viewModel
        tabelView.delegate = viewModel
        tabelView.tableFooterView = UIView(frame: CGRect.zero)
        tabelView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tabelView.tableHeaderView = headView
        
        tabelView.mj_header = MJRefreshNormalHeader(refreshingBlock: { 
            [weak self] in
            self?.viewModel.pageNum = 1
            self?.viewModel.loadMainReplyData()
        })
        
        tabelView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: { 
            [weak self] in
            self?.viewModel.pageNum += 1
            self?.viewModel.loadMainReplyData()
            
        })
        InputView.backgroundColor = UIColorFromRGB(rgbValue: kBackGroundColor)
        InputView.delegate = viewModel
        InputView.placeholder = "写几句吧"
        InputView.placeholderColor = UIColor.lightGray
        
        self.bottomHCons.constant = 300;
        // 监听文本框文字高度改变
        InputView.xs_textHeightChangeBlock = {
            (text:String,textHeight:CGFloat) -> Void in
            self.bottomHCons.constant = textHeight + 10
        }
        InputView.maxNumberOfLines = 4
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardChanged),
                                               name: NSNotification.Name.UIKeyboardWillChangeFrame,
                                               object: nil)
        if let h5Str = self.h5ContentStr{
            let hud = MBProgressHUD.showAdded(to:view, animated: true)
            hud.label.text = "正在加载中..."
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                guard let attStr = try? NSMutableAttributedString(data:h5Str.data(using: .unicode)!, options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil) else {
                    return
                }
                let label = UILabel()
                label.attributedText = attStr
                label.numberOfLines = 0
                label.sizeToFit()
                self.tabelView.tableHeaderView = label
                hud.hide(animated: true)
            }
            
        }
        
    }
    
    func keyboardChanged(no:NSNotification){
        guard let endFrame = (no.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = (no.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue
            else {
                return
        }
//        self.view.frame.origin.y = endFrame.origin.y != ScreenHeight ? -endFrame.size.height : 0
        bottomCons.constant = endFrame.origin.y != ScreenHeight ? endFrame.size.height : 0
 
        UIView.animate(withDuration: duration) { 
            self.view.layoutIfNeeded()
        }
    }
 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: Target方法
    
    @IBAction func commit(_ sender: Any) {
        if InputView.text.characters.count == 0 {
            return
        }
        viewModel.saveReplyData()
        InputView.textDidChange()
    }
    
    @IBAction func inputBtnClick(_ sender: Any) {
        viewModel.isClickTag = 1000
        InputButton.isHidden = true
        InputView.becomeFirstResponder()
    }
    // MARK: HTTP请求
    
    // MARK: 代理和协议
}
