//
//  ActionClosurable.swift
//  Annict-for-iOS
//
//  Created by Yuto Akiba on 2018/11/29.
//  Copyright © 2018 Yuto Akiba. All rights reserved.
//

import UIKit

private class Actor<T> {
    @objc func act(sender: AnyObject) { closure(sender as! T) }
    fileprivate let closure: (T) -> Void
    init(acts closure: @escaping (T) -> Void) {
        self.closure = closure
    }
}

private class GreenRoom {
    fileprivate var actors: [Any] = []
}
private var GreenRoomKey: UInt32 = 893

private func register<T>(_ actor: Actor<T>, to object: AnyObject) {
    let room = objc_getAssociatedObject(object, &GreenRoomKey) as? GreenRoom ?? {
        let room = GreenRoom()
        objc_setAssociatedObject(object, &GreenRoomKey, room, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        return room
        }()
    room.actors.append(actor)
}

public protocol ActionClosurable {}
public extension ActionClosurable where Self: AnyObject {
    func convert(closure: @escaping (Self) -> Void, toConfiguration configure: (AnyObject, Selector) -> Void) {
        let actor = Actor(acts: closure)
        configure(actor, #selector(Actor<AnyObject>.act(sender:)))
        register(actor, to: self)
    }
    static func convert(closure: @escaping (Self) -> Void, toConfiguration configure: (AnyObject, Selector) -> Self) -> Self {
        let actor = Actor(acts: closure)
        let instance = configure(actor, #selector(Actor<AnyObject>.act(sender:)))
        register(actor, to: instance)
        return instance
    }
}

extension NSObject: ActionClosurable {}

extension ActionClosurable where Self: UIRefreshControl {
    func onRefresh(_ closure: @escaping (Self) -> Void) {
        convert(closure: closure, toConfiguration: {
            self.addTarget($0, action: $1, for: .valueChanged)
        })
    }
    init(closure: @escaping (Self) -> Void) {
        self.init()
        onRefresh(closure)
    }
}

extension ActionClosurable where Self: UIGestureRecognizer {
    public func onGesture(_ closure: @escaping (Self) -> Void) {
        convert(closure: closure, toConfiguration: {
            self.addTarget($0, action: $1)
        })
    }
    public init(closure: @escaping (Self) -> Void) {
        self.init()
        onGesture(closure)
    }
}

extension ActionClosurable where Self: UISlider {
    func onChanged(_ closure: @escaping (Self) -> Void) {
        convert(closure: closure, toConfiguration: {
            self.addTarget($0, action: $1, for: .valueChanged)
        })
    }
    init(closure: @escaping (Self) -> Void) {
        self.init()
        onChanged(closure)
    }
}

extension UIView {
    func onTap(handler: @escaping (UITapGestureRecognizer) -> Void) {
        let tap = UITapGestureRecognizer { sender in
            handler(sender)
        }
        addGestureRecognizer(tap)
    }
}

