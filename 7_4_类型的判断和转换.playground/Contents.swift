//: Playground - noun: a place where people can play

import UIKit

// is as as? as!，用于处理对象之间关系操作符


//: ### 类型的判断
//class Shape {}
// protocol
protocol Shape {}
class Rectangle: Shape {}
class Circle: Shape {}

let r = Rectangle()
let c = Circle()

// AnyObject
//let shapeArr: Array = [r, c]; // Array<Shape>
//let shapeArr: Array<AnyObject> = [r, c]; // Array<AnyObject>
let shapeArr: Array<Shape> = [r, c]
//shapeArr.dynamicType
type(of: shapeArr)
//shapeArr[0].dynamicType

// 统计arr中各种形状的数量 is操作符; 用 A is B 这样的用法来判断对象类型
var totalRects: Int = 0
var totalCircles:Int = 0
shapeArr[0] is Rectangle
for s in shapeArr
{
    if s is Rectangle
    {
//        ++totalRects
        totalRects += 1
    }else if s is Circle{
        totalCircles += 1
    }
}
totalRects
totalCircles



// 子类到父类的类型转换是自动完成的，因为这本身就符合派生类是某种类的基类这样的**， 从父类到子类的转换通常是需要我们明确指定的，管这样的转换叫downcasting向下转型，在swift中用as关键字来完成这个操作
// 类型转换 as? as!

// as? 会转换成一个目标类型的optional
// as！在转换成功时直接返回一个目标类型，失败的时候会引发运行时错误。所以 当转换一定会成功时才使用as!

//(shapeArr[0] as? Rectangle).dynamicType
type(of: (shapeArr[0] as? Rectangle))
shapeArr[0] as? Rectangle
shapeArr[0] as! Rectangle
shapeArr[0] as? Circle
let a = type(of: (shapeArr[0] as? Circle))
a
//r as! Double


// 除了用于downcasting父类到子类这样的转换，as还可以用于AnyObject的转换。 swift中用AnyObject表示任意类型的对象





// 除了as！或as？ 还可以使用as自身

// 当编译器也知道一定能转成功的时候可以用as
let rect = r as Rectangle // 如果此时用as!则会警告 forced cast of 'Rectangle' to same type has no effect

let box: Array<Any> = [  // Any， 表示任意一种类型
    3,
    3.14,
    "3.1415",
    r,
    { return "I'm a closure" }
]
//box[3].dynamicType

/**

    is不仅可以判断继承关系，还可以判断Any和其他类型的关系；

    as可以直接用在switch case语句里，可以直接把对象转换成目标类型。

*/
for item in box
{
    switch item
    {
    case is Int: // is判断Any和其他类型的关系
        print("\(item) is Int")
    case is Double:
        print("\(item) is Double")
    case is String:
        print("\(item) is String")
    case let rect as Rectangle: // 在case的value binding里使用as，当item的类型是Rectangle时 就会自动地把结果绑定给rect，此时编译器也知道一定能转成功，所以此处相当于as! // let rect = item as Rectangle
        print("\(rect)")
        print("\(item) is Rectangle")
    case let fn as () -> String:
        fn()
    default:
        print("out of box")
    }
}
/**

    除了转换Any和AnyObject之外，is和as还可以用来判断某个类型是否遵从protocol的约定
*/


// 判断box[0]是否遵从了Shape的约定
box[0] is Shape

// 使用as操作符，把对象转换成一个protocol类型
box[3] as? Shape
type(of: (box[3] as? Shape))
type(of: (box[3] as! Shape))
box[3] as! Shape
c as Shape

// 细节：当类型转换成功的时候，如果使用的是as!，swift会把转换结果变成对象的真实类型，而不是protocol；而当使用as？进行类型转换时，得到的就会是一个目标类型的Optional，

// 总结：swift是一门强类型语言，我们应该学会类型判断和转换的正确用法 as as? as!























