//: Playground - noun: a place where people can play

import UIKit

// 对比面向对象常用的编程方式，继续解释Protocol Oriented Programming 面向协议编程
protocol Flight{ // 航班信息
    var delay: Int { get } //  航班晚点的次数
    var normal: Int { get } // 航班正常的次数
    var flyHour: Int { get }// 航班飞行的总时长
    
    func delayRate() -> Double
}

// eg-1：
protocol Cancellable{
    var cancel: Int { get } // 由于这个修改会导致航班延误率的计算方法发生变化，所以可以给Flight添加一个type constraints ,eg-2:
}


extension Flight { // 为protocol提供默认实现
    func delayRate() -> Double {
        return Double(delay) / Double(delay + normal)
    }
}

// eg-2: 这样 就把delayRate计算各种总次数的细节暴露给了可取消航班的这一特殊的类型(此例子里是A380)，然后当我们想表达A380是一个可取消航班的时候，我们这样让它同时遵从Flight, Cancellable就可以了
extension Flight where Self: Cancellable{
    func delayRate() -> Double {
        return Double(delay + cancel) / Double(delay + normal + cancel)
    }
}

struct A330: Flight {
    var delay: Int    // 添加Flight约定的三个属性
    var normal: Int
    var flyHour: Int
}

struct A380: Flight, Cancellable {
    var delay: Int
    var normal: Int
    var flyHour: Int
    // 然后给A380添加新的数据成员就可以了。这就是protocol的用法。可以把Cancellable理解为是A380这种类型的一种修饰，不过这种修饰相关的修改细节则被很好地封装在了extension里面。
    var cancel: Int
    
}

// 为了让Flight支持可取消的特性，首先我们来定义一个protocol，eg-1：


/**
    当我们想要通过protocol来实现之前提到过的TwoLayerFourEngineRoundTripCancellableFlight这种全功能类型的时候，它有可能是这样的：

struct A380: Flight, TwoLayer, FourEngine, RoundTrip,Cancellabel{
}

    在这里 A380使用的每一个protocol都可以理解成是A380的修饰，每一种修饰相关的修改细节都可以封装在protocol对应的extension里，这样，我们就对A380隐藏了不需要它了解的细节，同时也让各种细节的功能实现更加易于维护。

事实上，如果我们查看swift中Array的实现，就会发现与A380是非常相似，都是通过protocol对基础类型添加了各种功能修饰。这就是Protocol Oriented Programming 面向协议编程的所有内容，简单来说就是 面对有可能出现的全功能型接口，我们要一步步地把它们拆成各种protocol，最终再让它们重新组合起来

*/














