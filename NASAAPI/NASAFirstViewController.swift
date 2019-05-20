//
//  NASAFirstViewController.swift
//  NASAAPI
//
//  Created by Ｇary on 2019/05/16.
//  Copyright © 2019 Ｇary. All rights reserved.
//

import UIKit

class NASAFirstViewController: UITableViewController {

    var nasas = [NASAData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activityIndicatorView = UIActivityIndicatorView(style: .gray)
        view.addSubview(activityIndicatorView)
        activityIndicatorView.center = view.center
        activityIndicatorView.startAnimating()
        
        
        NasaController.shared.inputData{(nasas) in
            if let nasas = nasas{
                self.updata(nasas: nasas)
            }
        }
        
        
    }

    func updata(nasas: [NASAData]){
        DispatchQueue.main.async {
            self.nasas = nasas
            self.tableView.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nasas.count
    }

    func configure(cell: UITableViewCell, forItemAt indexPath: IndexPath){
        let nasa = nasas[indexPath.row]
        cell.textLabel?.text = nasa.title
        cell.detailTextLabel?.text = nasa.date
        NasaController.shared.fetchImage(url: nasa.url){(image) in
            guard let image = image else{
                return
            }
            DispatchQueue.main.async {
                if let NowIndexPath = self.tableView.indexPath(for: cell), NowIndexPath == indexPath{
                    cell.imageView?.image = image
                    
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NasaCell", for: indexPath)
        
        configure(cell: cell, forItemAt: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nasasecondviewcontroller = segue.destination as? NASASecondViewController, let row =
            tableView.indexPathForSelectedRow?.row{
            nasasecondviewcontroller.nasa = nasas[row]
        }
    }
}
