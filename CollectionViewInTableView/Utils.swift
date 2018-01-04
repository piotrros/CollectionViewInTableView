import Foundation

class Utils {
    static func rnd(_ min:Int, _ max:Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min))) + min
    }
}
