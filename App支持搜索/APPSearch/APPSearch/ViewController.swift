//
//  ViewController.swift
//  APPSearch
//
//  Created by licong on 2017/3/21.
//  Copyright © 2017年 Richard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var table = UITableView()
    var dataArray = [Person]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
        view.addSubview(table)
        table.frame = UIScreen.main.bounds
        table.delegate = self
        table.dataSource = self
        let dataSource = DataSource()
        dataArray = dataSource.dataList
        
        dataSource.savePeople()
        table.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        let object =  dataArray[indexPath.row]
        cell.textLabel?.text = object.name
        cell.imageView?.image = UIImage(named: object.icon)
        return cell
    }
}
