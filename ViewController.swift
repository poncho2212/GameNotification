//
//  ViewController.swift
//  tu-ti_a3
//
//  Created by k21006kk on 2023/02/09.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var time_settei: UITextField!
    @IBOutlet weak var yotei_zikoku: UILabel!
    @IBOutlet weak var title_image: UIImageView!
    
    var alarm_time = ""
    var num_20 = 0.0
    var num_5 = 0.0
    var num_1 = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let sampleImage = UIImage(named: "A3アイビス 小.jpeg")
        title_image.image = sampleImage
        
        time_settei.delegate = self
    }
    
    
    // ボタン押下時のアクション
    @IBAction func pushButton(_ kettei_button: UIButton) {
        // TextFieldから文字を取得
        alarm_time = time_settei.text!
        
        let sumT = num_20+num_5+num_1
        let date = Date()
        
        let comp = Calendar.current.dateComponents(
            [Calendar.Component.hour, Calendar.Component.minute],
             from: date)
        var endH = comp.hour!
        var endM = Int(sumT) + comp.minute!
        while endM/60>=1 {
            endH += 1
            endM -= 60
        }
        if endH >= 24{
            endH -= 24
        }
        if endM < 10 {
            yotei_zikoku.text = String(endH) + ":0" + String(endM)
        } else {
            yotei_zikoku.text = String(endH) + ":" + String(endM)
        }
        
        
        let content = UNMutableNotificationContent()
        content.title = "A3!　SP回復のお知らせ"
        content.body = "SP全回復まであと少し！"
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: TimeInterval(atof(alarm_time)*60.0),
            repeats: false
        )
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
    }
    
    @IBAction func ResetButton(_ reset_button: UIButton) {
        step20.value = 0
        label_20.text = "20分　0"
        step5.value = 0
        label_5.text = "5分　0"
        step1.value = 0
        label_1.text = "1分　0"
        num_20 = 0
        num_5 = 0
        num_1 = 0
        let sumT = 0
        time_settei.text = String(Int(sumT))+"分"
    }
    
    @IBOutlet weak var label_20: UILabel!
    @IBOutlet weak var step20: UIStepper!
    @IBAction func time_20(_ sender: UIStepper) {
        num_20 = sender.value*20
        label_20.text = "20分　" + String(Int(sender.value))
        sum_time()
    }
    
    @IBOutlet weak var label_5: UILabel!
    @IBOutlet weak var step5: UIStepper!
    @IBAction func time_5(_ sender: UIStepper) {
        num_5 = sender.value*5
        label_5.text = "5分　" + String(Int(sender.value))
        sum_time()
    }
    
    @IBOutlet weak var label_1: UILabel!
    @IBOutlet weak var step1: UIStepper!
    @IBAction func time_1(_ sender: UIStepper) {
        num_1 = sender.value
        label_1.text = "1分　" + String(Int(sender.value))
        sum_time()
    }
    
    func sum_time(){
        let sumT = num_20+num_5+num_1
        time_settei.text = String(Int(sumT))+"分"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

