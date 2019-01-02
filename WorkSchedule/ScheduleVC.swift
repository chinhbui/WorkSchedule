//
//  ViewController.swift
//  WorkSchedule
//
//  Created by sp on 12/24/18.
//  Copyright © 2018 sp. All rights reserved.
//

import UIKit
import DateToolsSwift
var data = [["Breakfast at Tiffany's",
             "New York, 5th avenue"],
            
            ["Workout",
             "Tufteparken"],
            
            ["Meeting with Alex",
             "Home",
             "Oslo, Tjuvholmen"],
            
            ["Beach Volleyball",
             "Ipanema Beach",
             "Rio De Janeiro"],
            
            ["WWDC",
             "Moscone West Convention Center",
             "747 Howard St"],
            
            ["Google I/O",
             "Shoreline Amphitheatre",
             "One Amphitheatre Parkway"],
            
            ["✈️️ to Svalbard ❄️️❄️️❄️️❤️️",
             "Oslo Gardermoen"],
            
            ["💻📲 Developing CalendarKit",
             "🌍 Worldwide"],
            
            ["Software Development Lecture",
             "Mikpoli MB310",
             "Craig Federighi"],
            
]

var colors = [UIColor.blue,
              UIColor.yellow,
              UIColor.green,
              UIColor.red]

class ScheduleVC: DayViewController {
    var events : [Event] = [Event]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let style = CalendarStyle()
        style.timeline.dateStyle = .twentyFourHour
        style.timeline.timeIndicator.color = .clear
        dayView.updateStyle(style)
        
        let right = UIBarButtonItem(title: "NEW", style: .plain, target: self, action: #selector(addAction(send:)) )
        self.navigationItem.rightBarButtonItem = right
        
    }
    @objc func addAction(send: AnyObject?) {
        let vc = EmployeeVC()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .currentContext
        self.navigationController?.present(nav, animated: true, completion: nil)
        vc.onSaveSchedule  = { [weak self] employee, start, end in
            guard let `self` = self else { return }
            let event = Event()
            event.startDate = start
            event.endDate = end
            event.text = employee.name
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            self.events.append(event)
            self.reloadData()
        }
    }
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        return events
        /*
        var date = date.add(TimeChunk.dateComponents(hours: 2))
        date.minute(30)
        var events = [Event]()
        
        for i in 0...4 {
            date = date.add(TimeChunk.dateComponents(hours: 1 + i))
            date.minute(i%2 == 0 ? 0:30)
            let event = Event()
            let duration = 60
            let datePeriod = TimePeriod(beginning: date,
                                        chunk: TimeChunk.dateComponents(minutes: duration))
            
            event.startDate = datePeriod.beginning!
            event.endDate = datePeriod.end!
            
            var info = data[Int(arc4random_uniform(UInt32(data.count)))]
            
            let timezone = TimeZone.ReferenceType.default
            info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
            info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
            event.text = info.reduce("", {$0 + $1 + "\n"})
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            event.isAllDay = false
            
            // Event styles are updated independently from CalendarStyle
            // hence the need to specify exact colors in case of Dark style
            event.backgroundColor = event.color.withAlphaComponent(0.6)
            
            events.append(event)
            
            let nextOffset = Int(arc4random_uniform(250) + 40)
            date = date.add(TimeChunk.dateComponents(minutes: nextOffset))
            event.userInfo = String(i)
        }
        return events
        */
    }
    // MARK: DayViewDelegate
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been selected: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayView(dayView: DayView, willMoveTo date: Date) {
        print("DayView = \(dayView) will move to: \(date)")
    }
    
    override func dayView(dayView: DayView, didMoveTo date: Date) {
        print("DayView = \(dayView) did move to: \(date)")
    }
    
}

