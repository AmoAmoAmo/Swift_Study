//: Playground - noun: a place where people can play

import UIKit


struct Point {
    var x: Double
    var y: Double

}

class PointRef {
    // stored property 存储属性
    var x: Int = 100
    var y: Int = 100
 
    init(x:Int, y:Int)
    {
        self.x = x
        self.y = y
    }
}

enum Direction2: Int{
    case EAST = 2
    case SOUTH = 4
    case WEST = 6
    case NORTH = 8
}

// stored property 存储属性 特点：
// 1. 使用var或let，把stored property定义成变量或常量
// 2. 自定义类型的init方法必须保证每一个stored property都被正常初始化
// 3. 可以在定义properties的时候就给初始值
// 4. 当创建一个自定义类型对象pt的时候，pt的每一个property都实际占据内存空间，每个对象的property都使用pt.x的方式来读取值，pt.x = 150的方式来赋值
let pt = PointRef(x: 10, y: 10)
pt.x
pt.x = 150

// struct 和 class 两种自定义类型可以定义stored property 存储属性； 而enum不可以




//: #### // computed property 计算属性
/**
    每一个stored property 存储属性都表示某一个自定义类型的某种特点,但是有些属性是需要在访问的时候被计算出来的，而不是定义之后一成不变的 --》computed property 计算属性: 作为property 它用来表示属性，但是它的值要通过访问的时候计算出来，而不是从内存中读取出来
*/
// eg:
struct MyRect{
    var origin: Point
    var width: Double
    var height: Double
    
    // computed property 计算属性
    var center: Point{
        get{           // 取值
            let centerX = origin.x + self.width / 2
            let centerY = origin.y + self.height / 2
            
            return Point(x: centerX, y: centerY)
        }
        set(newCenter){// 赋值
            // 假设宽高不变的情况下
            self.origin.x = newCenter.x - self.width/2
            self.origin.y = newCenter.y - self.height/2
        }
        
    }// closure
    
}
let pt11 = Point(x: 1, y: 1)
var rect1 = MyRect(origin: pt11, width: 200, height: 100)
rect1.center    // get
// 当修改rect1的值时，rect1.center也会跟随着变动
rect1.height = 200
rect1.center

// 也可对computed property进行赋值 set
// 要把center，拆分成origin，width，height
//var o1 = rect1.center
//o1.x += 100
//rect1.center = o1
rect1.center = Point(x: 150, y: 100)
rect1.origin




//: ### property observer
/**
    如果想在stored property被赋值之前，自动过滤掉非法值，或者在stored property赋值之后自动更新其他property值，怎么办呢    A：property observer
*/

struct MyRect_2{
    var origin: Point
    // property observer
    var width: Double {
        willSet(newWidth)// newWidth 赋值之后的值
        {
            print("width will be updated，new = \(newWidth)")
        }
        didSet(oldValue)// oldValue 赋值之前的值。 在didSet里面可以直接用它本身的属性名字，而其他的属性需要通过self.去访问
        {
            if width <= 0{
                width = oldValue
            }else{
                self.height = width
            }
        }
    }
    var height: Double
    
}
var rect2 = MyRect_2(origin: pt11, width: 200, height: 100)

rect2.width = 250
rect2.width
rect2.height




// lazy property
class Account{
    let name:String
//    lazy var greeting:String = "hello \(self.name)"
    lazy var greeting : String = {[unowned self] in
        print("greeting is init")
        return "Hello " + self.name}() // [unowned self] 避免内存泄漏，in 表示代码的开始
    
    init(name:String)
    {
        self.name = name
    }
}

let mine = Account(name: "DaKang")// 如果希望Account根据用户name自动生成问候用户信息的属性，就可以用lazy property
// greeting nil
mine.greeting
mine.greeting
mine.greeting
/**
    1. 在greeting第一次被调用之前，它没有被初始化，为nil
    2. 在greeting被多次调用时，它被第一次调用之后，后面就不会再调用了
    3. 通常用来处理对象被初始化过程中需耗时非常长，但是又是不一定被使用的情况
*/






//: ###  type property 类型属性
 //上面都是对象属性，除了对象属性之外，有些属性是属于一个类型的，它们不和具体的对象相关 -》 type property 与c++中的类 静态成员是类似的

enum Shape{// 各种形状
    case RECT
    case TRIANGLE
    case CIRCLE
}

struct MyRect2 {
    static let shape = Shape.RECT// 添加一个属性，用来表示它的对象对应的形状,由于这个属性对MyRect2其他所有属性是一样的，他们都应该是Shape.RECT，所以对MyRect2添加一个type property。 用static关键字来为自定义类型添加type property
    var origin: Point
    var width:Double
    var height:Double
}

let shape = MyRect2.shape

/**
    class，enum 都可以自定义自己的type property
*/
// 访问时 不能用一个对象rect来访问它，而是直接使用该自定义类型的名字MyRect2来访问
let shape2 = MyRect2.shape
MyRect2.shape







