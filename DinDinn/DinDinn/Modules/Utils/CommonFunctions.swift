//
//  CommonFunctions.swift
//  DinDinn
//
//  Created by Ronak Sankhala on 22/07/21.
//


import Foundation

class CommonFunctions: NSObject {
    
    @objc class TestClass: NSObject {}
    static let Instance = CommonFunctions()
    
    
    //Read data from json file
    func dataFromFile(_ filename: String) -> [String: Any]? {
        let bundle = Bundle(for: TestClass.self)
        if let path = bundle.path(forResource: filename, ofType: "json") {
            //return (try? Data(contentsOf: URL(fileURLWithPath: path)))
            guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { return nil }
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    func jsonToData(json: Any) -> Data? {
        do {
            return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        return nil
    }
    
}
