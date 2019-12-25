//
//  ViewController.swift
//  ExpandableTableViewCell
//
//  Created by Musaddique Billah Talha on 12/10/18.
//  Copyright © 2018 Musaddique Billah Talha. All rights reserved.
//

import UIKit

struct CellData {
    var flag: Bool
    var info: String
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataList = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataList = [CellData(flag: false, info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    CellData(flag: false, info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    CellData(flag: false, info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    CellData(flag: false, info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                    CellData(flag: false, info: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate,  CustomTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        cell.data = dataList[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func reloadRow(indexPath: IndexPath, flag: Bool) {
        dataList[indexPath.row].flag = flag
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
    }
}


protocol CustomTableViewCellDelegate {
    func reloadRow(indexPath: IndexPath, flag: Bool)
}

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    var indexPath: IndexPath?
    var delegate: CustomTableViewCellDelegate?
    
    var data: CellData? {
        didSet {
            if var cellData = data {
                if cellData.flag == false {
                    showButton.setTitle("Show More", for: .normal)
                    cellData.info = String(cellData.info.prefix(86))
                }else {
                    showButton.setTitle("Show Less", for: .normal)
                }
                infoLabel.text = cellData.info
            }
        }
    }
    
    override func awakeFromNib() {
        if let indexPath = indexPath {
            showButton.tag = indexPath.row
        }
    }
    
    @IBAction func showButtonAction(_ sender: UIButton) {
        
        if var cellData = data {
            cellData.flag = !cellData.flag
            
            delegate?.reloadRow(indexPath: indexPath!, flag: cellData.flag)
        }
    }
}


