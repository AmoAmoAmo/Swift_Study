//: Playground - noun: a place where people can play

import UIKit

// Protocol Oriented Programming 面向协议编程。
// Object   Oriented Programming 面向对象编程
// swift自身就是Protocol Oriented Programming。什么是POP？
// 在之前，protocol始终被我们当接口使用，它定义了其他自定义类型要实现的属性和方法，不过现在是时候改变这种认识了。在swift里，protocol也是可以提供默认实现的，eg：


protocol Flight{ // 航班信息
    var delay: Int { get } //  航班晚点的次数
    var normal: Int { get } // 航班正常的次数
    var flyHour: Int { get }// 航班飞行的总时长
    
//     eg2：
    func delayRate() -> Double
}


// ***** eg4:
protocol OperationalLife{
    var maxFlyHours: Int { get }
}
// 然后使用extension来为同时满足Flight和OperationalLife这两个protocol类型添加一个新的方法
// 使用关键字where来表示额外的遵从条件，关键字Self用来表示遵从Flight类型，要求它必须同时遵从OperationalLife。然后为同时满足这些约定的类型添加新的方法
extension Flight where Self: OperationalLife{
    func isInService() -> Bool {
        return self.flyHour < maxFlyHours
    }
}




// 这时，如果我们想要计算航班总的飞行次数，就可以通过定义一个protocol extension 来实现  (提供默认实现)
extension Flight { // 拓展一个protocol 看似和拓展其他自定义类型没有太大的区别，都是使用extension关键字 + 要拓展的类型名字。和定义protocol不同，我们可以在一个protocol extension中提供默认的实现，eg：在这里可以把totalTrips定义成一个computed property
    var totalTrips: Int { return delay + normal } // 尽管此时我们还没有定义任何遵从Flight的约定，但是已经可以在extension中使用Flight的数据成员了，因为swift的编译器知道，任何一个遵从Flight的自定义类型 一定会定义Flight约定的各种属性。eg：定义一个表示空客A380客机的类型
    func test ()->String{
        return "test"
    }
    
    // eg2：
    func delayRate() -> Double {
        return Double(delay) / Double(totalTrips)
    }
}

struct A380: Flight { // 遵从Flight protocol
    var delay: Int    // 添加Flight约定的三个属性
    var normal: Int
    var flyHour: Int
    
    // eg3：
    func delayRate() -> Double {
        return 0.1
    }
}

// ***** eg4: 然后让A380遵从OperationalLife。由于在extension里我们不能定义stored property，所以只能把maxFlyHours定义成一个computed property
extension A380: OperationalLife {
    var maxFlyHours: Int { return 18 * 365 * 24 }// 假定服务年限为18年
}


// 这时，当我们定义了一个A380对象之后，就可以使用totalTrips获取总的飞行次数了
let a380 = A380(delay: 300, normal: 700, flyHour: 3 * 365 * 24)
a380.totalTrips
a380.test()

/**
    通过这个简单的例子，我们了解了如何使用extension来为一个protocol添加一个额外的默认功能。除此之外，我们还可以使用extension为protocol"已有的"方法提供默认的实现，eg2：为Flight添加一个计算晚点率的方法
*/
a380.delayRate()

// extension既可以为protocol添加额外的功能，又可以为已有的方法提供默认的实现。但是这两种行为却有着细微的差别。简单来说，通过extension添加到protocol中的内容不算做protocol的约定，eg3：在A380为delayRate添加一个自定义实现 ，让它返回0.1，这时 无论flight1的类型是A380 还是Flight，delayRate的结果都会是0.1。因为我们在A380中重新定义了Flight中约定的方法

// 把flight1的类型转为Flight，然后访问delayRate方法,结果仍是0.1。因为在A380中重新定义了Flight的方法。
(a380 as Flight).delayRate()
// 接下来在Flight中注释掉delayRate。flight1的类型是A380时，delayRate的结果是0.1；flight1的类型是Flight时，delayRate的结果是0.3。这是因为，当我们在Flight中注释掉delayRate之后，它就不再是Flight约定的一部分了，在Flight extension中的delayRate只不过是为Flight protocol提供的一个方法1的添加的额外默认功能，既然delayRate不再是Flight约定的一部分了，那么swift编译器也不会认为A380中重定义的delayRate是在重新实现Flight中的约定，而只会把A380中的delayRate当成是普通方法，因此当我们把flight1的类型转换为Flight时，swift就会调用Flight的delayRate，事实上Flight的和A380中定义的delayRate没有任何关系。



// 除了可以在extension中提供默认实现之外，我们还可以为默认实现限定其可用的条件，这个限定的方式在swift中叫做 Type constraints 类型约束

//: ### Type constraints
// 首先 添加一个用于飞机服务年限的protocol，eg4:


// ***** eg4: 然后flight1就可以使用OperationalLife中定义的isInService方法了
a380.isInService()































