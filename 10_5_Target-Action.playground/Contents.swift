//: Playground - noun: a place where people can play

import UIKit


// currying function

// Target-Action是iOS处理交互事件的一种设计模式，当有用户交互时，它把通知UI组件响应事件 以及UI组件对事件的响应细节 安全地进行了分离，这种思想有点儿类似于函数式编程。它是如何基于currying function实现的

// 为了达到这种分离效果，我们要先把调用某个类的某个方法这件事情单独封装起来
protocol TargetAction
{
    func performAction()// 用来实现调用某个类的某个方法
}

// 泛型参数T，必须是AnyObject的派生类，然后遵从TargetAction
struct TargetActionWrapper<T: AnyObject>: TargetAction {
    
    weak var target: T? // 要调用的方法对应的对象
    let action: (T) -> () -> () // closure，该closure接收一个T类型的参数 并返回一个无参也无返回值的closure。action可以理解为一个类型T的target Method，它对应类型T的一个没有参数也没有返回值的Instance Method，然后  // 定义一个Currying函数变量 为什么这样定义？ 是因为实例方法就是类方法将对象本身作为第一个参数的curyying过程 所以最后我们setTarget时 action为类方法的定义
    
    
    // TargetAction protocol
    func performAction() {
        
        if let target = self.target  // 如果self.target不为nil
        {
            action(target)() // 绑定action的第一个参数，这样就得到了 ()->()，然后使用第二个()来调用这个函数，
        }
    }
}

// 模仿一个button组件的实现
enum ButtonEvent
{
    case TouchUpInside
}

class Button {
    var action = [ButtonEvent : TargetAction]() // dict
    
    deinit
    {
        print("Button is deinit")
    }
    
    // 给Button添加一对处理action的方法，它们是和Button的使用者打交道的API
    func setTarget<T: AnyObject>(target: T, action: (T) -> () -> (), event: ButtonEvent) // 它是一个泛型函数，用来给Button添加事件处理方法，它的泛型参数T要求必须是从AnyObject派生的类型，然后 它有3个参数，分别设置action中的ButtonEvent和TargetAction，target的类型是T，action它的类型和TargetAction中的action属性类型是一样的，event的类型是ButtonEvent，表示要处理的事件。  setTarget 的实现很简单，只需给action添加一对key-value即可
    {
        self.action[event] = TargetActionWrapper(target: target, action: action) // 这样就给target添加了一个处理event的TargetActionWrapper
    }
    
    // 给Button添加一个删除事件的方法
    func removeTargetForEvent(event: ButtonEvent)
    {
        self.action[event] = nil
    }
    
    func performActionForEvent(event: ButtonEvent)
    {
        self.action[event]?.performAction() // 如果self.action[event] 不为nil，就执行对应的TargetActionWrapper来处理事件
    }
}


// 模拟Button在Controller中的实现
class MyViewController
{
    let button = Button()
    
    deinit
    {
        print("MyViewController is deinit")
    }
    
    func onPressed()
    {
        print("button was presswd")
    }
    
    func viewDidLoad() // 模拟控件的初始化
    {
        self.button.setTarget(self, action: MyViewController.onPressed, event: .TouchUpInside)
    }
} 


// 模拟button被点击的事件
func demo()
{
    let controllerObj = MyViewController()
    controllerObj.viewDidLoad()
    controllerObj.button.performActionForEvent(.TouchUpInside)
}

demo()

/**

如果给MyViewController和Button添加一个deinit，但此时并没有调用到这两个deinit，很明显，这其中存在着对象间的循环引用了，

图：
1.当我们在demo里创建controllerObj的时候，就创建了一个指向MyViewController对象的强引用； 
2. 当我们在MyViewController里创建button的时候，就创建了一个指向Button的强引用； 
3. 而当我们在button.setTarget里设置了action的时候，就创建了一个指回MyViewController的强引用。 
因此，当demo函数退出之后，只有controllerObj这个强引用被去掉了，而button和TargetAction之间造成的循环引用 使得这两个对象都没有办法被正常释放。

解决方法：找到这个引起循环引用的optional，把它改成weak reference即可

*/


// 得益于currying function，我们把通知UI处理事件以及事件的处理细节进行了分离，在这个

































