//: Playground - noun: a place where people can play

import UIKit

let ten = 10

var addClosure:(Int,Int)->Int = {(a:Int, b:Int) -> Int in
    
    return a+b
}


addClosure(5,10)

addClosure = {a, b in a - b}
addClosure(8, 2)

addClosure = {a, b in return a * b}
addClosure(2, 5)


addClosure = {$0 + $1}
addClosure(10, 2)

let aClosure = {print("hello")}
aClosure()

//: closure作为函数的一个参数

func execute(_ a:Int, _ b:Int, operation:(Int, Int) -> Int) ->Int
{
    return operation(a ,b)
}

func addFunc(a:Int, b:Int) ->Int
{
    return a + b
}

execute(6, 8, operation: addFunc)
execute(6, 8, operation: addClosure)

// 直接传一个closure
execute(6, 8, operation: { (a:Int, b:Int) -> Int in
    return a + b
})

execute(10, 12) { (a, b) -> Int in
    return a + b
}

// 直接在函数参数的位置敲回车 即是一个closure
execute(6, 8) { (a, b) -> Int in
    return a + b
}
//  **** 简化 ****
execute(6, 8, operation: {a, b in a + b})
execute(6, 8, operation: {$0 + $1})

execute(6, 8){$0 + $1}



func testFunc(fn:(String) -> Int?, _ str:String)
{
    fn(str)
}

testFunc(fn:{ (str) -> Int? in
    Int(str)
    }, "100")




var textClosure = {(a:Int, b:Int) -> Int in
    return a + b
}
textClosure(6, 8)
// 没有返回值时
let voidClosure : () -> Void = {print("hello world")}
voidClosure()
let testC = {print("test")}
testC()



//: Capturing value


// closure捕获global变量
var count = 0

let increment = { count+=1} // 定义了一个closure,没有参数,有返回值 () -> Int
increment()
increment()
increment()
increment()
increment()
count

let test1 : ()->Void = {count+=1}
test1()


// closure捕获函数内部变量

func counting() -> ()->Int
{
    var count = 0
    
    let incrementCount_Closure = {count+=1}
    incrementCount_Closure
    
    func fun_1() ->Int
    {
        return 11
    }
    return fun_1
}

let c1 = counting()
c1()
c1()
c1()  // 连续调用时，函数内部的count一直都存在
print("\(c1())")

// 但是，不同的closure会捕获到自己的变量
let c2 = counting()
c2()
c2()

















