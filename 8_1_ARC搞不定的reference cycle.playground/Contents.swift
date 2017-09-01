//: Playground - noun: a place where people can play

import UIKit

//: ### ARC - automatic reference counting 自动引用计数
// 即使swift使用ARC为我们管理内存，但这并不代表它面对所有的情况时都足够聪明。当对象之间存在相互引用的时候，更是容易由于循环引用而导致的内存无法释放。swift提供了一系列语言机制来处理循环引用，而我们自己也应该时刻保持警惕来避免内存泄漏。 为了理解ARC是如何工作的，我们先来看一个例子

// 单个对象:
class Person {
    let name: String
    // eg:
    var apartment: Apartment? // 租公寓
//    weak var apartment: Apartment?
    // eg2:
    var property: Apartment? // 房产
    
    init(name: String)
    {
        self.name = name
        print("init 被调用了")
    }
    
    deinit // 析构函数
    {
        print("deinit 调用结束")
    }
}

/**
    deinit属于析构函数

    析构函数(destructor) 与构造函数相反，当对象结束其生命周期时（例如对象所在的函数已调用完毕；对象的引用计数为0时），系统自动执行析构函数

    和OC中的dealloc 一样的,通常在deinit和dealloc中需要执行的操作有:

    对象销毁
    KVO移除
    移除通知
    NSTimer销毁
*/

//: Strong reference 强引用
// ref1 ref2都会引起派生对象Person的引用计数的改变，因此管它叫做strong reference 强引用。一个强引用会导致它引用的对象存活在内存里。对于Person这样的单个对象来说，ARC可以很好地默默地为我们工作，但是当不同类对象之间存在相互引用时，指向彼此的strong reference，就会导致循环引用，使得ACR无法释放它们之中的任何一个，
//var ref1: Person?
//var ref2: Person?
//
//ref1 = Person(name: "LiSi") // Person对象的引用计数为1
//ref2 = ref1                 // 引用计数为2
//
//ref1 = nil                  // Person对象的引用计数 -1，1
//ref2 = nil                  // Person对象的引用计数 -1，0

// eg: 不同类对象之间
class Apartment
{
    let unit: String  // 公寓的房间号
//    var tenant:Person?  // 房客
    weak var tenant:Person? // 设置为weak reference，此时Person和Apartment的deinit都被正确调用了
    
    // eg2:
//    let owner: Person
    unowned let owner: Person// 设置为unowned，此时Person和Apartment的deinit都被正确调用了
    
//    init(unit:String)
//    {
//        self.unit = unit
//        print("Apartment init")
//    }
    init(unit:String, owner: Person)// eg2:
    {
        self.unit = unit
        self.owner = owner
        print("Apartment init")
    }
    
    deinit
    {
        print("Apartment deinit")
    }
}


var lisi: Person? = Person(name: "Lisi")// ? 让对象lisi可以指向nil
//var apart1:Apartment? = Apartment(unit: "101")
// eg2:
var apart1:Apartment? = Apartment(unit: "101", owner: lisi!)

// 2. 如果在指向nil之前，让它们互相引用
lisi!.apartment = apart1
apart1!.tenant = lisi


// 1. 让它们都指向nil，此时它们的deinit函数都被调用了
lisi = nil
apart1 = nil

// 2. 当把lisi，apart1这两个值都设为nil后，已经没有任何手段可以指向Person和Apartment这两个对象了，但是实际上apartment和tenant之间还存在着相互引用，所以 只要程序不退出，这两个占用的内存始终都不会被释放。这就是循环引用带来的内存泄漏的问题











// ******* 帮ARC搞定循环引用的三种方法 *********
// 要解决循环引用带来的内存泄漏的问题，根据一个类的数据成员是否允许为nil，我们有不同的处理方法。


//: ### 1 两方都允许为nil
// 例子中，apartment和tenant的值都允许为nil，对于这样的值，可以用weak reference来解决问题。把weak reference就理解成一个普通的optional，只不过当weak reference指向普通对象的时候，它并不会使对象的引用计数增加，而当weak reference指向的对象不存在的时候，ARC会自动把一个weak reference设置为nil。在例子中，可以把引起循环引用的任何一个成员的strong reference设置成weak reference
    /**

    weak reference 。。。带来了哪些改变：

    1. 把tenant从strong-》weak，这样，当我们再给tenant赋值的时候，Person对象的引用计数就不会+1；
    2. 当lisi = nil的时候，这时 就不会再有strong reference指向Person对象，对象的引用计数为0，ARC就会把Person对象删除掉，进而Apartment对象的引用计数就会-1；
    3. 当apart1 = nil的时候，此时Person已经不存在了，也没有任何strong reference指向Apartment，于是ARC也会把Apartment释放掉

    */






//: ### 2
// 当引起循环引用的一方不允许为空的时候，使用unowned reference来解决问题
    /**

    eg2:  发现此时两个对象的deinit函数又没有被调用，说明此时两个对象之间又存在着循环引用了（图）。
    
    解决的方法：破坏掉其中的一种strong reference就可以了。
        方法1.由于owner是不能为nil，所以不能把它定义为weak reference，此时我们可以使用unowned reference。unowned reference与strong reference唯一的区别就是，unowned reference不会使当前对象的引用计数+1
        方法2. 也可直接把apartment设置成weak reference

    weak与unowned：
        在引用对象的生命周期内，如果它可能为nil，那么就用weak引用。反之，当你知道引用对象在初始化后永远都不会为nil就用unowned.
        就像是implicitly unwrapped optional（隐式可选类型），如果你能保证在使用过程中引用对象不会为nil，用unowned 。如果不能，那么就用weak

    */





//: ### 3
// 当引起循环引用的两方都不允许为空的时候，使用unowned reference来解决问题
/**
    Country要有一个City类型的member作为首都，
    City要有一个Country类型的member作为归属

    一个国家不可能没有首都
    一个城市不可能没有归属，所以它们都不能为optional？
        var capital: City 即可

*/
class Country {
    let name: String
    // implicitly unwrapped optional 隐式可选类型
    var capital: City! // default to nil  首都
    
    init(name: String, capitalName: String)
    {
        self.name = name
        self.capital = City(name: capitalName, country: self)
        /**
        而定义Country对象 的初始化过程中 又需要创建一个City对象 赋值给capital。
        所以eg3：这里 就接收一个city的字符串capitalName 给init做参数；调用City的构造函数，传入capitalName 从而创建一个City对象，
        在Country里可以把当前正在创建的Country对象传递给City的构造函数
        
        self，直接使用会报错：swift认为，Country对象还没有被初始化完，因此不允许把self传给其他类的构造函数。
        
        解决此问题的唯一办法：让capital有一个默认的空值。
        
        此时对于capital来说，有两个顺序需求：
            1. 对于Country的使用者来说，capital就像是一个普通的数据成员，它不能够为空； 
            2. 但是作为Country的设计者来说，capital又要有一个像optional一样 默认为空值。 
        而同时可以满足这两种要求的方式只有一个：
            把capital定义为一个implicitly unwrapped optional 隐式可选类型。（在City后+！）。
            这样 当self.name被赋值之后，swift编译器就会认为Country所有的成员都有了初始值，因此 接下来就可以把self作为一个完整的Country对象传递给City的init函数了
        */
    }
    deinit
    {
        print("*****")
    }
}

class City {
    let name: String
    unowned let country: Country  // 归属
    
    init(name: String, country: Country) // 这里就像初始化一个普通的member一样。需要接收一个Country对象,  eg3：
    {
        self.name = name
        self.country = country
    }
    deinit
    {
        print("*****")
    }
}

var cn: Country? = Country(name: "China", capitalName: "beijing")
var bj: City? = City(name: "hfi", country: cn!)

cn?.capital
bj?.country

cn = nil
bj = nil
// 设置为nil后，capital和country之间仍然会导致一个循环引用。解决这种情况下的循环引用与上一个例子是类似的，即 把不能够为空的member（country）设置为unowned









