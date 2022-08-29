//
//  ChatVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import SocketIO
import AlamofireImage

class ChatVC: UIViewController {
  
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
//MARK: - usernames
    var senderUser = ""
    var receiptantUser = ""
    var roomId = ""
    var imageUsers = ""
//MARK: - msgArrays
    var arraymsgFrom = [AnyObject]()
    var arraymsgTo = [AnyObject]()
    var arraymsg = [AnyObject]()
    var arraydate = [AnyObject]()
    var arraySendMessage = [AnyObject]()
    var oldChat = [OldChatModel]()
//MARK: - others
    var status = ""
    var sendLink = ""
    var msgFrom = ""
    var msgTo = ""
    var msg = ""
    var date = ""
    var totalMsg = 0
    var img = ""
   
    var socket = manager.defaultSocket
    
////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        socket.connect()
        setData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        socket.connect()
        chat()
    }
    override func viewDidDisappear(_ animated: Bool) {
        socket.disconnect()
    }
    
    func setData(){
        nameUser.text = receiptantUser
        let url = URL(string: imageUsers)
        print(imageUsers,"sdvds")
        if url != nil{
            self.imageUser.af.setImage(withURL: url!)
        }else{
            self.imageUser.image = UIImage(named: "user")
        }
    }
    
    @IBAction func onBacktap(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func sendMessage(_ sender: UIButton){

        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let endDate = df.string(from: Date())
        let d = df.date(from: endDate)!
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let enddd = df.string(from: d)
        let text = "\(self.textMessage.text!)"
        print(text)
        arraySendMessage.removeAll()
        arraySendMessage.append((self.textMessage.text!) as AnyObject)
        socket.emit("chat-msg",["msg" : arraySendMessage[0],"msgTo" :"\(receiptantUser)","date" : enddd])
    }
}


extension ChatVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arraymsg.count > 0 {
            return self.arraymsg.count
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "cell1") as! ChatSenderCell
cell.selectionStyle = .none
         print("kisda h ",arraymsgFrom[indexPath.row])
        if self.arraymsgFrom[indexPath.row] as! String == senderUser{
        cell.msgText.text = self.arraymsg[indexPath.row] as? String

            let arrStr = Array("\(self.arraydate[indexPath.row] as! String)")
            print("checkkkkkkkkkkk thissssss \(arrStr)")
        return cell
      }
       if self.arraymsgFrom[indexPath.row] as! String != senderUser{
        let cell = chatTable.dequeueReusableCell(withIdentifier: "cell2") as! ChatReceiveCell
        cell.selectionStyle = .none
        cell.msgText.text = self.arraymsg[indexPath.row] as? String
        return cell
      }
return cell
    }
    
    
}



extension ChatVC{
    func chat(){
       let senderUsr = UserDefaults.standard.value(forKey: "username") as! String
        print("\(senderUser)-\(receiptantUser)scaksd kjdskj")
        DispatchQueue.main.async { [self] in
            manager.defaultSocket.on("connect"){ [self] data, ack in
                socket.emit("set-room" , ["name1" : "\(senderUsr)-\(receiptantUser)","name2": "\(receiptantUser)-\(senderUsr)"])
                self.oldCHATSSSS()
                socket.emit("set-user-data","\(senderUser)")
                }
            addHandlers()
        }
    }
    func addHandlers(){
        self.oldCHATSSSS()
        
        socket.on("typing"){ data, ack in
              print("typing Data====", data)
        }
            socket.on("chat-msg"){ data, ack in
                print("sdsadc",data)
//                self.arraymsg.removeAll()
                for i in 0...data.count-1{
                    if let dic = data[i] as? [String:AnyObject]{
                               
                       let Messages = dic as NSDictionary
                       let msg = Messages.value(forKey: "msg")
                        
                       let dateFromMessage = Messages.value(forKey: "date")
                       let msgfrom = Messages.value(forKey: "msgFrom")
                        let msgTo = Messages.value(forKey: "msgTo")
                       self.arraymsgFrom.append(msgfrom as AnyObject)
                       self.arraymsgTo.append(msgTo as AnyObject)
                       self.arraymsg.append(msg as AnyObject)
                       self.arraydate.append(dateFromMessage as AnyObject)
                       self.textMessage.text = ""
                       
                       self.chatTable.reloadData()
                       self.scrollToBottom()
                   }

                }

                   //self.arraydate.removeAll()
        }
          socket.on("typing"){ data, ack in
              print("typing Data==== ", data)
            //  self.lbl_Usertyping.text = "Typing..."
          }
    }
    func oldCHATSSSS(){
        
        ApiManager.shared.oldChatApi(roomId: self.roomId) { data, isSuccess in
            if isSuccess{
                print(ApiUrls.oldChat+self.roomId,"sdsdc")
                self.oldChat = data
                print(data,"xcvbn")
                if self.oldChat.count != 0{
                    for i in 0...self.oldChat.count-1{
                        self.arraymsg.append(self.oldChat[i].msg as! AnyObject)
                    }
                }
                
                
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
        
    }
    
    func scrollToBottom(){
             if self.arraymsg.count != 0 {
             let indexPath = IndexPath(row: self.arraymsg.count-1, section: 0)
             self.chatTable.scrollToRow(at: indexPath, at: .bottom, animated: true)
            //    if (self.arraymsg.count != -1){
                 print("indexPath.row==\(indexPath.row)")
          //  }
        }
    }
   
}
