//: Playground - noun: a place where people can play

import UIKit

//===============================
func addValue(originValue:Int)(inputVlue:Int) ->Int{ //这种两个括号就是currying函数的写法
    
    return originValue + inputVlue
    
}

let addValue10 = addValue(10)//这一步不会返回具体值而是返回余下函数 (在playground中不难看出)



addValue10(inputVlue:10) //到这里才会返回具体的值 == 20



class BankAccount {
    
    var balance:Double=0.0
    
    func deposit(amount:Double) {
        
        balance += amount
        
    }
    
}

let account = BankAccount()

account.deposit(100)//  100

//上面是调用实例方法的方式，但是我们还可以通过如下方式调用：
let depositor = BankAccount.deposit

depositor(account)(100)// balance is now 200

// 实例方法其实就是类方法以对象为第一个参数的currying化过程。deposit方法 的形式为：

//let depositor:BankAccount -> (Double) -> ()



