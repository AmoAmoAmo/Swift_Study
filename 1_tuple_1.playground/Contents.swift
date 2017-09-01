//: Playground - noun: a place where people can play

import UIKit

let success  = (200, "HTTP OK")
let fileNotFound = (404, "File not found")

let me = (name: "josie", num:11, email:"qq.com")


for index in 1...5
{
    print(index)
}


for index in 1..<5
{
    print(index)
}


var arr1:Array<Int> = Array<Int>()
var arr2:[Int] = arr1
var arr3 = arr2
var arr4:[Int] = []


var arr5 = [Int](repeating: 1, count: 3)
var arr6 = arr5 + arr5

var array1 = [1,2,3,4,5,6]

array1[2]
array1[0...1]
array1[1...3]
array1[1..<3]

array1[0...1] = [5]
array1


array1.enumerated()
for (index,value) in array1.enumerated(){
    print("Index:\(index) Value:\(value)")
}


//: ### set
let set1 = Set<Character>()

let set2:Set<Character> = ["a","e","i","o","u","q"]
let set3:Set = [2,4,6,8,10,7]

for num in set3
{
    print(num)
}

for num in set3.sorted()
{
    print(num)
}

//: operation

var setA:Set = [1,2,3,4,5,6]
var setB:Set = [4,5,6,7,8,9]

let interSectAB:Set = setA.intersection(setB)
let exclusiveAB:Set = setA.symmetricDifference(setB)
let unionAB:Set = setA.union(setB)
//let aSubstractB:Set = setA.subtract(setB)



//: ### Dictionary

var dic = [Int:String]()
dic[1] = "one"
dic[10] = "tem"

dic = [:]

var dict = [
    1:"壹",
    2:"贰",
    3:"叁",
    4:"肆"
]

dict.updateValue("一", forKey: 1)
dict[2] = "二"
dict


for (key,value) in dict
{
    print("\(key): \(value)")
}

for num in dict.keys.sorted()
{
    num
    print("\(num)")
}


let keyArr = [Int](dict.keys)


var i = 0
while i < 10
{
    i += 1
    print(i)
    
}

repeat{
    print(i)
    i += 1
}while i < 5






































