//
//  NetworkManager.swift
//  Digimon(Pokemon)
//
//  Created by Tony Lieu on 11/2/23.
//

import Foundation
protocol NetworkableProtocl{
    func getDataFromAPI<T:Decodable>(url: URL, modelType: T.Type, completionHandler:@escaping (Result<T,Error>)->Void)
}
    class NetworkManager:NetworkableProtocl{
        func getDataFromAPI<T>(url: URL, modelType: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
           let task = URLSession.shared.dataTask(with: url) { ( data, response, error) in
                if let error = error{
                print( error.localizedDescription)
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    print("got invaild response code")
                    return
                }
                guard let rawData = data else{
                    print("couldn't get thed data")
                    return
                }
                do{
                    let result = try JSONDecoder().decode(T.self, from: rawData)
                    completionHandler(.success(result))
                }catch{
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
}
