//
//  UITableView+CellRegistration.swift
//  Foreignforce
//
//  Created by Yusei Nishiyama on 27/05/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import Foundation

import UIKit

public protocol ReusableView: class {

    static var identifier: String { get }
}

public extension ReusableView where Self: UIView {

    static var identifier: String {

        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

extension UITableView {

    public func register<T: UITableViewCell>(_: T.Type) {

        register(T.self, forCellReuseIdentifier: T.identifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {

        guard let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.self) with identifier: \(T.identifier)")
        }

        return cell
    }

    public func registerNib<T: UITableViewCell>(_: T.Type) {

        register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}
