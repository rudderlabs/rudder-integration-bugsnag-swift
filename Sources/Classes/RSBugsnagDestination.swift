//
//  RSBugsnagDestination.swift
//  RudderBugsnag
//
//  Created by Pallab Maiti on 04/03/22.
//

#if os(iOS) || os(tvOS) || targetEnvironment(macCatalyst) || os(macOS)

import Foundation
import Rudder
import Bugsnag

class RSBugsnagDestination: RSDestinationPlugin {
    let type = PluginType.destination
    let key = "Bugsnag"
    var client: RSClient?
    var controller = RSController()
        
    func update(serverConfig: RSServerConfig, type: UpdateType) {
        guard type == .initial else { return }
        guard let bugsnagConfig: RudderBugsnagConfig = serverConfig.getConfig(forPlugin: self) else {
            client?.log(message: "Failed to Initialize Bugsnag Factory", logLevel: .warning)
            return
        }
        
        if !bugsnagConfig.appKey.isEmpty {
            Bugsnag.start(withApiKey: bugsnagConfig.appKey)
        }
        client?.log(message: "Initializing Bugsnag SDK", logLevel: .debug)
}
    
    func identify(message: IdentifyMessage) -> IdentifyMessage? {
        if let traits = extractTraits(properties: message.traits) {
            Bugsnag.setUser(message.userId, withEmail: traits[RSKeys.Identify.Traits.email] as? String, andName: traits[RSKeys.Identify.Traits.name] as? String)
            for (key, value) in traits {
                Bugsnag.addMetadata(value, key: key, section: "user")
            }
        }
        return message
    }
    
    func track(message: TrackMessage) -> TrackMessage? {
        Bugsnag.leaveBreadcrumb(withMessage: message.event)
        return message
    }
    
    func screen(message: ScreenMessage) -> ScreenMessage? {
        Bugsnag.setContext(message.name)
        return message
    }
    
    func reset() {
        Bugsnag.clearMetadata(section: "user")
        Bugsnag.clearFeatureFlags()
    }
}

// MARK: - Support methods

extension RSBugsnagDestination {
    func extractTraits(properties: [String: Any]?) -> [String: Any]? {
        var params: [String: Any]?
        if let properties = properties {
            params = [String: Any]()
            for (key, value) in properties {
                switch value {
                case let v as String:
                    params?[key] = v
                case let v as NSNumber:
                    params?[key] = v
                case let v as Bool:
                    params?[key] = v
                default:
                    break
                }
            }
        }
        return params
    }
}

struct RudderBugsnagConfig: Codable {
    private let _appKey: String?
    var appKey: String {
        return _appKey ?? ""
    }
    
    enum CodingKeys: String, CodingKey {
        case _appKey = "apiKey"
    }
}

@objc
public class RudderBugsnagDestination: RudderDestination {
    
    public override init() {
        super.init()
        plugin = RSBugsnagDestination()
    }
}
#endif
