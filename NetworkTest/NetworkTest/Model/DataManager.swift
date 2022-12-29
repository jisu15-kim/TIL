//
//  DataManager.swift
//  NetworkTest
//
//  Created by 김지수 on 2022/12/27.
//

import Foundation
import Alamofire

class DataManager {
    
    let getUrl = "https://jsonplaceholder.typicode.com/posts"
    
    let postUrl = "https://jsonplaceholder.typicode.com/posts"
    
    func getNetworkData(completion: @escaping ([Model]) -> Void) {
        
        AF.request(getUrl)
            .responseDecodable(of: [Model].self) { response in
                switch response.result {
                case .success(let response):
                    print("====성공===")
                    print(response)
                    completion(response)
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            }
    }
    
    func postNetworkData(param: Model, completion: @escaping (Model) -> Void) {
        
        print(#function)
        AF.request(postUrl, method: .post, parameters: param, encoder: JSONParameterEncoder.default)
            .responseDecodable(of: Model.self) { response in
                switch response.result {
                case .success(let response):
                    print("====성공===")
                    completion(response)
                case .failure(let error):
                    print("====실패===")
                    print(error)
                }
            }
    }
}
