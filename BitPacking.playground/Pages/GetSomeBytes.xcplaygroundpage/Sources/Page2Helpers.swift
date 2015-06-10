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