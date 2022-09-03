//
//  APICaller.swift
//  MidExamApp
//
//  Created by WeiFangChou on 2022/8/16.
//

import Foundation

enum Result {
    case Success
    case Failed
}

class APICaller {
    
    
    static let url = "https://fivem.fangs.dev/quizs.json"
    
    //https://fivem.fangs.dev/api/getQuizs
    
    
    static let shard = APICaller()
    
    func fetchQuizData(urlString: String, complection: @escaping(Result, [Quiz]?) -> ()){
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let quizResponse = try jsonDecoder.decode([Quiz].self, from: data)
                        print("Success Fetch Data")
                        complection(.Success,quizResponse)
                    }catch{
                        print("Error, ",error)
                        complection(.Failed,nil)
                    }
                }
            }.resume()

        }
    }
    
    
}
