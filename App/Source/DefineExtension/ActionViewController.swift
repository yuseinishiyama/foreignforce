//
//  ActionViewController.swift
//  Define
//
//  Created by Yusei Nishiyama on 21/07/2018.
//  Copyright © 2018 Yusei Nishiyama. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let extensionItems = extensionContext?.inputItems as? [NSExtensionItem] else {
            fatalError()
        }

        handle(items: extensionItems)
    }

    private func handle(items: [NSExtensionItem]) {

        outer: for item in items {

            guard let providers = item.attachments as? [NSItemProvider] else {
                fatalError()
            }

            for provider in providers {

                guard provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) else {
                    continue
                }

                provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (query, error) in

                    guard let query = query as? String else {
                        fatalError()
                    }

                    OperationQueue.main.addOperation {
                        self.startDefineScreen(with: query)
                    }
                })

                break outer
            }
        }
    }

    private func startDefineScreen(with query: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DefineViewController.self))
        let viewController = storyboard.instantiateViewController(withIdentifier: "DefineViewController") as! DefineViewController
        viewController.wordID = query
        viewController.view.frame = containerView.bounds
        addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        didMove(toParentViewController: self)
    }

    @IBAction func done() {
        extensionContext?.completeRequest(returningItems: extensionContext?.inputItems)
    }

}
