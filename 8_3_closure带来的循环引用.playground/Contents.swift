//: Playground - noun: a place where people can play

import UIKit

// 循环引用还有可能发生在一个closure和一个对象之间，特别是，如果一个closure是一个类的数据成员，如果不妥善处理使用，很大概率会发生循环引用

// eg：循环引用是如何在一个closure里面发生的
class HTMLElment
{
    let name: String
    let text: String?
    lazy var asHTML: Void ->String = {
        // capture list : 1. 如果需要在capture list里面设置多个成员的话，就使用，把它们分开，如[unowned self, weak otherMenbers]; 2. 对于一个完整的closure来说，capture list必须写在参数列表的前面:
        [unowned self] () -> String in
//        [unowned self] in
        // 如果text不为空时，就把它渲染成：<name>text</name>
        if let str = self.text
        {
            return "<\(self.name)>str</\(self.name)>"// 当这样写时，swift无法确定当我们访问asHTML的时候，self一定被完整地初始化过了。如果我们需要这种保证，就把asHTML定义成一个lazy成员。一个类对象的lazy member只要它被完整地初始化之后才能够被访问
        }else{
            // text为空时
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil)
    {
        self.name = name
        self.text = text
    }
    deinit
    {
        print("\(self.name) deinit")
    }
}

var h1: HTMLElment? = HTMLElment(name: "h1", text: "Title") // 这时 如果想要把h1代表的HTML元素像这样：<h1>Title</h1> 打印出来，为了方便定义这个操作，把它定义成一个closure

// 2. 如果先去访问asHTML，再让h1 = nil，此时deinit没有被调用，说明h1没有被销毁，一定是存在循环引用。 原因... closure作为一个引用类型，它有自己的对象，又由于closure里面引用了self.text, self.name，因此它就捕获了这个新创建的HTMLElment对象，同时asHTML又有一个指向closure的strong reference ，因此即便我们把h1设置为nil，HTMLElment对象和它自身的closure之间仍然会存在一个循环引用。解决：只要根据closure捕获的变量是否允许为空，把它们分别设置成weak或者unowned就可以。 capture list：它用来指定一个closure捕获变量的方式，使用[]来代表capture list，然后在里面写上捕获变量的方式。对于使用了capture list的closure，一定要使用关键字in来代表closure代码的开始。通过unowned方式捕获到的self并不会使HTMLElment的引用计数增加
h1!.asHTML
h1?.asHTML


// 1. 直接让h1 = nil，可以看到deinit被正确调用了
h1 = nil














































