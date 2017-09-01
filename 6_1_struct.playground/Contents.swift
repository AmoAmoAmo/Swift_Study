//: Playground - noun: a place where people can play

import UIKit


// named types 自定义类型
//  struct, class, enum, protocol

//: ### struct  value type 值类型

//:
let centerX = 100.0
let centerY = 100.0
let distance = 200.0

func inRange(x:Double, y:Double) ->Bool
{
    // sqrt(n)  n的根号
    // pow(n,x) n的x次方
    let distX = x - centerX
    let distY = y - centerY
    
    let dist = sqrt(pow(distX, 2) + pow(distY,2))
    return dist < distance
    
}

inRange(x: 100, y: 500)
inRange(x: 300, y: 800)

// 缺点：不直观，100, y: 500 不能直观看出是代表什么
// 使用struct 提高代码可读性，location(Double,Double)
// inRange(location)
// inRange(myHome)

// 定义 struct
struct Location
{
//    let x:Double
//    var y:Double
    var x = 100.0
    var y = 100.0
    
    // 初始化 initializer
    /**
        固定名字：init
        初始化的参数是string，无返回值 因为init直接生成一个Location对象
    
        "100,200" -> 100,200
        使用分割字符串的方法
        集合初始化成一个字符串
        atof 将一个字符串转换成一个double
    */
    init(strPoint: String)
    {
        let xy = strPoint.characters.split(",")
        // 得到的xy为[[character], [character]]
        //      character数组的集合
        x = atof(String(xy.first!))
        y = atof(String(xy.last!))
    }
    
    // memberwiase initaliazation 成员逐一初始化
    init(x:Double, y:Double)
    {
        self.x = x // self代表要创建的对象本身
        self.y = y
    }
    
    init(){}
    
    /**
        Method
            定义很简单，看上去就像直接在struct中定义方法
    */
    mutating func moveHorizental(dist: Double)
    {
        /**
            error：struct的member是不可修改的
            作为一个值类型，struct并不能在方法中直接修改它的member
            解决方法：在方法前加关键字mutating
        */
        self.x += dist
    }
    
}

var pointA = Location(x: 100, y: 200)// memberwiase initaliazation
var pointB = Location(strPoint: "100,200")
pointB.x
pointB.y

pointA.x
pointA.y = 500.0

func inPointRange(point: Location) -> Bool
{
    let distX = point.x - centerX
    let distY = point.y - centerY
    
    let dist = sqrt(pow(distX, 2) + pow(distY,2))
    return dist < distance
}
inPointRange(pointA)

/**
    如果定义的struct的每一个成员都有初始值
    且在没有自定义init时
    可直接设 var center = Location()

    如果已经自定义了init
    则再写一个：init(){}
*/
var center = Location()



//:### 在struct中定义方法


// 为什么要定义方法？ 下面先看一个例子

// 水平移动的方法
func moveHorizental(dist: Double, inout point: Location)
{
    point.x += dist
}

moveHorizental(100.0, point: &pointA)
pointA

/**
    这样使用的问题：
      1. point.x是Location内部的成员，无需被使用者关心
      2. 移动x轴坐标 本身就是与Location自身相关的计算
           直觉上希望使用：pointA.moveHorizental(100.0)

    因此使用在struct内定义方法Method
    让类型相关的计算表现得更加自然
*/
pointA.moveHorizental(100.0)



/**
Q:如果struct不是我们自己定义的，而我们又需要在该struct中添加方法时，怎么办
A:使用struct extentions
*/
//: ### struct extentions 拓展

extension Location
{
    mutating func moveVertical(dist: Double)
    {
        self.y += dist
    }
}

pointA.moveVertical(100)


// 2. 通过extention来拓展swift中的string

// eg: 判断一个字符串中的字符是否为偶数even
extension String
{
    func isEven() -> Bool
    {
        return self.characters.count % 2 == 0 ? true : false
    }
}

"hello world!".isEven()

// swift 中的基础类型int, string, double等，都被定义成struct


//: ### 强调：struct是一个value type 值类型
/**
    value type：
        用来表达某种和值有关的概念
        特点：当它被拷贝时，会把整个值拷贝过去(深拷贝？)
*/
var copyPointA = pointA
copyPointA.y = 1000.0
pointA







