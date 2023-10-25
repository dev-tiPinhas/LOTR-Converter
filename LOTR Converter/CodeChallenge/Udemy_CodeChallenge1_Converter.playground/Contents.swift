import UIKit

// Complete a function to convert the given Int value to a Double, and then divide it by 3 and return a String of the result.

// The returned String should only contain digits after the decimal place if they are something other than 0, and it should not return more than two digits after the decimal place.

// Your solution should work for positive and negative numbers.

// Any cases that have no possible solution should just return an empty string.


// - Example 1:
//
//Given Int: 9
//
//Converted Double: 9.0
//
//Divided by three: 3.0
//
//Returned String: "3"


// - Example 2:
//
//Given Int: 5
//
//Converted Double: 5.0
//
//Divided by three: 1.666666667
//
//Returned String: "1.67"
                                                                            
                                                                            
func convert(_ intValue: Int) -> String {
    guard intValue != 0 else { return "" }
    let n = 3.0
    let isMultipleNumber = intValue.isMultiple(of: Int(n))
    let doubleValue = Double(intValue).rounded(.up)
    let divisionValue = doubleValue / n
    let rounded = (divisionValue * 100).rounded() / 100
    
    if isMultipleNumber {
        return String(format: "%.0f", rounded)
    } else {
        return String(format: "%.2f", rounded)
    }
}

convert(1)

convert(5)

convert(-5)
