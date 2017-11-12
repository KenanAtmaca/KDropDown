//
//
//  Copyright © 2017 Kenan Atmaca. All rights reserved.
//  kenanatmaca.com
//
//

import UIKit

protocol KDropDownDelegate: class {
    func getItem(item:String,index:Int)
}

class KDropDown: UIButton, KDropDownDelegate {
    
    fileprivate var tableView:KDropView = KDropView()
    private var touchFlag:Bool = true
    
    var tableViewHeight = NSLayoutConstraint()
    var items:[String] = []
    var values:(String,Int)?
    
    var backColor:UIColor? {
        didSet {
         tableView.cellColor = backColor!
        }
    }
    
    var textColor:UIColor? {
        didSet {
        tableView.textColor = textColor!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitle("Menu \u{25BC} ", for: .normal)
        tableView.delegate = self
    }
    
    override func didMoveToSuperview() {
        
        tableView.items = items
        
        self.superview?.addSubview(tableView)
        self.superview?.bringSubview(toFront: tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            tableView.widthAnchor.constraint(equalToConstant: self.frame.width),
            tableView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
        
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        if touchFlag {
           
            NSLayoutConstraint.deactivate([self.tableViewHeight])
            self.tableViewHeight.constant = tableView.dropTable.contentSize.height
            NSLayoutConstraint.activate([self.tableViewHeight])
            
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.layoutIfNeeded()
                self.tableView.center.y += self.tableView.frame.height / 2
            })
            
            touchFlag = false
            
        } else {
            
            NSLayoutConstraint.deactivate([self.tableViewHeight])
            self.tableViewHeight.constant = 0
            NSLayoutConstraint.activate([self.tableViewHeight])
            
            UIView.animate(withDuration: 0.5, animations: {
                self.tableView.center.y -= self.tableView.frame.height / 2
                self.tableView.layoutIfNeeded()
            })
            
            touchFlag = true
        }
    }
    
    func getItem(item: String, index: Int) {
        
        self.setTitle("\(item) \u{25BC}", for: .normal)
        self.values = (item,index)
        
        NSLayoutConstraint.deactivate([self.tableViewHeight])
        self.tableViewHeight.constant = 0
        NSLayoutConstraint.activate([self.tableViewHeight])
        
        touchFlag = true
    }

}//

fileprivate class KDropView: UIView, UITableViewDelegate, UITableViewDataSource {
   
    var items:[String] = []
    var dropTable:UITableView!
    var delegate:KDropDownDelegate?
    
    var cellColor:UIColor = UIColor.lightGray
    var textColor:UIColor = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        dropTable = UITableView()
        dropTable.register(UITableViewCell.self, forCellReuseIdentifier: "dropCell")
        dropTable.isScrollEnabled = false
        dropTable.delegate = self
        dropTable.dataSource = self
        dropTable.separatorStyle = .none
        
        self.addSubview(dropTable)
        
        dropTable.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dropTable.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            dropTable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0),
            dropTable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0),
            dropTable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dropCell") as UITableViewCell!
        cell?.textLabel?.text = items[indexPath.row]
        cell?.backgroundColor = cellColor
        cell?.textLabel?.textColor = textColor
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getItem(item: self.items[indexPath.row], index: indexPath.row)
    }
    
}//
