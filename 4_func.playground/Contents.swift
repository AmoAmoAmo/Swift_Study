//: Playground - noun: a place where people can play

import UIKit

func printName()
{
    print("my name is Josie.")
}

printName()


//: ### param 参数
func func1(a:Int = 5)
{
    print("\(a) * 10 = \(a*10)")
}
//func1()
func1(a: 10)

func mul( _ a:Int,  _ /*outName*/b:Int) ->(Int)
{
    print("\(a) * \(b) = \(a*b)")
    return a*b
}

//mul(a: 5, b: 10)
mul(5, 10)





func arraySum(num:Double...)
{
    var sum: Double = 0.0
    for i in num
    {
        sum+=i
    }
    print("sum:\(sum)")
}

arraySum(num: 1,2,3,4,5,6)

func testSum(num:[Double])
{
    var sum: Double = 0.0
    for i in num
    {
        sum+=i
    }
    print("sum:\(sum)")
}

testSum(num: [1,2,3,4,5,6])





func increment( value:inout Int)
{
    value += 1
}

var m = 10;
increment(value: &m)
m



// ---------------------------------------------------------------------

//: ### return value 返回值
func multiple(a:Int, andB:Int) ->Int
{
    return a * andB
}
var r = multiple(a: 5, andB: 10)


func tableInfo() ->(row:Int, colun:Int)
{
    return (4,5)
}

var table = tableInfo()
table.row
table.colun

func strToInt(str:String) ->Int?
{
    return Int(str)
}
var n = strToInt(str: "12")
type(of: n)
n = strToInt(str: "sd ")

// 函数类型
//var f1: (Int, Int) -> (Int) = mul
// 或者
var f1 = mul
var f2 = table
var f3 = strToInt
// 然后可以直接用f1调用函数
f1(5, 4)


// 函数类型做参数
func myTest( fn: ((String) -> Int?), str: String)
{
    fn(str)
}
myTest(fn: f3, str: "20")


//: 返回值为函数类型时
typealias op = (Int)->Int


func fun_1(n:Int)->Int
{
    return n+1
}
func test() -> (Int) -> Int
{
    return fun_1(n:)
}
test()


func whichOne(n:Bool) -> op
{
    func fun_1(n:Int)->Int
    {
        return n+1
    }
    
    func fun_2(n:Int) ->Int
    {
        return n-1
    }
    
    return n ? fun_1 : fun_2
}

var one = 1
var oneToTen = whichOne(n: one < 10)

while one < 10
{
    one = oneToTen(one)
}













