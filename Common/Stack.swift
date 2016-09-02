//
//  Stack.swift
//  NJToDo
//
//  Created by Nugget Jiang on 16/7/1.
//  Copyright © 2016年 Nugget Jiang. All rights reserved.
//

import Foundation

//栈
class Stack{
    var stack:[AnyObject]
    init(){
        stack = [AnyObject]()
    }
    func push(object:AnyObject){
        stack.append(object)
    }
    func pop()->AnyObject?{
        if !isEmpty() {
            return stack.removeLast()
        }else{
            return nil
        }
    }
    func isEmpty()->Bool{
        return stack.isEmpty
    }
    func peek()->AnyObject?{
        return stack.last
    }
}

//队列
class Queue{
    var queue:[AnyObject]
    init(){
        queue = [AnyObject]()
    }
    func enqueue(object:AnyObject){
        queue.append(object)
    }
    func dequeue()->AnyObject?{
        if !isEmpty() {
            return queue.removeLast()
        }else{
            return nil
        }
    }
    func isEmpty()->Bool{
        return queue.isEmpty
    }
    func peek()->AnyObject?{
        return queue.last
    }
    func size()->Int{
        return queue.count
    }
}


//树
class TreeNode{
    var value:Int
    var left:TreeNode?
    var right:TreeNode?
    init(_ val:Int){
        self.value = val
        self.left = nil
        self.right = nil
    }
    func maxDepth(root:TreeNode?)->Int{
        guard let root = root else{
            return 0
        }
        return max(maxDepth(root.left),maxDepth(root.right))+1
    }
    func isValidBST(root:TreeNode?)->Bool{
        return _helper(root, nil, nil)
    }
    private func _helper(node:TreeNode?, _ min:Int?, _ max:Int?)->Bool{
        guard let node = node else{
            return true
        }
        if min != nil && node.value <= min {
            return false
        }
        
        if max != nil && node.value >= max{
            return false
        }
        return _helper(node.left, min, node.value) && _helper(node.right, node.value, max)
    }
}

class Algorithm{
    func binarySearch(nums:[Int],target:Int)->Bool{
        var left = 0
        var right = nums.count-1
        var mid = 0
        while left <= right{
            mid = (right-left / 2) + left
        }
        return false
    }
}