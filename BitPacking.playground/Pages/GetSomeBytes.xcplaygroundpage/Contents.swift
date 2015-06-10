//: [Previous](@previous)
import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "dat")

/*:
# The Data Format

The problem states that the data will be given in a repeating pattern.

1. Ignore 2 bytes. 
2. A 2 byte Sequence Number.
3. 18 bytes of x,y,z coordinates

Let's look at the first two bytes
*/

let data = readDataFromFile(path)

/*:
If we look in the side panel here we can see the first few bytes of data.

It looks like `<93da1372`
These numbers are the contents of our NSData represented as Hexidecimal numbers.

So the first 2 bytes we are going to ignore are:  `93 da`

## Lets write a function to do this.

It should take an NSData and remove the first 2 bytes from it and return us the rest of the data. 
    
    func removeTwoBytes(theData: NSData?) -> NSData?

`NSData` has a great function which we can use here `NSData.subdataWithRange(range:NSRange)`

We will pass it a range, 2 from the beginning until the end. But how do we make an NSRange?
Though it does not quite look like it in the Documentation, you can create an `NSRange` just like any other Swift Struct.
    
    let range = NSRange(location: 2, length:data.length - 2)

*/

func removeTwoBytes(data: NSData?) -> NSData? {
    switch data{
    case .Some(let theData):
        let range = NSRange(location: 2, length: theData.length - 2)
        return theData.subdataWithRange(range)
    case .None: return nil
    }
}

let newData = removeTwoBytes(data)

/*:
Perhaps we can make the above function just a little more useful by refactoring it so that it takes in a parameter telling us how many bytes we should remove.
*/

func removeNumberOfBytes(number: Int, fromData data: NSData?) -> NSData? {
    switch data{
    case .Some(let theData):
        let range = NSRange(location: number, length: theData.length - number)
        return theData.subdataWithRange(range)
    case .None: return nil
    }
}

let withoutTheFirst3 = removeNumberOfBytes(3, fromData: data)

/*:
We will use `removeNumberOfBytes` from now on.
*/

//: [Next](@next)
