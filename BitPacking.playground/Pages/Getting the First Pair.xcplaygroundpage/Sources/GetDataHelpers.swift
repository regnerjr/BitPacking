import Foundation

public func readDataFromFile(inputName: String?) -> NSData? {

    if let fileName = inputName, inputHandle = NSFileHandle(forReadingAtPath: fileName) {
        let data = inputHandle.readDataToEndOfFile()
        if data.length > 0 {
            return data
        } else {
            print("ERROR: Data was Empty")
        }
    }
    print("ERROR: Could not read file at path: \(inputName)")
    return nil
}

public func removeNumberOfBytes(number: Int, fromData data: NSData?) -> NSData? {

    switch data{
    case .Some(let theData):
        let range = NSRange(location: number, length: theData.length - number)
        return theData.subdataWithRange(range)
    case .None: return nil
    }
}

public func getSequenceNumberFromData(data: NSData?) -> Int?{

    switch data {
    case .Some(let data):
        var seq: UInt16 = 0
        data.getBytes(&seq, length: 2)
        return Int(seq.byteSwapped)
    case .None: return nil
    }
    
}
