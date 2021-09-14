//
//  SHMailExtension.swift
//  SwiftHelpers
//
//  Created by David Miotti on 04/09/2017.
//  Copyright © 2017 Muxu.Muxu. All rights reserved.
//

import UIKit
import MessageUI

public class SHMail {
    func sendMail(subject: String?, recipient: String, in controller: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            if let subject = subject {
                mail.setSubject(subject)
            }
            mail.setToRecipients([recipient])
            controller.present(mail, animated: true, completion: nil)
            return
        }
        
        if  let encodedSubject = subject?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let encodedEmail = recipient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            
            // Try googlemail://
            let googleMail = "googlemail://co?subject=\(encodedSubject)&to=\(encodedEmail)"
            if let url = URL(string: googleMail), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                return
            }
            
            // Try inbox-gmail://
            let inbox = "inbox-gmail://co?subject=\(encodedSubject)&to=\(encodedEmail)"
            if let url = URL(string: inbox), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                return
            }
        }
    }
}

