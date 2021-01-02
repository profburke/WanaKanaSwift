import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(WanaKanaClassificationTests.allTests),
        testCase(WanaKanaConversionTests.allTests),
    ]
}
#endif
