//
//  NetworkHandler.swift
//  MovieApp
//
//  Created by Mahmoud Mohamed on 16/06/2023.
//

import Foundation
import Alamofire

typealias ResponseHandler<T: Codable> = (Response<T>) -> ()

protocol NetworkRequestHandlerProtocol {
    func get<T: Codable>(url: String, completion: @escaping ResponseHandler<T>)
}
class NetworkRequestHandler : NetworkRequestHandlerProtocol{
    static let shared = NetworkRequestHandler()
    private init(){}
    
    func get<T: Codable>(url: String, completion: @escaping ResponseHandler<T>){
        
        AF.request(url, method: .get).responseDecodable(of:T.self) { response in
            switch response.result {
            case .success:
                switch response.response?.statusCode {
                case 200:
                    //response.value
                    print("\n******************************")
                    print("[request]: \(response.request)")
                    print("******************************")
                    print("[Response] \(response.result)")
                    //                                                print("success")
                    //                        print("******************************\n")
                    completion(Response(data: response.value, message: "success", status: .success))
                default:
                    //handle other cases
                    completion(Response(data: nil, message: "failure", status: .failure))
                }
            case let .failure(error):
                //probably the decoding failed because your json doesn't match the expected format
                print(String(describing: error))
                completion(Response(data: nil, message: error.localizedDescription, status: .failure))
            }
        }
    }
}

