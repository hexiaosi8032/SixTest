//
//  SelectPickView.swift
//  SixTest
//
//  Created by IMAC on 2017/6/2.
//  Copyright © 2017年 小四. All rights reserved.
//

import UIKit

enum pickViewType {
    case pickViewTypeDate//时间选择器
    case pickViewTypeNormal//普通选择器
}

typealias PickerSelectBlock = (Any) ->()
typealias PickerDismissBlock = () ->()

class SelectPickView: UIView {

    private enum ButtonType:Int {
        case buttonTypeCancel = 0 //取消按钮
        case buttonTypeDone  = 1//完成按钮
    }
    
    var maximumDate:Date? {
        didSet{
            datePicker.maximumDate = maximumDate
        }
    }
    
    var dataArray = [Any]()
    //设置的选择控制器类型,0是date时间选择器,1是normol普通选择器
    private var pickViewType:pickViewType = .pickViewTypeNormal
    private var normolPicker:UIPickerView!
    private var datePicker:UIDatePicker!
    private var midShowStr:NSString = ""
    
    private var pickerBgView:UIView!
    private var selecteDate:String = "" {
        didSet{
            
        }
    }
    
    var rightBlock:PickerSelectBlock?
    var dismissBlock:PickerDismissBlock?
    
    
    // MARK: 懒加载
    
    // MARK: 初始化和生命周期
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("PickView销毁")
    }
    
    init(race:CGRect,type:pickViewType,dataArr:Array<Any>,midShowString:String) {
        
        super.init(frame: race)
        
        self.frame = frame;
        
        pickViewType = type
        dataArray = dataArr
        midShowStr = midShowString as NSString
        
        initPickerView()
        
    }
    
    // MARK: 自定义方法
    private func initPickerView() -> () {
        
        let toolbar = UIToolbar(frame:bounds)
        toolbar.barStyle = .default
        toolbar.alpha = 0.5
        addSubview(toolbar)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(removePicker))
        toolbar.addGestureRecognizer(tap)
        
        let x:CGFloat = 0
        let y:CGFloat = frame.size.height
        let w:CGFloat = frame.size.width
        let h:CGFloat = UIScreen.main.bounds.width * 0.6
        pickerBgView = UIView(frame: CGRect(x: x, y: y, width: w, height: h))
        
        addSubview(pickerBgView)
        
        if (pickViewType == .pickViewTypeDate){
            
            initDatePicker()
            getlocalTime()//初始化当前时间日期
            
        }else if (pickViewType == .pickViewTypeNormal){
            
            iniNormolPicker()
            
        }
        
        initPickerHeadView()
        
        UIView.animate(withDuration: 0.3, animations: {
            
            self.pickerBgView.frame.origin.y -= self.pickerBgView.frame.size.height
            
        }, completion: nil)
        
    }
    
    private func initPickerHeadView(){
        let head = UIView()
        head.frame = CGRect(x: 0, y: 0, width: pickerBgView.frame.size.width, height: pickerBgView.frame.size.height * 0.2)
        head.backgroundColor = UIColorFromRGB(rgbValue: 0xeeeeee)
        
        
        let typeSize = midShowStr.size(attributes: [NSFontAttributeName : adoptedFont(fontSize: 16)])
        let typeLbl = UILabel(frame: CGRect(x: 0, y: 0, width: ScreenWidth * 0.5, height: ScreenWidth * 0.12))
        typeLbl.font = adoptedFont(fontSize: 16)
        typeLbl.text = midShowStr as String
        typeLbl.textColor = UIColorFromRGB(rgbValue: 0x434343)
        typeLbl.sizeToFit()
        
        let y:CGFloat = (ScreenWidth * 0.12 - typeSize.height)/2 + typeSize.height/2
        typeLbl.center = CGPoint(x: head.center.x, y: y)
        head.addSubview(typeLbl)
        
        let array = ["取消","完成"]
        
        for i in 0..<array.count
        {
            let type:ButtonType = (i == 0) ? .buttonTypeCancel : .buttonTypeDone
            let x:CGFloat = (i == 0) ? ScreenWidth * 0.05 : ScreenWidth * 0.5
            let y:CGFloat = 0
            let width:CGFloat = (i == 0) ? ScreenWidth * 0.45 : ScreenWidth * 0.45
            let height:CGFloat = ScreenWidth * 0.12
            let ract = CGRect(x: x, y: y, width: width, height: height)
            
            let btn = createButtonWithType(buttonType: type, title: array[i], frame: ract)
            head.addSubview(btn)
        }
        
        pickerBgView.addSubview(head)
        
    }
    
    private func createButtonWithType(buttonType:ButtonType,title:String,frame:CGRect) -> UIButton{
        
        let button:UIButton = UIButton(type: .custom)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = adoptedFont(fontSize: 16)
        button.frame = frame
        
        if buttonType == .buttonTypeDone
        {
            button.contentHorizontalAlignment = .right
            
        }else if buttonType == .buttonTypeCancel{
            button.contentHorizontalAlignment = .left
        }
        
        
        button.tag = 500 + buttonType.hashValue
        button.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
        
        return button
    }
    
    private func iniNormolPicker(){
        normolPicker = UIPickerView(frame: CGRect(x: 0, y: pickerBgView.frame.size.height/6, width: ScreenWidth, height: pickerBgView.frame.size.height * 5/6))
        normolPicker.showsSelectionIndicator = true
        normolPicker.delegate = self
        normolPicker.dataSource = self
        normolPicker.backgroundColor = UIColorFromRGB(rgbValue: 0xe5e5e5)
        pickerBgView.addSubview(normolPicker)
        
    }
    
    
    
    // MARK: 自定义方法
    func initDatePicker() -> () {
        
        datePicker = UIDatePicker(frame: CGRect(x: 0, y: pickerBgView.height / 6, width: ScreenWidth, height: pickerBgView.height * 5 / 6))
        datePicker.datePickerMode = .date;//年月日格式
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        datePicker.backgroundColor = UIColorFromRGB(rgbValue: 0xe5e5e5)
        pickerBgView.addSubview(datePicker)
        
    }
    
    func getlocalTime() -> () {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
//        [formatter setDateFormat:@"yyyy-MM-dd"];
        //    [formatter setDateFormat:@"yyyy年MM月dd日 HH时mm分ss秒"];
        let dateTime = formatter.string(from: date)
        
        selecteDate = dateTime;
        
    }
    
    //转换为本地时间
    func localDate(date:Date) -> Date {
        let zone = NSTimeZone.local
    
        let interval = zone.secondsFromGMT(for: date)
        let localeDate = date.addingTimeInterval(TimeInterval(interval))
        
        return localeDate;
    }
    
    //时间日期date转字符串
    func getDate(date:Date) -> (String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
    @objc private func removePicker() {
        UIView.animate(withDuration: 0.3, animations: {
            
            self.pickerBgView.frame.origin.y += self.pickerBgView.frame.size.height;
        }) { [weak self]
            (finished:Bool)  in
            
            self?.pickerBgView.removeFromSuperview()
            self?.removeFromSuperview()
        }
        
    }
    
    // MARK: Target方法
    func datePickerValueChanged(datePicker:UIDatePicker) -> () {
        let localDate = datePicker.date
        selecteDate = getDate(date: localDate)
    }
    
    @objc private func buttonClick(button:UIButton){
        
        let type:ButtonType = ButtonType(rawValue:button.tag - 500)!
        
        switch type {
        case .buttonTypeCancel:
            removePicker()
            break
            
        case .buttonTypeDone:
            //如果是时间选择器
            if pickViewType == .pickViewTypeDate{
                rightBlock?(selecteDate)
            }else{
                let pIndex = normolPicker.selectedRow(inComponent: 0)
                rightBlock?(dataArray[pIndex])
            }
            
            removePicker()
            break
            
        default:
            break
        }
        
    }
    // MARK: 代理和协议
    
    func changeSpearatorLineColor( )  {
        for speartorView:UIView in normolPicker.subviews
        {
            if speartorView.frame.size.height < 1 //取出分割线
            {
                speartorView.backgroundColor = UIColorFromRGB(rgbValue: 0xbfbfbf)
            }
        }
    }
}

extension SelectPickView:UIPickerViewDelegate,UIPickerViewDataSource {
    //数据源方法 一共有多少列
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //第component列有多少行数据
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataArray.count
    }
    
    //第component列的第row行显示什么文字
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return dataArray[row] as? String
    }
    
    //监听选中了某一列的某一行  选中了第component列的第row行
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    //修改pickerView分割线颜色
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = adoptedFont(fontSize: 18)
        label.text = self.pickerView(pickerView, titleForRow: row, forComponent: component)
        changeSpearatorLineColor()
        return label
    }

}
