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
        if let destinations = serverConfig.destinations {
            if let destination = destinations.first(where: { $0.destinationDefinition?.displayName == self.key }) {
                if let apiKey = destination.config?.dictionaryValue?["apiKey"] as? String {
                    Bugsnag.start(withApiKey: apiKey)
                }
            }
        }
    }
    
    func identify(message: IdentifyMessage) -> IdentifyMessage? {
        if let traits = extractTraits(properties: message.traits) {
            Bugsnag.setUser(message.userId, withEmail: traits["name"] as? String, andName: traits["email"] as? String)
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
    
    func group(message: GroupMessage) -> GroupMessage? {
        client?.log(message: "MessageType is not supported", logLevel: .warning)
        return message
    }
    
    func alias(message: AliasMessage) -> AliasMessage? {
        client?.log(message: "MessageType is not supported", logLevel: .warning)
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
                case let v as NSString:
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

@objc
public class RudderBugsnagDestination: RudderDestination {
    
    public override init() {
        super.init()
        plugin = RSBugsnagDestination()
    }
}
#endif
