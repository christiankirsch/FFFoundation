import XCTest
@testable import FFFoundation

#if !swift(>=3.2)
    func XCTAssertEqual<T>(_ expression1: @autoclosure () throws -> T, _ expression2: @autoclosure () throws -> T, accuracy: T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) where T: FloatingPoint {
        XCTAssertEqualWithAccuracy(expression1, expression2, accuracy: accuracy, message: message, file: file, line: line)
    }
#endif

class TimerTests: XCTestCase {
    
    static let allTests : [(String, (TimerTests) -> () throws -> Void)] = [
        ("testTimerWithShortIntervalAndNoTolerance", testTimerWithShortIntervalAndNoTolerance),
        ("testTimerWithShortIntervalAndTolerance", testTimerWithShortIntervalAndTolerance),
        ("testRepeatingTimerWithShortIntervalAndTolerance", testRepeatingTimerWithShortIntervalAndTolerance)
    ]
    
    var timer: AnyTimer? = nil

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTimerWithShortIntervalAndNoTolerance() {
        let exp = expectation(description: "Timer with short interval and no tolerance")
        var date = Date()
        let timerInterval: TimeInterval = 2.0
        let isMainThread = Thread.isMainThread
        timer = AnyTimer(interval: timerInterval, block: { timer in
            let interval = Date().timeIntervalSince(date)
            XCTAssertEqual(Thread.isMainThread, isMainThread)
            XCTAssertEqual(interval, timerInterval, accuracy: 0.02)
            
            exp.fulfill()
        })
        
        date = Date()
        timer?.schedule()
        waitForExpectations(timeout: timerInterval * 2, handler: nil)
    }
    
    func testTimerWithShortIntervalAndTolerance() {
        let exp = expectation(description: "Timer with short interval and tolerance")
        var date = Date()
        let timerInterval: TimeInterval = 2.0
        let tolerance: TimeInterval = 0.5
        
        timer = AnyTimer(interval: timerInterval, block: { timer in
            let interval = Date().timeIntervalSince(date)
            XCTAssertEqual(interval, timerInterval, accuracy: tolerance)
            exp.fulfill()
        })
        timer?.tolerance = tolerance
        date = Date()
        timer?.schedule()
        waitForExpectations(timeout: timerInterval * 2, handler: nil)
    }
    
    func testRepeatingTimerWithShortIntervalAndTolerance() {
        let exp = expectation(description: "Repeating Timer with short interval and tolerance")
        var date = Date()
        let timerInterval: TimeInterval = 2.0
        let tolerance: TimeInterval = 0.5
        var accuracies = Array<TimeInterval>()
        
        let repeats = 5
        var counter = 0
        timer = AnyTimer(interval: timerInterval, repeats: true, block: { timer in
            let interval = Date().timeIntervalSince(date)
            date = Date()
            accuracies.append(interval)
            counter += 1
            if counter == repeats {
                timer.invalidate()
                exp.fulfill()
            }
        })
        timer?.tolerance = tolerance
        date = Date()
        timer?.schedule()
        waitForExpectations(timeout: timerInterval * TimeInterval(repeats) * 2, handler: nil)
        XCTAssertEqual(counter, repeats)
        XCTAssertEqual(accuracies.count, repeats)
        accuracies.forEach {
            XCTAssertEqual($0, timerInterval, accuracy: tolerance + 0.09)
        }
    }
}
