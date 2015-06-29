//: [Previous](@previous)
import Foundation

let path = NSBundle.mainBundle().pathForResource("input", ofType: "dat")
let data1 = readDataFromFile(path)
let data2 = removeNumberOfBytes(2, fromData: data1) // remove the 2 unused bytes
let seq = getSequenceNumberFromData(data2)

//Don't forget to remove the sequence number now that we have read it
let data3 = removeNumberOfBytes(2, fromData: data2)

/*:
Now that we have ignored the first 2 bytes and extracted the sequence number now we need to work on the data.

The data is in the next 18 bytes.

The data we want to get out is 4 sets of {x,y,z}. 

18 Bytes -> [{x,y,z}, {x,y,z}, {x,y,z}, {x,y,z}]

Each number x or y or z is a 12 bit signed number. So let's look at the first coordinate set.
12bits for x, 12 bits for y makes 24 bits or 3 bytes, we can work with that for now and extend to get the rest of the data later.

We will start by extracting the first 3 bytes of the data. Use a function which takes our data and returns the first 3 bytes.
    func extract(data:NSData) -> ?

What should the return type be? We need a thing which can hold onto 24 bits of information, maybe an Int32, that should be big enough.

*/

func extractThreeBytes(data: NSData?) -> UInt32{
    var xy: UInt32 = 0
    data?.getBytes(&xy, length: 3)
    return xy.byteSwapped
}

data3
/*:
    We are on our third version of data here so what is in data3? It starts with 0xEF_EF_5C as the first 3 bytes.
    We can print this using a format string, of "%X" to show the hex representation. Note that again the data is byte swapped. 
    
    Add `.byteSwapped` in the correct place inside of the `extractThreeBytes` method above.
*/
printHex( extractThreeBytes(data3))


/*:
Now that your data is in the propery byte order you may have noticed that it is still not quite correct. Instead of EFEF5C we have EFEF5C00. Lets get our data correct.

Our UInt32 has enough room to hold 32 bits like the name says, and when we initially filled it with 24 bits the data looked like this
    0x005CEFEF
But when we performed the `.byteSwapped` the zeros at the top moved as well. 0x005CEFEF.byteSwapped -> 0xEFEF5C00

To get rid of those pesky zeros we can use the bit shift operator `>>`. The bit shift operator expects a Number and a number of bits to shift by. 
    func >>(lhs: IntegerType, rhs: IntegerLiteralConvertible) -> IntegerType  
*/

printHex(extractThreeBytes(data3) >> 8)

/*:
Awesome Just what we want.

Now back to the task at hand. Those 3 bytes represent the A pair of X Y coordinates, each signed and containing 12 bits each.
Lucky for us we can put the groups of 12 bits in a UInt16 for storage then we will put them into an Int16 once we are done.

Lets focus on the first one the first 12 bits are 0xEFE, but how do we get them out of the middle of that UInt32? 
We need to invoke our bitwise operators, &, |, <<, >> these are AND, OR, LEFT SHIFT, and RIGHT SHIFT

In order to get the data out of the middle of 0x00EFEF5C we will use a bitmaks which can target just the bits we are interested in. We create a mask of 0x00FFF000, this will put the digit one over all the things we are interested in.
Then we use the Bitwise And '&' to zero out all the uninteresting bits.

Finally we will shift the bits down so that the EFE is taking up the least siginificant bits EFE000 >> 12 -> EFE

*/

var original: UInt32 = 0x00EFEF5C
printHex( original)
let mask: UInt32 = 0x00FFF000
let masked = original & mask
printHex(masked)
printHex(masked >> 12)

/*:
So lets make a little function, that takes a UInt32 and returns 2 UInt16s
*/

func extractPair(xy: UInt32) -> (UInt16,UInt16) {
    let maskOne: UInt32 = 0x00FFF000
    let maskTwo: UInt32 = 0x00000FFF
    let first = UInt16(truncatingBitPattern:( xy & maskOne) >> 12)
    let second = UInt16(truncatingBitPattern:(xy & maskTwo))
    return (first , second)
}

/*:
Lets put these new things to work.
*/

let xy = extractThreeBytes(data3) >> 8
let pair = extractPair(xy)
printHex(pair.0)
printHex(pair.1)

//: Don't forget to drop those 3 bytes off the top of the data
data3
let data4 = removeNumberOfBytes(3, fromData: data3)

//: [Next](@next)


//struct Pair{
//    let first:UInt16
//    let second:UInt16
//
//    func toSigned12Bit(x: UInt16) -> Int16 {
//        return 0
//    }
//
//    var first12BitSigned: Int16 {
//        return toSigned12Bit(first)
//    }
//    var second12BitSigned: Int16{
//        return toSigned12Bit(first)
//    }
//}

