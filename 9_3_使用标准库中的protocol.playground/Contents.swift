//: Playground - noun: a place where people can play

import UIKit

// 在swift标准库中，有一些标准的protocol，通过它们可以让我们的自定义类型更好地和swift标准库融合，同时也可以让我们的自定义类型有更更自然的语义表现

//: ### 1. 自定义类型的equatable相等和comparable可比较的
//
//
let a: Int = 10
let b: Int = 10

let d1: Double = 3.14
let d2: Double = 3.14


struct Rational{ // 分数
    var numerator: Int = 0   // 分子
    var denominator: Int = 1 // 分母
}
// 如何比较两个Rational是相等的？
let oneHalf = Rational(numerator: 1, denominator: 2)
let zeroPointTwo = Rational(numerator: 1, denominator: 2)

//if oneHalf == zeroPointTwo{} // 不能直接比较，使用swift自带的protocol：Equatable 自定义类型的比较
//extension Rational: Equatable {}
extension Rational: Comparable {}

// 比较大小Comparable，继承自Equatable，并且提供<, <=, >, >=
// 定义一个 < 操作符
func < (left: Rational, right: Rational) -> Bool
{
    let l = Double(left.numerator) / Double(left.denominator)
    let r = Double(right.numerator) / Double(right.denominator)
    return l < r
}// 当我们定义了 < 操作符之后，swift会自动为我们生成 > 操作符

// 定义一个 == 操作符
func == (left: Rational, right: Rational) -> Bool
{
    return (left.numerator == right.numerator) && (left.denominator == right.denominator)
}
// 当我们定义了==操作符之后，swift会自动为我们生成!=操作符
if oneHalf != zeroPointTwo{}


// 当定义了 <, == 号之后，就完成了Comparable的所有约定方法

// 在实现了Comparable protocol之后，除了可以对Rational对象进行比较之外，还有一些额外的福利。当我们把Rational对象放入到支持Comparable protocol的集合类型时，如array,集合的各种排序，比较，包含操作，都可以对Rational对象生效了，eg:
var rationalArr: Array<Rational> = []

for i in 1...10
{
    let r = Rational(numerator: i, denominator: i+1)
    rationalArr.append(r)
}
print("Max: \(String(describing: rationalArr.max()))")
print("Min: \(String(describing: rationalArr.min()))")
rationalArr.sort()
rationalArr.contains(oneHalf)
rationalArr.starts(with: [oneHalf])

// 这就是Comparable protocol的用法








//: ### CustomStringConvertible
/**
    在之前打印的结果里可以看到，Rational的结果有点啰嗦。
    
Max: Optional(Rational(numerator: 10, denominator: 11))
Min: Optional(Rational(numerator: 1, denominator: 2))

    如果想要让它像打印一个分数那样打印出结果，就要使用CustomStringConvertible 这个 protocol
*/
extension Rational: CustomStringConvertible{
    var description: String{
        return "\(self.numerator) / \(self.denominator)"
    }// computed property

}// 它只有一个约定，就是实现一个叫做description的属性，这个属性将用来做print的结果

/**
    此时，可以看到print的结果变成了：

Max: Optional(10 / 11)
Min: Optional(1 / 2)
*/









//: ### BooleanType ，在swift中，非bool类型默认是不能自动地转换成bool类型的，如果我们想让Rational实现 0值为false，其他值为true的语义，可以实现swift的BooleanType protocol
extension Rational: Bool{
    var boolValue: Bool{ // computed property
        return self.numerator != 0 // 只要Rational不为0，就认为它是true
    }
}// 也只有一个约定：实现一个 boolValue 的属性，让它定义Rational值和bool值之间的对应关系

// 这样，就可以把一个Rational对象用在if条件判断里面
if oneHalf.boolValue{
    print("oneHalf means true")
}








//: ###  Hashable ,如果希望Rational可以作为dictionary或set的元素，只要实现这个protocol即可
extension Rational: Hashable{
    var hashValue: Int{ // 把一个Rational对象定义成一个整数
        let v = Int(String(self.numerator) + String(self.denominator)) // 把分子和分母连在一起
        return v! // 返回v代表value的结果
    }
}// 它只有一个约定，就是我们要定义的一个叫做hashValue的属性

// 这样可以直接访问一个Rational对象的hashValue
oneHalf.hashValue

// 或者把一个Rational对象放到一个dictionary或set的集合里, eg:
var dict: Dictionary<Rational, String> = [oneHalf: "0.5"] // key的类型是Rational，值的类型是String
// 或者把一个Rational添加到set里
var rSet: Set<Rational> = [oneHalf, zeroPointTwo]



/**
    通过它们，可以更好地理解通过protocol进行接口和实现的分离过程
*/















