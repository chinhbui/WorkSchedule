import Foundation
import DateToolsSwift
enum Generator {
  static func timeStrings24H() -> [String] {
    var numbers = [String]()
    numbers.append("00:00")

    for i in 1...24 {
      let i = i % 24
      var string = i < 10 ? "0" + String(i) : String(i)
      string.append(":00")
      numbers.append(string)
    }

    return numbers
  }

  static func timeStrings12H() -> [String] {
    var numbers = [String]()
    numbers.append("12")

    for i in 1...11 {
      let string = String(i)
      numbers.append(string)
    }

    var am = numbers.map { $0 + " AM" }
    var pm = numbers.map { $0 + " PM" }
    am.append("Noon")
    pm.removeFirst()
    pm.append(am.first!)
    return am + pm
  }
}
extension Generator {
    static func timeStrings24HWorkTimeHalfHour() -> [String] {
        var numbers = [String]()
        var date = Date(dateString: "00:00", format: "HH:mm", timeZone: TimeZone.ReferenceType.default)
        numbers.append(date.format(with: "HH:mm"))
        
        let timeSegmentTotal = 47
        for _ in 1...timeSegmentTotal {
            date = date.add(TimeChunk.dateComponents(minutes: 30))
            numbers.append(date.format(with: "HH:mm"))
        }
        numbers.append("24:00")
        return numbers
    }
    static func timeStrings24HWorkTimeHalfHour2() -> [String] {
        var numbers = [String]()
        numbers.append("00:00")
        numbers.append("00:30")
        var hourStep = 0
        var minuteStep = 0
        for i in 1...47 {
            print("\(i)")
            hourStep = hourStep + (i%2 == 0 ? 0: 1)
            print("hourStep \(hourStep)")
            minuteStep = i%2 == 0 ? 30:0
            let hourText = String(format: "%d", hourStep)
            let minuteText = String(format: "%d", minuteStep)
            numbers.append(String(format: "%@:%@",hourText,minuteText))
            
        }
        return numbers
    }
}
