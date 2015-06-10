//: We will be using NSData which is declared in Foundation.
import Foundation

/*:

# Step One

We have been given a file of binary data we need to parse and output as a CSV file.

We can write a simple function for reading the file and returning an `NSData?` containing the contents of the file.

I have placed the Binary file into the Resources folder for this Playground.
*/

/// A simple function which reads a file at a given path and returns the data there
///
/// :param: inputName A path to a file to be read
/// :returns: The data in the file or nil if an error occurs
func readDataFromFile(inputName: String?) -> NSData? {
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

//: Get the path to our Playground/Resources/input.dat
let path = NSBundle.mainBundle().pathForResource("input", ofType: "dat")

// read the file, data: NSData
let data = readDataFromFile(path)
//:[Next Page](@next)
