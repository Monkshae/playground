//: Playground - noun: a place where people can play

import UIKit



/*
 二叉树 http://mp.weixin.qq.com/s?__biz=MjM5NTIyNTUyMQ==&mid=2709545300&idx=1&sn=8c99cbc091670b956c08d3f59d7241f1&scene=0#wechat_redirect
 */
private class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init(_ val: Int) {
        self.val = val
        self.left = nil
        self.right = nil
    }
}


//翻转二叉树
private class Solution1 {
    func invertTree (_ root: TreeNode?) -> TreeNode? {
        guard let root = root else { return nil }
        root.left = invertTree(root.left);
        root.right = invertTree(root.right);
        
        let tmp = root.left
        root.left = root.right
        root.right = tmp
        return root;
    }
}


// 给你一棵二叉树，请按层输出其的节点值，即：按从上到下，从左到右的顺序。
private class Solution {
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        guard let root = root else {
            return []
        }
        var result = [[TreeNode]]()
        var level = [TreeNode]()
        
        level.append(root)
        while level.count != 0 {
            result.append(level)
            var nextLevel = [TreeNode]()
            for node in level {
                if let leftNode = node.left {
                    nextLevel.append(leftNode)
                }
                if let rightNode = node.right {
                    nextLevel.append(rightNode)
                }
            }
            level = nextLevel
        }
        
        let ans = result.map { $0.map { $0.val }}
        return ans
    }
}

//public class T {
//    fileprivate var val: Int = 0
//    public init(_ val: Int) {
//         self.val = val
//    }
//
//}

//let x = [[T(2),T(3),T(4)],[T(5),T(6),T(7)]]
//let ans = x.map { $0.map { $0.val }}
//print(ans)

//let y =  [T(2),T(3),T(4)]
//print(y.map{ $0.val })
