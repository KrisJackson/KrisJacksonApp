import UIKit
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {

    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            // Allow alert, badge, and sound
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            
            // Allow alert, badge, and sound
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            
        }
        Messaging.messaging().shouldEstablishDirectChannel = true
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded()
    }

    func updateFirestorePushTokenIfNeeded() {
        guard let token = Messaging.messaging().fcmToken else { return }
        let usersRef = Firestore.firestore().collection("devices")
            .document(UIDevice.current.identifierForVendor!.uuidString)
        usersRef.setData([
            "token": token,
            "appVersion": Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String,
        ], merge: true)
    }

    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        updateFirestorePushTokenIfNeeded()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
}

class PushNotificationSender {
    
    static func sendPushNotification(toToken token: String, title: String?, body: String?) {
        guard let body = body else { return }
        guard let title = title else { return }
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = [
            "to" : token,
            "notification" : [
                "title" : title,
                "body" : body,
                "sound": "default"
            ],
            "data" : [
                "user" : "test_id"
            ]
        ]

        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAgOxW2zw:APA91bGszJ80dN8ppL_p3ROhNAXseNMD4atpIOBzsVPQsVPFuHTS_Rfgcx6jKd2d-VZTfEDw0FmRHEdY99_auTCuUM0zlna2xZtRx44GneGPceIPhOZTU9EwJdMTog1xDXMLBFp94Sn2", forHTTPHeaderField: "Authorization")

        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
    
}
