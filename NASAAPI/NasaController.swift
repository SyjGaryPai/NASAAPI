//
//  TableViewController.swift
//  NASAAPI
//
//  Created by Ｇary on 2019/05/16.
//  Copyright © 2019 Ｇary. All rights reserved.
//

import UIKit

class NasaController {
    
    static let shared = NasaController()
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    var NASAarray = [NASAData]()
    
    func inputData(completion: @escaping ([NASAData]?) -> Void){
        if let urlStr = "https://api.nasa.gov/planetary/apod?api_key=KbC3LNS8QLTk1KaOjWBDT6xvb3s2R8i3a8ZPYSEL&start_date=2019-04-20&end_date=2019-05-15".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){(data, response, error) in
                if let data = data, let Array = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{
                    for NasaData in Array{
                        if let nasa = NASAData(json: NasaData as! [String : String]){
                            self.NASAarray.append(nasa)
                        }
                    }
                    completion(self.NASAarray)
                }
            }
            task.resume()
        }
    }
}
