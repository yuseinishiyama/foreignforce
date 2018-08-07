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

        var imageFound = false
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {

                    provider.loadItem(forTypeIdentifier: kUTTypeText as String, options: nil, completionHandler: { (query, error) in
                        OperationQueue.main.addOperation {
                            let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: DefineViewController.self))
                            let viewController = storyboard.instantiateViewController(withIdentifier: "DefineViewController") as! DefineViewController
                            viewController.wordID = query as? String
                            self.addChildViewController(viewController)
                            viewController.view.frame = self.containerView.bounds
                            self.containerView.addSubview(viewController.view)
                            self.didMove(toParentViewController: self)
                        }
                    })

                    imageFound = true
                    break
                }
            }

            if (imageFound) {
                // We only handle one image, so stop looking for more.
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
