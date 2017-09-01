//: Playground - noun: a place where people can play

import UIKit

class Flight
{
    var delay: Int
    var normal: Int
    var flyHour: Int
    
    init(d: Int, n: Int, f: Int)
    {
        self.delay = d;
        self.normal = n
        self.flyHour = f
    }
    
    func delayRate() -> Double {
        return Double(delay) / Double(delay + normal)
    }
    
}
class CancellableFlight: Flight {
    var cancel: Int
    
    init(d: Int, n: Int, f: Int, c: Int) {
        self.cancel = c
        super.init(d: d, n: n, f: f)
    }
    
    override func delayRate() -> Double {
        return Double(delay + cancel) / Double(delay + normal + cancel)
    }
}

//struct A330: Flight {}
//struct A380: Flight {} // error：A380不能从Flight中继承 (此时被swift看作是继承关系)
//
/**
    swift里，从基类派生是class的专属行为，我们不能够通过继承来拓展一个非class的自定义类型。因此在swift里面使用protocol的一个好处就是 可以更方便地拓展所有的自定义类型。

    并且，即便在我们的这个例子里，我们可以把struct改成class,但是还是有可能会面对一些潜在的问题，

eg：如果我们要表达A380对象是可以被取消的，用面向对象的做法：
1.在A380里添加一个用于表示取消次数的属性，然后在init里对它做相应的初始化。

2.如果还要表达更多的可取消的航班类型，就索性让A380的继承体系加深一层：首先要定义一个新的基类CancelableFlight，表示可取消的航班类型，实现方式与A380里的一样，然后让A380继承自CancelableFlight，然后去掉那些重复的代码。

此时，无论用哪种方法，如果我们把取消也定义成某种形式的延误，那么在Flight中实现的delayRate也要做相应的修改：在CancelableFlight里我们要重新定义delayRate，首先要把它定义成override方法，然后在计算总延时次数的时候要加上cancel，同样 在计算总次数的时候也要加上cancel。
这种方法看上去很自然，实际上我们正不知不觉地陷入一个全功能型接口的深渊，试想一下，随着对Flight各种功能需求的增加，如果我们按照这条路继续走下去，也许未来会实现出类似 双层四引擎往返可取消航班TwoLayerFourEngineRoundTripCancellableFlight这样的怪物了。这种全功能型类型 不仅带来了日益复杂的学习成本，也带来了复杂的内部逻辑关联，以至于最终我们难以说清 一个修改会带来的潜在影响，于是最终没人敢再去更新或者维护它。
之所以类型会越来越复杂 是因为我们在类方法里不断暴露的实现细节和类型自身要表达的功能之间的耦合度越来越强造成的。对于CancelableFlight来说，我们为什么要把计算总延误次数和计算总飞行次数 暴露给它呢？ CancelableFlight只用于表示一个可取消的航班，它完全没有必要去理解那些总次数的计算之类的细节。
而解决全功能型类型的方法，就是把这些和类型无关的细节从类型的定义中去掉，让它变成对类型的一种修饰，这就是Protocol Oriented Programming 面向协议编程要表达的含义。同样是给航班添加取消次数的信息，这一次看protocol是如何来实现的：；
2.；
*/
class A330: Flight {}
class A380: CancellableFlight {
//    var cancel: Int
//    
//    init(d: Int, n: Int, f: Int, c: Int) {
//        self.cancel = c
//        super.init(d: d, n: n, f: f)
//    }
}














































