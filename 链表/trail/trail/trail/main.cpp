//
//  main.cpp
//  trail
//
//  Created by licong on 2017/3/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

#include <iostream>
#include<stack>
#include<queue>

struct ListNode{
    int m_nValue;
    ListNode *m_pNext;
};


//在链表的尾部添加一个节点
void AddTotail(ListNode ** pHead, int valua){
    ListNode *pNew = new ListNode();
    pNew->m_nValue = valua;
    pNew->m_pNext = NULL;
    if (*pHead == NULL) {
        *pHead = pNew;
    } else {
        ListNode *pNode = *pHead;
        while (pNode->m_pNext != NULL) {
            pNode = pNode->m_pNext;
        }
        pNode->m_pNext = pNew;
    }
}



void RemovewNode(ListNode ** pHead, int valua){
    if (pHead == NULL || *pHead == NULL) {
        return;
    }
    ListNode *pToBeDeleted = NULL;
    if ((*pHead)->m_nValue == valua) {
        pToBeDeleted = *pHead;
        *pHead = (*pHead) -> m_pNext;
    } else {
        ListNode *pNode= *pHead;
        while (pNode->m_pNext != NULL) {
            pNode = pNode->m_pNext;
            
        }
    }
}


//输入一个链表的头节点，从尾到头翻过来打印每个节点的值

//解法1,利用栈
void PrintListReversingly_Iteratively(ListNode* pHead) {
    std::stack<ListNode *>nodes;
    ListNode *pNode = pHead;
    while (pNode != NULL) {
        nodes.push(pNode);
        pNode = pNode->m_pNext;
    }
    
    while (!nodes.empty()) {
        pNode = nodes.top();
        printf("%d\t",pNode->m_nValue);
        nodes.pop();
    }
}

//解法2利用递归,递归当链表非常长的时候，会导致函数的调用层级很深，基于栈的循环实现的代码的鲁棒性比较好
void PrintListReversingly_Recursively(ListNode* pHead) {
    if (pHead != NULL) {
        if (pHead->m_pNext != NULL) {
            PrintListReversingly_Recursively(pHead->m_pNext);
        }
        printf("%d\t",pHead->m_nValue);
    }
}




int main(int argc, const char * argv[]) {
    // insert code here...
    std::cout << "Hello, World!\n";
    return 0;
}
