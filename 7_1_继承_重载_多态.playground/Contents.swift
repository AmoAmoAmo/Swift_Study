//: Playground - noun: a place where people can play

import UIKit

// instance method 实例方法,要创建对象(即 先要new ),才能调用
// swift中的每一个class method都是instance method实例方法，class method接收一个instance method参数，返回一个和instance method类型一样的数。
/**
        类方法(class method)和实例方法(instance method)区别
    Objective-C中的方法有两种：类方法(class method)和实例方法(instance method)。
        类方法被限定在类范围内，不能被类的实例调用（即脱离实例运行）。alloc就是一种类方法。实例方法限定在对象实例的范围内（即实例化之前不能运行）。
        init就是一种实例方法，被alloc方法返回的对象实例调用。


    NSObject * object1 = [[NSObject alloc] init];


    instance method  以减号 "-" 开头

    class method  以加号 “+” 开头，相当于static方法
*/

class BankCard {
    var balance: Double = 0
    
    func deposit(amount: Double)
    {
        self.balance += amount
        print("current balance:\(self.balance)")
    }
}

// instance method
let card = BankCard()
card.deposit(amount: 100)  //card.deposit(100)
// class method
let atm = BankCard.deposit // 接收一个BankCard，返回一个closure  class method：直接使用BankCard类调用它的方法deposit
let depositor = atm(card) // 绑定BankCard.deposit的第一个参数，得到了depositor，此时 depositor 就是BankCard.deposit 的instance method。因此，这样的调用与card.deposit是一样的
//BankCard.deposit()
depositor(100)
card.deposit(amount:100)
depositor(100)
depositor(100)

// instance method背后的故事，本质上 每一个instance method都有一个对应的class method，这个 class method是一个currying function，它接收一个类对象参数，并返回和instance method类型一样的数







//: ### 理解class init的 在各种类型关系下的行为  class初始化过程中的问题
/**
    由于class引入了类型的继承关系，因此它的初始化过程要比struct要复杂得多。为了保证class中所有的数据成员都被正确初始化，swift引入了一系列特定的规则
*/

class Point2D {
//    var x: Double
//    var y: Double  // 这样定义 没有默认的init方法
    var x = 0.0
    var y = 0.0      // 手动初始化，有默认的init方法， 这种默认的init方法只会生成default，即手动指定的初始化的值；如果自定义了init，默认的则失效
    
    
    // designated initializer指定初始化 or memberwise initializer逐个成员初始化
    init(x: Double, y: Double)
    {
        self.x = x
        self.y = y
    }
    
    // convenience initializer 便利初始化
    convenience init(xy: (Double, Double)) // tuple
    {
        self.init(x: xy.0, y: xy.1)
    }
    
    convenience init(val: Double)
    {
        self.init(x: val, y: val)
    }
    
    // 第三种init方法,failable init，解决由于参数问题导致的初始化失败。 定义failable init很简单，直接在init后面加？，然后在init中加上if判断即可
    convenience init?(xyStr: (String, String)) // 传入string类型的tuple // let xyStr = (String, String)
    {
        let x = Double(xyStr.0) // Double?
        let y = Double(xyStr.1)
    
    
        if x == nil || y == nil
        {
            return nil
        }
    
        self.init(xy: (x!, y!))// ! 强制解引用  力展开
        
    }
    
    
}

//let origin = Point2D()
let pt1 = Point2D(x: 10, y: 10)
let pt2 = Point2D(xy: (2.0, 2.0))
// y = x
let pt3 = Point2D(val: 3.0)


// failable init 允许初始化失败的init
let pt4 = Point2D(xyStr:("four", "4.0"))// 传入string类型的tuple。如果传入“four”会报错，此时比较理想的是让它返回一个nil
//pt4.dynamicTpye


/**
    总结：
        1. 所有的convenience init 相互之间可以调用
        2. 但是所有的convenience init，最终要回归调用designated
*/








//: ### 继承关系中，安全的two-phase init手段
// 在一个类的继承体系中，class对象的初始化过程
// 派生类会自动继承基类的方法，而init 作为一个特殊的类方法，它的继承也有些特别，默认情况下，派生类不会自动继承任何基类的init方法，基类的init方法只在有限的条件下才会自动地被派生类继承

class Point3D: Point2D {
//    var z: Double // 如果只定义z，又由于z没有被初始化，所以此时Point3D不会继承Point2D的init初始化方法。
    var z = 0.0  // 1: 调用super.init()之前必须把所有(存储)属性赋值好。如果要让Point3D继承Point2D的所有init初始化方法，给z赋初始值即可
    
    // 如果想自定义init z
    init(x: Double, y: Double, z: Double)
    {
        
        self.z = z // 1-先初始化子类的成员  调用super.init()之前必须把所有(存储)属性赋值好
        super.init(x: x, y: y) // 2-调用父类的init方法，super.init()
        
        // eg-3：
        round(self.x)// 取整，四舍五入  // 2:必须先调用super.init(),然后才可以对继承过来的属性赋值
        round(self.y)
        round(self.z)
        
    }// 同时，子类再也不会自动继承父类的所有init方法了
    
    // 如果还希望子类能从父类继承designated方法的话，只要重载Point2D的designated方法
    override init(x: Double, y: Double) {
        super.init(x: x, y: y)
    }
    
    // 重载父类的convenience方法 不需要加override关键字。如果已经重载了父类的designated方法，则没有必要再重载父类的convenience方法；如果没有，则也可以等同于是自定义子类的convenience
    convenience init(val: Double)
    {
        self.init(x: val, y: val, z: val)
//        super.init(x: val, y: val)// error:自身类的convenience方法必须调用自身类的designated init方法
    }
    /**
     
     总结：
     1.首先，如果Point3D继承了Point2D的designated方法，它必然会自动继承了父类所有的convenience方法；
     2.在Point3D重载了convenience init(val）--调用-》init(x,y,z)。可以看出，无论是Point2D还是Point3D，最终都要回归到调用自身类的designated init)，而子类中所有的designated最终 都要调用父类的designated，来完成父类的初始化过程。图1：
     
     */
    // 自定义子类的convenience
    convenience init(xyz: (Double, Double, Double))
    {
        self.init(x: xyz.0, y: xyz.1, z: xyz.2)
        self.x = 20// 这个写在self.init之前会报错: 3：init方法分designated initializer和convenience initializer，后者要先调用同一个类里面的前者，在调用之后才能给自身或父类的属性赋值。
    }
}
// 如果一子类继承了父类的designated方法，它必然也继承了所有的convenience方法。用这样的方法固然很方便，但是这样定义出来的毕竟只是平面上的点

// 在没有在子类中自定义designated init方法时，可以用下面的方法创建Point3D对象；如果已自定义子类的designated init方法，则不能使用以下的方法；除非重载Point2D的designated方法
let origin3D = Point3D(x: 0, y: 0)
let point3D11 = Point3D(xy: (1.0, 1.0))
let point3D22 = Point3D(xyStr: ("2.0", "2.0"))
let point3D33 = Point3D(val: 3.6)

// 3 test:
let point3D_3 = Point3D(xyz: (1,2,3))

// 如果想自定义init z







//: ### two-phase init， 为了保证初始化过程中，子类和父类的数据成员都能被正确初始化

// 阶段1：子类到父类，自下而上地 让每一个属性都有初始值。因此 在Point3D的init方法里，必须先初始化子类成员（给z赋值），再调用父类init方法
// 阶段2：当一个类的所有数据成员都有初始值的时候，我们才能够对它进行进一步操作，如eg-3：对xyz进行取整的操作,如果将该操作放到super.init前，则会报错


// two-phase init 过程：图2
















