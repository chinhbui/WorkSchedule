//
//  WorkScheduleTests.swift
//  WorkScheduleTests
//
//  Created by sp on 12/24/18.
//  Copyright © 2018 sp. All rights reserved.
//

import XCTest
@testable import WorkSchedule

class WorkScheduleTests: XCTestCase {
    class DayViewDelegateMock : DayViewDelegate {
        func dayViewDidSelectEventView(_ eventView: EventView) {
        }
        
        func dayViewDidLongPressEventView(_ eventView: EventView) {
        }
        
        func dayViewDidLongPressTimelineAtHour(_ hour: Int) {
        }
        
        func dayView(dayView: DayView, willMoveTo date: Date) {
        }
        
        func dayView(dayView: DayView, didMoveTo date: Date) {
            
        }
    }
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
   
    
    func testDelegateNotRetained() {
        let controller = ScheduleVC()
        
        // Create a strong reference to a delegate object, then
        // assign it as the view controller's delegate
        var delegate = DayViewDelegateMock()
        controller.dayView.delegate = delegate
        
        // Re-assign the strong reference to a new object, which
        // should cause the original object to be released, thus
        // setting the view controller's delegate to nil
        delegate = DayViewDelegateMock()
        XCTAssertNil(controller.dayView.delegate)
    }
    func testTimeStrings24HWorkTimeHalfHour() {
        let timeResult = Generator.timeStrings24HWorkTimeHalfHour2()
        let expectResult = ["08:00",
                            "08:30",
                            "09:00",
                            "09:30",
                            "10:00",
                            "10:30",
                            "11:00",
                            "11:30",
                            "12:00",
                            "12:30",
                            "13:00",
                            "13:30",
                            "14:00",
                            "14:30",
                            "15:00",
                            "15:30",
                            "16:00",
                            "16:30",
                            "17:00",
                            "17:30",
                            "18:00"]
        XCTAssertEqual(timeResult, expectResult)
    }
    func testClosure(){
//        let expect = expectation(description: "Completed")
//        expect.fulfill()
        
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        
        self.measure {
            _ = Generator.timeStrings24HWorkTimeHalfHour2()
        }
    }

}
