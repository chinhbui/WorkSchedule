//
//  EmployeeVC.swift
//  WorkSchedule
//
//  Created by sp on 12/26/18.
//  Copyright © 2018 sp. All rights reserved.
//

import Foundation
import DateToolsSwift
import SnapKit
enum PickDate {
    case START
    case END
}
class EmployeeVC: UIViewController {
    var onSaveSchedule : ((_ employee:Employee,_ start:Date,_ end:Date) -> Void)?
    lazy var pickDateState : PickDate = {
        return .START
    }()
    var startDate = Date() {
        didSet {
            let stringHour = startDate.hour < 10 ? "0" + String(startDate.hour) : String(startDate.hour)
            let stringMinute = startDate.minute < 10 ? "0" + String(startDate.minute) : String(startDate.minute)
            startButton.setTitle(stringHour+":"+stringMinute, for: .normal)
            endDate = startDate.add(TimeChunk.dateComponents(minutes: 30))
        }
    }
    var endDate = Date(){
        didSet {
            let stringHour = endDate.hour < 10 ? "0" + String(endDate.hour) : String(endDate.hour)
            let stringMinute = endDate.minute < 10 ? "0" + String(endDate.minute) : String(endDate.minute)
            endButton.setTitle(stringHour+":"+stringMinute, for: .normal)
        }
    }
    var employeeName : String? {
        didSet {
            self.navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }
    let topPadding = 45
    let timePicker = UIDatePicker()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView ()
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.tableFooterView = UIView()
        
        
        tableView.registerCell(withType: EmployeeCell.self)
        self.view.addSubview(tableView)
        tableView.fillSuperview(left: 0, right: 0, top: 100, bottom: 10)
        return tableView
    }()
    
    lazy var employeeDataSource = EmployeeDataSource()
    lazy var startButton : UIButton = {
        let btn = UIButton()
        self.view.addSubview(btn)
        
        btn.snp.makeConstraints({ (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 80, height: 44))
        })
        btn.addTarget(self, action: #selector(EmployeeVC.openTimePicker), for: .touchUpInside)
        
        btn.backgroundColor = .red
        return btn
    }()
    lazy var endButton : UIButton = {
        let btn = UIButton()
        self.view.addSubview(btn)
        btn.snp.makeConstraints({ (make) in
            make.right.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 80, height: 44))
        })
        btn.addTarget(self, action: #selector(EmployeeVC.openTimePicker), for: .touchUpInside)
        
        btn.backgroundColor = .green
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.dataSource = employeeDataSource
        tableView.reloadData()
        
        //let zeroDate = Date(dateString: "00:00", format: "HH:mm", timeZone: TimeZone.ReferenceType.default)
        let now = Date()
        let zeroDate = Date(year: now.year, month: now.month, day: now.day, hour: 0, minute: 0, second: now.second)
        startDate = zeroDate
        endDate = zeroDate.add(TimeChunk.dateComponents(minutes: 30))
        
        let left = UIBarButtonItem(title: "CLOSE", style: .plain, target: self, action: #selector(closeAction(send:)) )
        self.navigationItem.leftBarButtonItem = left
        let right = UIBarButtonItem(title: "SAVE", style: .plain, target: self, action: #selector(saveAction(send:)) )
        self.navigationItem.rightBarButtonItem = right
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        self.edgesForExtendedLayout = []
        
        let cellAction = NSNotification.Name(rawValue: "CellAction")
        NotificationCenter.default.addObserver(self, selector: #selector(onActionEvent(n:)), name: cellAction, object: nil)
    }
    @objc fileprivate func onActionEvent(n: Notification) {
        if let name = n.userInfo?["EmployeeName"] as? String {
            employeeName = name
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func closeAction(send: AnyObject?) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func saveAction(send: AnyObject?) {
        if let name = employeeName {
            onSaveSchedule?(Employee(name: name, imageName: "", selected: false), startDate, endDate)
        }
        self.dismiss(animated: true, completion: nil)
    }
    @objc func openTimePicker(sender:Any?)  {
        if let btn = sender as? UIButton {
            if btn == startButton {
                pickDateState = .START
            } else {
                pickDateState = .END
            }
        }
        timePicker.removeFromSuperview()
        timePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        timePicker.minuteInterval = 30
        timePicker.frame = CGRect(x: 0.0, y: (self.view.frame.height - 150.0), width: self.view.frame.width, height: 150.0)
        timePicker.backgroundColor = UIColor.white
        self.view.addSubview(timePicker)
        timePicker.addTarget(self, action: #selector(EmployeeVC.startTimeDiveChanged), for: UIControl.Event.valueChanged)
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timePicker.removeFromSuperview()
        switch pickDateState {
        case .START:
            startDate = sender.date
        case .END :
            endDate = sender.date
        }
    }
    
}
