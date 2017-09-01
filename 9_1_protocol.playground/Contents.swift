//: Playground - noun: a place where people can play

import UIKit

// 作为swift中的一种自定义类型，和struct，class，enum不同，我们使用protocol来定义某种约定，而不是一个具体的类型。这种约定通常用于表示某些类型的共性，eg：
protocol Engine // 所有遵从Engine约定的类型都必须同时提供start和stop这两种方法。
{
    // -3. 属性
    var cylinder: Int { get set } // 汽缸数 // 由于Engine并不是一个具体的类型，因此当我们在一个protocol中定义具体属性的时候，我们必须使用{ get set }这样的方法来明确指定该属性支持的操作。{ get set }表示可读写的，{ get }表示只读，
    
    
    var capacity: Double {get} // 排量
    
    
    // -1. 方法
    func start()
    func stop()
    
    // -2. 参数：当protocol中的方法带有参数时，参数是不能有默认值的；如果要支持默认值，我们只能再定义两个方法
//    func getName(prefix: String = "")// 默认参数在protocol中是不被允许的
    func getName(prefix: String)
    func getName()
}

// -4. 除了定义属性和方法之外，protocol还可以继承的，用于表示约定A也是一个约定B，eg：

protocol TurboEngine: Engine
{
//    var text: Int {get}
    func startTurbo()
    func stopTurbo()
}

protocol Motor{
    var power: Double {get set}
}

// 由于Engine只是一个约定，因此不能直接生成安全的对象， ;
//let truck = Engine()

// 只能定义一个具体类型的struct，class，enum，让它们遵从Engine的约定,如：
//class Truck: Engine {...}
// 这和类继承的方式很像，但是 当冒号：后是一个protocol时，表示类型Truck遵从protocol Engine的约束。此时会报错，这是因为，虽然我们声明了Truck遵从Engine的约定，但是我们并没有真正实现start和stop这两个方法，暂时忽略，后面会讲。。。实现protocol的方法



let v8: TurboEngine
// 表示v8不仅是一个TurboEngine，也是一个Engine













//: 让自定义类型遵从protocol协议的约定
class V8: TurboEngine, Motor{
    // ******** 属性约定 *********
    // 在V8里添加Motor的属性power的值
    var power = 300.0
    
    // cylinder在protocol Engine里看起来像个computed property，但是在V8的实现里可以简单定义为stored property
    var cylinder = 8
    
    // V8实现的时候：1. 可以定义一个常量 让capacity达到只读的效果；
//    let capacity = 4.0 // 不是必须的
    // 2. 让capacity在V8里面变成一个变量
//    var capacity = 4.0
    // 3. 使用computed property来实现protocol里capacity的约定。当我们使用computed property的时候，通常需要定义一个内部的stored property，eg:
    private var innerCapacity = 4.0
    // 然后定义一个computed property来实现capacity的约定
    var capacity: Double {
        get {
            return self.innerCapacity
        }// 尽管在protocol里面，capacity只有get属性，但是在V8的实现里同样可以给它添加set方法
        
        set {
            self.innerCapacity = newValue
        }
    }
    
    
    // ******** 方法约定 ********* 必须实现
    // Engine methods
    func start() {
        print("Engine start")
    }
    func stop() {
        print("Engine stop")
    }
    func getName(prefix: String) {
        print("\(prefix)-v8-engine")
    }
    func getName() {
        print("v8-engine")
    }
    
    // TurboEngine methods
    func startTurbo() {
        print("Turbo start")
    }
    func stopTurbo() {
        print("Turbo stop")
    }
    
}


let v8L40 = V8()
v8L40.cylinder  // get
v8L40.cylinder = 18 // set. 因此，一个stored property是满足protocol中get和set约定的

// 如果给TurboEngine添加一个只读的属性，情况就和我们想象的有些不同了

// 这样 当一个变量的类型是V8的时候，刚才添加的capacity就是可写的，eg:
v8L40.capacity = 8.0
// 但是如果把v8L40的类型转换成Engine或TurboEngine，capacity就会变成一个只读的, eg:
//(v8L40 as Engine).capacity = 8.0 // 这个时候编译器就会报错

// 这就是在自定义类型中实现protocol中属性的各种用法

// 除了让一个类型遵从单一的属性之外，我们还可以让一个自定义类型遵从多个protocol，eg:添加一个新的protocol表示电动机Motor的约定，在V8的声明里使用，将protocol分开 表示遵从多个约定


















