//
//  main.cpp
//  栈和队列
//
//  Created by licong on 2017/3/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

#include <iostream>
#include<stack>
#include<queue>
//用两个栈实现一个队列。队列的声明如下，请实现两个函数appendTail和deleteHead,分别完成在队列尾部插入节点和头部删除节点的功能
template <typename T>
class CQueue {
public:
    CQueue(void);
    ~CQueue(void);
    
    void appendTail(const T & node);
    T deleteHead();
    
private:
    std::stack<T> stack1;
    std::stack<T> stack2;
};




int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}
