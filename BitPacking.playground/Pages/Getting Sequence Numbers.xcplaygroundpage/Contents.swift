//: [Previous](@previous)
import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "dat")
let data = readDataFromFile(path)
let newData = removeNumberOfBytes(2, fromData: data) // remove the 2 unused bytes

/*:
The next thing in the data format is the Sequence Number.

The sequence number is in the next two bytes. Lets grab the next two bytes and save them.

    func getSequenceNumberFromData(data: NSData?) -> Int

*/

func getSequenceNumberFromData(data: NSData?) -> Int?{
    
/*:
Since the data is an Optional we need to check it for nil.
*/
    switch data {
    case .Some(let data):
        
/*:
Now that we have the data we can use `NSData.getBytes()` to read 2 bytes from the data.
The signature for `getBytes()` is a bit scary. But we can figure it out. 

    func getBytes(_ buffer: UnsafeMutablePointer<Void>, length length: Int)

We need a pointer so we use the `&` operator. The pointer must be mutable so we declare it as a var. The void is there to specify that the type system does not know what type of data we are going to get out of the data. But we know that it is going to be a 16 bit integer. We need to initialize the seq variable to zero so the compiler can reserver and zero out some memory for us.
*/
        var seq: UInt16 = 0
        data.getBytes(&seq, length: 2)
/*:
Take note seq which we got from the data is `0x1372`. Converting that to decimal is 4978 but printing it here shows 29203. This is because of the call to `getBytes()` actually gave us `0x7213`, note that the 2 bytes are not in the correct order. We can use the `UInt16.byteSwapped` to return the correct number.
*/
        seq
        return Int(seq.byteSwapped)
/*:
Finally just return nil if the data was not there
*/
    case .None: return nil
    }

}

let seq = getSequenceNumberFromData(newData)
//: [Next](@next)
