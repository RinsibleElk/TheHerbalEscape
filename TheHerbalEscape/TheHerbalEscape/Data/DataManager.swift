//
//  DataManager.swift
//  TheHerbalEscape
//
//  Created by Oliver Samson on 10/12/2017.
//  Copyright © 2017 Oliver Samson. All rights reserved.
//

import Foundation

public final class DataManager {
    public static func urlForResource(_ bundleName: String, _ resourceName: String, _ resourceExtension: String) -> URL {
        let bundlePath = Bundle.main.path(forResource: bundleName, ofType: "bundle")
        let bundle = Bundle(path: bundlePath!)
        let resourceUrl = bundle?.url(forResource: resourceName, withExtension: resourceExtension)
        return resourceUrl!
    }
    
    public static func getContents(_ resourceUrl: URL, completion:@escaping (_ data:Data?, _ error:Error?) -> Void) {
//        DispatchQueue.global(qos: .background).async {
            let data = try! Data(contentsOf: resourceUrl, options: .uncached)
            completion(data, nil)
//        }
    }
}
