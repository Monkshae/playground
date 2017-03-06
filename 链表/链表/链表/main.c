//
//  main.c
//  链表
//
//  Created by licong on 2017/3/4.
//  Copyright © 2017年 Richard. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>


typedef struct student {
    int id;
    char name[20];
    struct student *next;
} stu;


// 创建一个结点
stu *creatNode(void)
{
    stu *pnew = (stu *)malloc(sizeof (stu));
    if (!pnew)
    {
        printf("创建结点失败!\n");
        return NULL;
    }
    
    printf("请输入学生的学号和姓名!:");
    scanf("%d %s",&pnew->id,pnew->name);
    pnew->next = NULL;  // 非常重要
    return pnew;
}

// 删除结点
stu *deleteList(stu *head)
{
    int id;
    stu *prev = NULL;
    stu *tmp = head;
    if (tmp == NULL)
    {
        printf("链表不存在，请先创建再删除!\n");
        return NULL;
    }
    
    printf("请输入要删除的学生学号:");
    scanf("%d",&id);
    
    while (tmp)
    {
        if (tmp->id == id && tmp == head)
        {
            printf("要删除结点为头结点!%d(%s)\n",tmp->id,
                   tmp->name);
            head = head->next;
            free(tmp);
            break;
        }
        else if (tmp->id == id && tmp->next == NULL)
        {
            printf("要删除结点为尾结点!%d(%s)\n",tmp->id,
                   tmp->name);
            prev->next = NULL;
            free(tmp);
            break;
        }
        else if (tmp->id == id)
        {
            printf("要删除结点为中间结点!%d(%s)\n",tmp->id,
                   tmp->name);
            prev->next = tmp->next;
            free(tmp);
            break;
        }
        else
        {
            if (tmp->id != id)
            {
                prev = tmp;
                tmp = tmp->next;
            }
        }
    }
    
    if (tmp == NULL)
        printf("找不到要删除的学生学号!\n");
    else
        printf("删除结点成功!\n");
    
    return head;
}

// 插入结点
stu *insertNode(stu *head,stu *pnew)
{
    stu *prev = NULL;
    stu *tmp = head;
    if (tmp == NULL)
    {
        printf("链表不存在，请先创建再插入!\n");
        return NULL;
    }
    
    while (tmp)
    {
        if (tmp->id > pnew->id && tmp == head)
        {
            printf("插入结点为头结点!\n");
            head = pnew;
            pnew->next = tmp;
            break;
        }
        else if (tmp->id < pnew->id && tmp->next == NULL)
        {
            printf("插入结点为尾结点!\n");
            tmp->next = pnew;
            break;
        }
        else if (tmp->id > pnew->id)
        {
            printf("插入结点为中间结点!\n");
            prev->next = pnew;
            pnew->next = tmp;
            break;
        }
        else  // 移动tmp和prev这两个指针
        {
            if (tmp->id < pnew->id)
            {
                prev = tmp;
                tmp = tmp->next;
            }
        }
    }
    
    printf("插入结点完成!\n");
    return head;
}

// 插入一个结点到链表
stu *insertList(stu *head)
{
    stu *pnew = NULL;
    if (head == NULL)
    {
        printf("链表不存在，请先创建再插入!\n");
        return NULL;
    }
    
    pnew = creatNode();
    if (pnew == NULL)
    {
        printf("创建插入结点失败!\n");
        return head;
    }
    
    head = insertNode(head,pnew);
    return head;
}

// 查找链表结点
void searchList(stu *head)
{
    stu *tmp = head;
    if (tmp == NULL)
    {
        printf("链表不存在，请先创建再查找!");
    }
    
    int id;
    printf("请输入学生的学号:");
    scanf("%d",&id);
    
    while (tmp)
    {
        if (tmp->id == id && tmp == head)
        {
            printf("您查找的结点为头结点:%d(%s)\n",
                   tmp->id,tmp->name);
            break;
        }
        else if (tmp->id == id && tmp->next == NULL)
        {
            printf("您查找的结点为尾结点:%d(%s)\n",
                   tmp->id,tmp->name);
            break;
        }
        else if (tmp->id == id)
        {
            printf("您查找的结点为中间结点:%d(%s)\n",
                   tmp->id,tmp->name);
            break;
        }
        else
            tmp = tmp->next;
    }
    
    if (tmp == NULL)
        printf("您输入的学生学号不存在!\n");
    
    return ;
}

// 显示链表
void showList(stu *head)
{
    stu *tmp = head;
    if (tmp == NULL)
    {
        printf("链表不存在，请先创建再遍历!\n");
        return;
    }
    
    printf("HEAD->");
    while (tmp)
    {
        printf("%d(%s)->",tmp->id,tmp->name);
        tmp = tmp->next;
    }
    printf("NULL\n");
}

stu *distroyList(stu *head)
{
    stu *tmp = head;
    if (tmp == NULL)
    {
        printf("链表不存在，无须销毁!\n");
        return NULL;
    }
    
    while (head)
    {
        head = head->next;
        printf("%d(%s)结点将被销毁!\n",tmp->id,tmp->name);
        free(tmp);
        tmp = head;
    }
    
    printf("链表销毁完成!\n");
    return head;
}

// 链表排序（插入排序）
stu *sortList(stu *head)
{
    stu *tmp = head;
    stu *newHead = head;
    if (tmp == NULL)
    {
        printf("链表不存在，请先创建再排序!\n");
        return NULL;
    }
    
    head = head->next;
    tmp->next = NULL;
    
    while (head)
    {
        tmp = head;
        head = head->next;
        tmp->next = NULL;
        newHead = insertNode(newHead,tmp);
    }
    
    printf("链表插入排序完成!\n");
    return newHead;
}

// 选择排序 (结构体可以直接赋值)
void sortList2(stu *head)
{
    stu *tmp = NULL;
    if (head == NULL)
    {
        printf("链表不存在，请先创建再排序!\n");
        return;
    }
    
    stu *i = NULL,*j = NULL;
    stu st; // 交换两个结构体里面的数据。
    
    for (i=head; i->next!=NULL; i=i->next)
    {
        for (j=i->next; j!=NULL; j=j->next)
        {
            if (i->id > j->id)
            {
                st = *i;
                *i = *j;
                *j = st;
                tmp = i->next;
                i->next = j->next;
                j->next = tmp;
            }
        }
    }
    
    printf("链表选择排序完成!\n");
    return ;
}

// 创建链表，返回链表的头结点指针。
stu *creatList(stu *head)
{
    stu *tmp = head;
    stu *pnew = NULL;
    
    if (tmp != NULL)
    {
        printf("链表已经存在，请先销毁再创建!\n");
        return head;
    }
    
    int n;
    printf("请输入链表结点的个数:");
    scanf("%d",&n);  
    head = creatNode();
    if (head == NULL)
    {
        printf("创建链表头结点失败!\n");
        return NULL;
    }
    
    tmp = head;
    while (--n)
    {
        pnew = creatNode();
        if (pnew == NULL)
        {
            printf("创建链表结点失败!\n");
            return head;
        }
        
        tmp->next = pnew;
        tmp = pnew;
    }
    
    printf("创建链表成功!\n");
    return head;
}




int main(int argc, const char * argv[]) {
    
    stu *head = NULL;
    head = creatList(head);
    showList(head);
    sortList2(head);
    showList(head);
    head = distroyList(head);  // head
    return 0;
    
}

