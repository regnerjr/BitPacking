//: [Previous](@previous)

import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "dat")
let data = readDataFromFile(path)

let newData = removeNumberOfBytes(2, fromData: data) // remove the 2 unused bytes

/*:
The next thing in the data format is the Sequence Number.

The sequence number is in the next two bytes. Lets grab the next two bytes and save them then drop the 2 bytes from the data. 

    func getSequenceNumberFromData(data: NSData?) -> (NSData, Int)

*/



//: [Next](@next)
