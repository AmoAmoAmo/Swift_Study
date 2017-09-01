//: Playground - noun: a place where people can play

import UIKit


//: ### map: 把一个元素映射成另外一个元素 eg-1：把一个string数组映射成一个emoji符号数组

// 把字符串变成emoji字符的函数
func strToEmoji(str: String) -> Character
{
    // 1. \\N{str}
    let tmpStr = "\\N{\(str)}"
    // 2. 调用tmpStr的一个方法来把它转换成一个emoji符号
    let emoji = tmpStr.stringByApplyingTransform(NSStringTransformToUnicodeName, reverse: true)// 在这里是需要把一个Unicodename(万国码)转换成一个NSString字符串，所以reverse(颠倒)传递true
    emoji.dynamicType
//    print("--\(emoji)")
//    print(emoji!.characters.first!)
    // 然后只要读取emoji string中的第一个字符，就可以读到它的emoji符号了
//    return (emoji?.characters.first!)!
    return emoji!.characters.first! // 返回它的第一个字符
}

strToEmoji("tiger")

// 如果我们想对一个字符串数组执行这种Unicodename到emoji的转换：
let animalsArr = ["bird", "CAT", "spider"]
// 就可以使用swift的map方法：  ;在这里需要对map传一个我们之前定义的转换函数
let animalsEmojisARR = animalsArr.map(strToEmoji) // 可以看到map把一个animalsArr字符串数组 转换成了和它对应的emoji符号数组


// 为了理解map的工作原理，我们自己来手动实现一个map:
extension Array
{
    func myMap<Before, After>(transform: (Before) -> After) -> [After] // 在这里 由于map要把一个类型转换成另一个类型，所以它要接受两个类型参数<转换前类型，转换后类型>， 然后myMap要有一个closure类型参数，transform表示映射类型规则，它接收一个Before类型的参数，返回一个After类型的对象，最终myMap返回一个After类型的数组
    {
        var outputArr: [After] = []
        
        for item in self
        {
            let transformed = transform(item as! Before)
            transformed.dynamicType
            outputArr.append(transformed)
        }
        return outputArr
    }
}

let myEmojisArr = animalsArr.myMap(strToEmoji)



//: ### reduce，是一个用于把集合中的元素合并起来，最终形成一个新的值的过程，eg-2:
var numsArr: [Int] = []

for i in 1...10
{
    numsArr.append(i)
}
/**
    1: 代表整个合并过程开始之前的初始值
    2: 是一个closure，代表合并的规则 (T, Int) throws -> T，参数1代表合并之前的初始值，参数2代表这一次要合并起来的值。
*/
let sum = numsArr.reduce(0, combine: { $0 + $1 })
sum


extension Array
{
    // myReduce eg-3:
    func myReduce<C, T>(initial: C, combine: (C, T) -> C) -> C // 由于最终的合并结果可能和每一次合并起来的值的类型不同，因此myReduce也需要两个类型参数。合并后结果的类型：C，参与每一次合并过程的值的类型：T。需要两个参数：1. initial：每一次合并的初始值；2. combine：合并规则，是一个closure，该closure有两个参数：1这一次用来合并之前的初始值，2这一次要合并起来的值，最后返回合并的结果。最后myReduce返回最终的结果
    {
        var seed = initial // seed 用来保存这个初始值
//        print(seed)
        for item in self
        {
            seed = combine(seed, item as! T)
        }
        return seed
    }
}

// myReduce eg-3:
let sum1 = numsArr.myReduce(0, combine: { $0 + $1 })
sum1





/**
    myMap 和 myReduce 共同点：
    它们只关心完成转换的过程本身，而并不控制实际对每个元素进行转换的细节，而唯一有可能对转换结果产生影响的细节则是我们在调用myMap的时候 自己传入的，因此我们完全无需担心整个转换过程会受到外部因素的干扰，通过myMap这样的high order function高阶函数，我们完全把映射使数组的过程和映射的细节剥离开来，而这就是functional programing带给我们最大的好处
*/























