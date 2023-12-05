//
//  WebService.swift
//  MVVMDemo
//
//  Created by Ishi on 05/12/23.
//

import Foundation
typealias JSONDictionary = [String:Any]


class Webservice {
    
    func getArticle (url : URL , completionHandler :@escaping (Bool, [Article]) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            var articles = [Article]()
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dictionary = json as! JSONDictionary
                let articleDictionaries = dictionary["articles"] as! [JSONDictionary]
                print(articleDictionaries)

                articles = articleDictionaries.compactMap { dictionary in
                    return Article(dictionary :dictionary)
                }
                
                completionHandler(true, [Article](articles))

                
            }
            
        }.resume()
    }
    
    func loginApiCall( url : URL, param: [String: Any], completionHandler: @escaping (Bool, Login?) -> ()) {

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: param, options: []) else {
            return
        }
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
                        
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        let dictionary = json as! JSONDictionary
                        print(json)
                        let articleDictionaries = dictionary["data"] as! JSONDictionary
                        completionHandler(true, Login(dictionary: articleDictionaries))
                        
                    } catch {
                        print(error)
                    }
                }
                
            }else {
                print(error)

            }
        }.resume()
    }
        
     //   print("urlString",urlString)
//        Alamofire.request(urlString, method: .post, parameters: param, encoding: JSONEncoding.default, headers: HTTPHeaders()).responseJSON { response in
//
//
//            print("Login Response",response)
//
//            switch response.result {
//
//
//            case .success(let data):
//                if JSON(data as Any)["Issuccess"] == true
//                {
//                    completionHandler(true, loginModel(data: JSON(data as Any)))
//
//                }
//                else
//                {
//                    completionHandler(false, loginModel(data: JSON(data as Any)))
//
//                }
//                break
//
//            case .failure(let failureError):
//                print("Error in getting login data : \(failureError.localizedDescription)")
//                completionHandler(false, nil)
//                break
//            }
     // }
   // }
    
}


