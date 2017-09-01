//: Playground - noun: a place where people can play

import UIKit

// 把一组类型相关的

//
enum Week:Int{
    case MON   = 2
    case TUES  = 4
    case WED   = 7
    case THUR
    case FRI
    case SAT
    case SUN
}

let week1 = Week.FRI.rawValue
let week2 = Week(rawValue: 7)

enum Subject{
    case Chinese,English,Chemistry,History
}
let mySubject = Subject.Chinese
print(Subject.Chinese)

func week(today: Week)
{
    switch today{
    // 因为today可以通过类型推导推出它的类型是Week，所以不用today.MON，而是直接写.MON
    case .MON, .TUES, .WED:
        return
    case .THUR, .FRI, .SAT, .SUN:
        return
    }
}



//----------------------------------------------------------
enum Direction{
    case EAST
    case SOUTH
    case WEST
    case NORTH
}

enum Month: Int{
    case January = 10, Februray, Marth, April, May, June, July, August, September, October, November, December
}

let N = Direction.NORTH
let JAN = Month.January
/**
    使用enum比使用字符串或数字有很多好处，1 避免输入错误，2 使用enum类型是安全的，当使用Direction或Month时，不会发生类型正确，值却没有意义的情况
*/



//: ### enum value
/**
    在swift中，enum的值可以通过多种不同的方式来表达
    而OC或其他语言中，最终只能通过一个整数来替代

    如 在使用Direction.NORTH的时候，就已经在访问一个enum的值了，它的case就是它的值本身，无需刻意地定义一个值来代表它。如果通过type inferrance可以推导出它的类型，则可在读取值的时候，省掉它类型的名字
*/


// 把东南西北转换成上下左右
func direction(val: Direction) -> String
{
    switch val{
        // 因为val可以通过类型推导推出它的类型是Direction，所以不用val.NORTH，而是直接写.NORTH
    case .NORTH, .SOUTH:
        return "up down"
    case .EAST, .WEST:
        return "left right"
    }
}
// 对于一个enum的switch来说，它的所有的case就是它全部的情况，所以最后不用再写default



//: ### enum值的表达方式1：raw value原始数值
enum Direction2: Int{// 手动为enum指定值
    case EAST = 2
    case SOUTH = 4
    case WEST = 6
    case NORTH = 8
}
enum Month2: Int{
    case January = 10, Februray, Marth, April, May, June, July, August, September, October, November, December
}
// 访问enum的值
let Nor = Direction2.NORTH.rawValue
// 用rawValue来访问一个enum的值
let S = Direction2(rawValue: 4) // fialable initializer
type(of: S)


//: ### enum值的表达方式2： associated value结合值->给每一个case绑定不同类型的值
enum HTTPAction{
    case GET  // 不关联任何值
    case POST(String)// 关联一个字符串
    case PUT(Int, String)// 关联一个tuple
}

let get = HTTPAction.GET
let post = HTTPAction.POST("hello")
let put = HTTPAction.PUT(1, "world")

// 通过switch访问enum的结合值associated value
func actionDesc(action: HTTPAction)
{
    switch action
    {
    case .GET:
        print("get")
    case let .POST(msg):// let msg = action
        print("post: \(msg)")
    case .PUT(let num, let name):
        print("put: \(num): \(name)")
    }
}

actionDesc(action: get)
actionDesc(action: post)
actionDesc(action: put)



/**
    swift中的optional是基于enum实现的
*/
//let addr: String? = nil
let addr: String? = .some("BeiJing")
//let addr1:Optional<String> = nil
let addr1:Optional<String> = .none















