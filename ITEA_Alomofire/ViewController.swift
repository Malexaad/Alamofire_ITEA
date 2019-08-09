//
//  ViewController.swift
//  ITEA_Alomofire
//
//  Created by Alex Marfutin on 8/8/19.
//  Copyright © 2019 G9. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ViewController: UIViewController {

    @IBOutlet var newsTable: UITableView!
    var newsList = [NewsArticle]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTable.dataSource = self
        newsTable.delegate = self
        getDataWithParams()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell") as! NewsTableViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.green.cgColor
        cell.layer.borderWidth = 1
        if self.newsList.count > 0 {
            cell.sourceLabel.text = newsList[indexPath.row].author
            cell.titleLabel.text = newsList[indexPath.row].title
            cell.urlLabel.text = newsList[indexPath.row].url
            cell.descriptionLabel.text = newsList[indexPath.row].description
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    func getData(){
        Alamofire.request("https://newsapi.org/v2/everything?q=Apple&apiKey=4ea21ee288f24ae880ef13ebda15edbd&from=2019-07-10&to=2019-07-22&pageSize=10&page=2").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
    
            if let json = response.result.value {
//                print("JSON: \(json)") // serialized json response
                if let jsonDict = json as? [String: Any?] {
                    if let articles = jsonDict["articles"] as? [[String: Any?]] {
                        print(articles.count)
                    }
                }
            }
    
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    func getDataWithParams() {
        var params : [String:Any] = [:]
        params["q"] = "Apple"
        params["apiKey"] = "4ea21ee288f24ae880ef13ebda15edbd"
        params["from"] = "2019-07-25"
        params["to"] = "2019-07-22"
        params["pageSize"] = 30
        params["page"] = 1
        
        Alamofire.request("https://newsapi.org/v2/everything", method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response : DataResponse<Any>) in
                let news = Mapper<ResponseModel>().map(JSONObject: response.result.value)
            if let newsListing = news?.articles {
                self.newsList = newsListing
                self.newsTable.reloadData()
            }
        }
    }
            
}
//            if let result = response.result.value {
//                if let json = result as? [String : Any] {
//                    print(json)
//                }
//            }


class ResponseModel : Mappable {
    
    var status : String?
    var totalResults : Int?
    var articles : [NewsArticle]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        status              <-  map["status"]
        totalResults        <-  map["totalResults"]
        articles            <-  map["articles"]
        
    }
    
}

class NewsArticle : Mappable {
    
    var author : String?
    var title : String?
    var description : String?
    var url : String?
    var sourceId : Int?
    var sourceName : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        author        <-   map["author"]
        title         <-   map["title"]
        description   <-   map["description"]
        url           <-   map["url"]
        sourceId      <-   map["source.id"]
        sourceName    <-   map["source.name"]
    }
}
