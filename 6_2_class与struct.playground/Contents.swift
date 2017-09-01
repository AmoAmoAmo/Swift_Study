//: Playground - noun: a place where people can play

import UIKit

struct PointVal {
    var x: Int
    var y: Int
    
    init(x:Int, y:Int)
    {
        self.x = x
        self.y = y
    }
    
    mutating func moveX(x: Int)
    {
        self.x += x
    }
}

class PointRef {
    var x: Int
    var y: Int
    
    init(x:Int, y:Int)
    {
        self.x = x
        self.y = y
    }
    
    func moveX(x: Int)
    {
        self.x += x
    }
}

// 相同：自定义类型，都拥有属性，方法
// 不同：class是引用类型
//      class表示一个具体的对象，而struct仅表示一个值

// 不同-1
// class 没有默认的init，如果不写，编译器会报错。是因为class不是一个简单的值，必须通过init来表达构建一个对象的过程
// struct 默认有init。struct就是表示一个值

// 不同-2
// 对常量的理解不同
let p1 = PointVal(x: 0, y: 0)
let p2 = PointRef(x: 0, y: 0)

//p1.x = 10   // 误：报错，提示把p1的常量类型let改成变量类型var
p2.x = 10     // 正
/**
    因为 p1作为一个值类型，它的常量当然是它的值不能被修改
    而p2是一个引用类型，常量对它来说是p2不能再指向其他的对象，如再定义一个p3, p2 = p3, 就会出现和p1类似的错误
*/
let p3 = PointRef(x: 0, y: 0)
//p2 = p3




// 引用类型操作符 indentity operator ===

/**
    p2和p3都指向相同的坐标点，但是p2和p3却不指向相同的对象，
    为了区分 相同的值 和 相同的引用，swift提供了indentity operator
*/

if p2 === p3  // 判断p2和p3是否指向相同的对象
{
    print("same")
}
if p2 !== p3
{
    print("not")
}




// 不同-3
// 定义方法时所表现出来的不同之处
/**
    1. struct 方法中默认不能改变成员的值，如果要改变则要加关键字mutating
    2. class 方法中可以修改

    因为作为一个值类型struct来说，它所表示的坐标点的值与平时数字123之类的没有本质上的区别，作为程序中使用的字面值，默认情况下当然是不能有能够修改自身值的方法
    但是对于一个类对象来说，它的数据成员只是代表一个类对象自身的属性，所以可以提供修改这些属性的方法
*/


// 值类型与引用类型的复制的区别
var a1 = PointVal(x: 0, y: 0)
var a2 = a1
a2.x = 10
a1.x

var b1 = PointRef(x: 0, y: 0)
var b2 = b1
b2.x = 20
b1.x
/**
    值类型：
        a1，a2任意一个被改变都不会影响另一个的值（深复制）
    引用类型：
        b1，b2任意一个被改变，另一个都会同样被改变（浅复制）
*/








