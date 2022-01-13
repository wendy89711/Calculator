//
//  ResultController.swift
//  Calculator
//
//  Created by Wendy Wu on 2022/1/11.
//

//!代表一定有值，但不能太常用，因為若是空值會造成閃退
//?可以是空值
//??可以設定空值時等於多少

import UIKit

extension Float {
    var formatInt: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

class ResultController: UIViewController {
    
    var lastIsOperator:Bool = false
    var ndNumIsZero:Bool = false
    var lastOperator:String = ""
    var nowOperator:String = ""
    var lastOperator2:String = ""
    var stTextNum:Float = 0.0
    var ndTextNum:Float = 0.0
        
    
    @IBOutlet weak var NavigationItem: UINavigationItem!
    
    @IBOutlet weak var nameText: UILabel!
    
    @IBOutlet weak var resultText: UILabel!
    
    @IBAction func num0(_ sender: Any) {
        cleanText()
        resultText.text! += "0"
        lastIsOperator = false
        
    }
    
    @IBAction func num1(_ sender: Any) {
        cleanText()
        resultText.text! += "1"
        lastIsOperator = false
    }
    
    @IBAction func num2(_ sender: Any) {
        cleanText()
        resultText.text! += "2"
        lastIsOperator = false
    }
    
    @IBAction func num3(_ sender: Any) {
        cleanText()
        resultText.text! += "3"
        lastIsOperator = false
    }
    
    @IBAction func num4(_ sender: Any) {
        cleanText()
        resultText.text! += "4"
        lastIsOperator = false
    }
    
    @IBAction func num5(_ sender: Any) {
        cleanText()
        resultText.text! += "5"
        lastIsOperator = false
    }
    
    @IBAction func num6(_ sender: Any) {
        cleanText()
        resultText.text! += "6"
        lastIsOperator = false
    }
    
    @IBAction func num7(_ sender: Any) {
        cleanText()
        resultText.text! += "7"
        lastIsOperator = false
    }
    
    @IBAction func num8(_ sender: Any) {
        cleanText()
        resultText.text! += "8"
        lastIsOperator = false
    }
    
    @IBAction func num9(_ sender: Any) {
        cleanText()
        resultText.text! += "9"
        lastIsOperator = false
    }
    
    @IBAction func dot(_ sender: Any) {
        if !resultText.text!.contains(".") {
            if resultText.text == "" {
                resultText.text = "0"
            }
            resultText.text! += "."
            lastIsOperator = false
        }
    }
    
    @IBAction func ac(_ sender: Any) {
        stTextNum = 0.0
        ndTextNum = 0.0
        resultText.text = "0"
        lastIsOperator = false
        lastOperator = ""
        lastOperator2 = ""
    }
    
    @IBAction func sign(_ sender: Any) {
        if resultText.text!.contains("-") {
            let nosign:String = resultText.text!.replacingOccurrences(of: "-", with: "")
            resultText.text = nosign
        } else if !resultText.text!.contains("-") && resultText.text != "" {
            resultText.text = "-" + resultText.text!
        } else if resultText.text == "" {
            resultText.text = "0"
        }
        lastIsOperator = false
    }
    
    @IBAction func x(_ sender: Any) {
        if !resultText.text!.contains("-") {
            if resultText.text == "" {
                resultText.text = "1"
            } else {
                let n = (resultText.text! as NSString).integerValue
                var ans:Int = 1
                for i in 1...n {
                    //若沒用到i用_取代
                    ans *= i
                }
                resultText.text = String(ans)
            }
            lastIsOperator = false
        }
    }
    
    @IBAction func plus(_ sender: Any) {
        if lastIsOperator && lastOperator != "=" {
            if lastOperator != "+" {
                lastOperator = "+"
                debugPrint(lastIsOperator)
            }
            return
        }
        nowOperator = "+"
        operatorCalcu()
        lastIsOperator = true
        lastOperator = "+"
    }
    
    @IBAction func minus(_ sender: Any) {
        if lastIsOperator && lastOperator != "=" {
            if lastOperator != "-" {
                lastOperator = "-"
            }
            return
        }
        nowOperator = "-"
        operatorCalcu()
        lastIsOperator = true
        lastOperator = "-"
    }
    
    @IBAction func multi(_ sender: Any) {
        if lastIsOperator && lastOperator == "=" {
            if lastOperator != "*" {
                lastOperator = "*"
            }
            return
        }
        nowOperator = "*"
        operatorCalcu()
        lastIsOperator = true
        lastOperator = "*"
    }
    
    @IBAction func divi(_ sender: Any) {
        if lastIsOperator && lastOperator == "=" {
            if lastOperator != "/" {
                lastOperator = "/"
            }
            return
        }
        nowOperator = "/"
        operatorCalcu()
        lastIsOperator = true
        lastOperator = "/"
    }
    
    @IBAction func equal(_ sender: Any) {
        nowOperator = "="
        operatorCalcu()
        lastIsOperator = true
        lastOperator = "="
    }
    
    
    func cleanText(){
        if lastIsOperator || resultText.text == "0" {
            resultText.text = ""
        }
    }
    
    func operatorCalcu() {
        if lastOperator2.isEmpty {
            if lastOperator.isEmpty {
                if resultText.text == "" {
                    resultText.text = "0"
                    debugPrint("chage")
                }
                stTextNum = (resultText.text! as NSString).floatValue //float to string
            } else {
                if resultText.text == "" {
                    resultText.text = "0"
                }
                if lastOperator == "+" {
                    if nowOperator == "*" || nowOperator == "/" {
                        debugPrint("gopri")
                        operatorPriority()
                    } else {
                        stTextNum += (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                    }
                } else if lastOperator == "-" {
                    if nowOperator == "*" || nowOperator == "/" {
                        operatorPriority()
                    } else {
                        stTextNum -= (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                    }
                } else if lastOperator == "*" {
                    stTextNum *= (resultText.text! as NSString).floatValue
                    resultText.text = stTextNum.formatInt
                } else if lastOperator == "/" {
                    stTextNum /= (resultText.text! as NSString).floatValue
                    resultText.text = stTextNum.formatInt
                } else if lastOperator == "=" {
                    stTextNum = (resultText.text! as NSString).floatValue
                }
            }
        } else {
            ndNumIsZero = true
            operatorPriority()
        }
    }
    
    func operatorPriority() {
        if ndTextNum == 0.0 && ndNumIsZero == false {
            ndTextNum = (resultText.text! as NSString).floatValue
            switch lastOperator {
            case "+":
                lastOperator2 = "+"
                break
            case "-":
                lastOperator2 = "-"
                break
            default:
                break
            }
        } else {
            if resultText.text == "" {
                resultText.text = "0"
            }
            if nowOperator == "+" || nowOperator == "-" || nowOperator == "=" {
                if lastOperator2 == "+" {
                    switch lastOperator {
                    case "*":
                        stTextNum += ndTextNum * (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                        break
                    case "/":
                        stTextNum += ndTextNum / (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                        break
                    default:
                        break
                    }
                } else if lastOperator2 == "-" {
                    switch lastOperator {
                    case "*":
                        stTextNum -= ndTextNum * (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                        break
                    case "/":
                        stTextNum -= ndTextNum / (resultText.text! as NSString).floatValue
                        resultText.text = stTextNum.formatInt
                        break
                    default:
                        break
                    }
                }
                lastOperator2 = ""
                ndTextNum = 0.0
                ndNumIsZero = false
            } else if nowOperator == "*" || nowOperator == "/" {
                switch lastOperator {
                case "*":
                    ndTextNum *= (resultText.text! as NSString).floatValue
                    resultText.text = ndTextNum.formatInt
                    break
                case "/":
                    ndTextNum /= (resultText.text! as NSString).floatValue
                    resultText.text = ndTextNum.formatInt
                    break
                default:
                    break
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavigationItem.title = "計算機"
        nameText.text = "使用者名稱：" + username
        resultText.text = "0"
    }
    
}
