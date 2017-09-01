//: Playground - noun: a place where people can play

import UIKit

// 用currying function介绍Instance Method实现机制。简单来说，swift中的每一个Instance Method都是一个class Method，这个class Method接收一个class Instance参数，并且返回一个和Instance Method类型一样的函数。eg-1：
class BankCard
{
    var balance: Double = 0 // 余额
    
    func deposit(amount: Double)
    {
        self.balance += amount
        print("current balance: \(self.balance)")
    }
}

// Instance Method
let card = BankCard()
card.deposit(100)
//card.deposit(100)

/**
    当我们定义atm的时候就得到了一个currying function，在playground里可以看到它是一个接收BankCard参数 返回一个closure的类型，而这个closure类型和deposit Instance Method是一样的。接下来像这样绑定了一个BankCard.deposit的第一个参数，得到了一个depositor，此时这个depositor就是BankCard的deposit Instance Method，因此eg**这样的调用和card调用deposit是一样的。可以反复调用depositor(100)
*/
let atm = BankCard.deposit
let depositor = atm(card)

depositor(100) // eg**
depositor(100)
depositor(100)
depositor(100)

// 这就是在swift里发生在Instance Method背后的故事，本质上每一个Instance Method都有一个和它对应的class Method，这个class Method是一个currying function，它接收一个类对象参数，并且返回一个和Instance Method类型相同的函数







































