//: Playground - noun: a place where people can play

import UIKit


// swift是一种支持多种编程范式的语言，除了传统的面向对象的方式之外，它还支持functional programming函数式编程。eg-1：在数组中过滤出所有的偶数:
var numsArr = [1,2,3,4,5,6,7,8,9]

var evensArr = [Int]() // Int的普通数组

for n in numsArr
{
    if n % 2 == 0
    {
        evensArr.append(n)
    }
}

evensArr

// 但是这样的代码有着一个明显的弊端，就是如果我们需要一个奇数的时候，我们需要复制整个for循环，并且需要把它修改成 != 0，如果我们在后面的代码中还需要过滤掉2的倍数，3的倍数，4的倍数呢？难道就只能继续复制很多个for循环？这显然是违背了代码的原则。实际上在swift中，array提供了一个更简单直接的方式：

// filter 接收了一个参数，用来让我们指定数组的过滤条件，这个过滤条件是一个closure，条件：n能被2整除。让这个返回值保存在一个数组里。这里closure { (n: Int) -> Bool in return n % 2 == 0}可以简化成首先可以使用type inference去掉closure参数和返回值的描述，之后可以使用single expression去掉return关键字，然后可以使用参数替代符$0来替代参数：
let evenArr1 = numsArr.filter({ $0 % 2 == 0})
evenArr1


/**
讲到这里，其实我们已经开始使用functional programming函数式编程了，filter就是functional programming的一个应用。我们管这种接收一个closure作为函数参数的函数叫做high order function高阶函数。

那么究竟什么是functional programming呢？
    如同面向对象一样，functional programming是一个关于我们思考方式的问题，而不是一个我们要做什么的问题。
    在面向对象的世界里，我们把要解决的问题抽象成一个一个的类，通过类之间的通信来解决问题；
    而functional programming则是通过函数来描述我们要解决的问题 以及我们要解决的方案。
*/

//

//
/**
    1. 类似filter这样的函数 我们叫做mathematical function数学函数

    2. 而对于我们平时在编程中定义的一般函数，我们叫做computational function计算的函数

它们的区别是：
    computational function，它是一组完成特定任务指令的封装，关心的是要完成的任务本身；
    mathematical function，它关注的是描述参数和返回值之间的关系，通过这种关系，确定的一个参数将总是有固定的返回值。这也正是mathematical function名字的来源，它并不是一个只使用数学公式的函数，而指遵从数学中对于函数定义的函数。
 
对于匀速直线运动来说：S位移 = V速度 * t时间，
    对于一个速度是每小时80公里的物体来说 它的位移f(t) = 80 * t，这时，f(t)就是一个mathematical function； eg-2:
    而实际上 这个distance会受其他因素的影响 eg-3: 这时这个函数就变成一个computational function，它只是一个用于完成计算位移的函数，却不能够准确地描述时间t和位移之间的关系
 
 通过这样的对比，我们不难发现：
    在一个computational function里通常存在控制结果的多个维度，并且让结果变得不确定；
    而functional programming的思考方式，就是去掉这些不确定因素，让同样的输入总是产生同样的结果。
 
 在理解了computational function和mathematical function的区别之后，我们用functional programming的思想，给array类型添加一个自定义的filter，eg-4:
*/

//func distance(t: Double) -> Double // eg-2:
//{
//    return 80 * t
//}
//func distance(t: Double) -> Double // eg-3:
//{
//    let condition = externalCondition
//    return 80 * t * condition
//}



// eg-4:
extension Array
{
    func myFilter<T>(predicate: (T) -> Bool) -> [T]// 由于Array里可以保存任何类型的元素，因此myFilter我们要把它实现成一个泛型函数，和标准的filter一样，myFilter接收一个参数，predicate用来表示过滤的条件，接收一个参数用来表示数组元素的类型，返回一个bool值，最后让myFilter返回一个新的T类型的数组
    {
        // 对于myFilter的实现，则和我们一开始手动过滤偶数的方式是类似的
        var tmp = [T]() // T类型的空数组
        
        for i in self
        {
            if predicate(i as! T) // 当predicate的返回值为true的时候，把i添加到tmp
            {
                tmp.append(i as! T)
            }
        }
        return tmp
    }
}

// 然后就可以像使用标准filter一样使用这个函数，读取数组中的奇数
let oddsArr = numsArr.myFilter({ $0 % 2 != 0})

oddsArr

/**

    在我们实现了myFilter之后，应该对functional programming有一个更深的理解了，最初 我们要解决的问题是，在数组中过滤满足特定条件的元素，我们把解决需求的方式封装在一个名为myFilter的函数里，作为一个mathematical function，myFilter只是定义了输入值和输出值之间的关系，而并没有关心实际过滤的细节本身，甚至我们可以说，除了定义输入数组和输出数组之间的关系之外，myFilter什么也没有做。通过functional programming，我们可以直接把过滤的结果保存在一个常量里，而不像一开始，我们手动过滤的evenArr它只能是一个变量，因为需要不断地往里面添加数据。事实上，尽可能多地使用常量也是functional programming的一个核心主张。

    在通过filter理解了functional programming之后，还有另外两个high order function高阶函数：map，reduce

*/

























