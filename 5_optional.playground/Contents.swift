//: Playground - noun: a place where people can play

import UIKit


//: OC
/**
    - nil 表示对象的值不存在
    - NSNotFound 标量类型不存在
    - 0，-1，“” 变量值可能为空的情况

*/

//:Swift
/**
    - optional
*/


//: 定义一个optional
// type inference 类型推断
let str = "123"

var result = Int(str)
print("\(String(describing: result))")
print(result!)
type(of: result)

// 手动指定一个optional
var x: Int?
var address: String?
var successRate: Double?// 自动被赋值为nil
// 只能把nil赋值给一个optional
// 因此访问一个普通变量总是安全的


//:访问一个optional 
// 1. -> 通过if先判断是否为nil,在optional后加一个(force unwrapping)！访问optional的值
if result != nil
{
    /**
        force unwrapping
        力    展开
    */
    print(result!)
    let sum = result! + 1
}

// 如果没有用if判断是否为nil 而直接力展开 会产生运行时错误
//print(x!)

// 2. -> optional binding 绑定
if var num = result
{
    print(num)
    num = num + 10
}else
{
    print("nil")
}

// 3. -> implicitly unwrapped optionals
//   无疑问地展开，用在一定会被赋值的地方，通常用来解决循环引用问题
var string:String! = "hello"
print(string)
string + " world"




//:### Optional Chaining 自判断链接
/**
    它的自判断性体现于请求或调用的目标当前可能为空（ nil ）。如果自判断的目标有值，那么调用就会成功；相反，如果选择的目标为空（ nil ），则这种调用将返回空（ nil ）。多次请求或调用可以被链接在一起形成一个链，如果任何一个节点为空（ nil ）将导致整个链失效。

    ?. 语法糖，为了使代码看起来更简洁方便
*/
// 通过optional访问某个类对象的属性或者方法时，可以用optional chaining 在不牺牲安全性的前提下 让代码变得简单

enum Tpye{
    case CREDIT
    case DEPOSIT
}

class BankCard {
    var type:Tpye = .CREDIT
}
class Person {
    var card: BankCard?
    
    init(card: BankCard? = nil)
    {
        self.card = card
    }
}



let nilPerson: Person? = nil
let noCardPerson: Person? = Person()
let creditCardPerson: Person? = Person(card: BankCard())

//     ?.方法
nilPerson?.card?.type
noCardPerson?.card?.type
creditCardPerson?.card?.type // 按. 会自动补全为?. 即optional chaining


/**
    左边：某类型t的optional
    右边：生成一个新类型optional的closure

    为了理解 ？. 这个操作符的意思
    自定义一个新的操作符 =>
*/
//


// 自定义一个新的操作符 =>
infix operator => { associativity left } // 左操作数关联的
// 定义这个新操作符的行为
/**
    有两个泛型参数T和U
        左操作数是一个optional T
        右边是一个closure，把一个类型T变成类型U的optional
    返回U optional
*/
func =><T, U>(left: T?, right: (T) -> U?) -> U?
{
    /**
        根据left的不同的值来选择操作
        如果left的值不为nil
            则将它传值给right，并生成相应的U optional，并返回
        如果left的值为nil
            则简单地返回nil
    */
    switch left
    {
    case .some(let value):
        return right(value)
    case .none:
        return .none
    }
    
}

/**
    左操作数：nilPerson：Person？
    右操作数：{$0.card}
*/
nilPerson=>{$0.card} => {$0.type}
noCardPerson => {$0.card} => {$0.type}
creditCardPerson => {$0.card} => {$0.type}

noCardPerson => {$0.card}
noCardPerson?.card
creditCardPerson => {$0.card}
creditCardPerson?.card
/**
    Q:为什么使用optional chaining是安全的
    A:因为对于nilPerson noCardPerson来说，用=>只是简单地返回nil，并不会尝试调用right(value)，即.card和.type
*/


//    flagMap
/**
    flagMap swift自身提供的一种类似=>的方法
    当optional的值为nil时，就返回nil
    否则就返回对象的值
*/
nilPerson.flatMap({ $0.card}).flatMap({ $0.type})
creditCardPerson.flatMap({ $0.card})


