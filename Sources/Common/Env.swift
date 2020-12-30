//
//  Env.swift
//  Portannict
//
//  Created by Yuto Akiba on 2020/12/20.
//

import Foundation
import SwiftUI

struct Env: EnvironmentKey {
    static let defaultValue: [String: Any] = configure()

    static func configure() -> [String: Any] {
        guard let path = Bundle.main.path(forResource: "Envfile", ofType: nil) else {
            fatalError("Not found: '/path/to/Envfile'.\nPlease create Envfile file")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy:"\n")
            var values: [String: Any] = [:]
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy:"=")
                if keyVal.count == 2 {
                    values[keyVal[0]] = keyVal[1]
                }
            }
            return values
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

extension EnvironmentValues {
    var envValues: [String: Any] {
        get { self[Env.self] }
    }

    var clientID: String {
        get { envValues["AnnictClientID"] as! String }
    }

    var clientSecret: String {
        get { envValues["AnnictClientSecret"] as! String }
    }

    var baseImageURL: String {
        get { envValues["BaseImageURL"] as! String }
    }
}
