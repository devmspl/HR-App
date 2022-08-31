//
//  MessageVC.swift
//  HRM
//
//  Created by Macbook Air (ios) on 25/04/22.
//

import UIKit
import SocketIO
class MessageVC: UIViewController {

    @IBOutlet weak var messageTable: UITableView!
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var searchText: UITextField!
    var users = [User]()
    var senderUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        getusers()
        view.overrideUserInterfaceStyle = .light
        senderUser = UserDefaults.standard.value(forKey: "username") as! String
    }
   
    @IBAction func onOptionTap(_ sender: UIButton){
        
    }

}
extension MessageVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = messageTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        cell.name.text = users[indexPath.row].userName ?? ""
        cell.userImage.contentMode = .scaleAspectFill
        if let imagee = users[indexPath.row].image {
            let url = URL(string: imagee)
            if url != nil{
                print(url!,"suvausdbvu")
                cell.userImage.af.setImage(withURL: url!)
            }else{
                cell.userImage.image = UIImage(named: "user")
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.receiptantUser = users[indexPath.row].userName ?? ""
        vc.imageUsers = users[indexPath.row].image ?? ""
        socket.connect()
//        let receiver = users[indexPath.row].userName ?? ""
//        self.chat(senderUser: senderUser, receiptantUser: receiver) { room in
//            vc.roomId = room
//        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension MessageVC{
    func getusers(){
        ApiManager.shared.getAllUsers { data, isSuccess in
            if isSuccess{
                self.users = data
                self.messageTable.reloadData()
            }else{
                self.alert(message: ApiManager.shared.message)
            }
        }
    }
    func chat(senderUser:String,receiptantUser:String,completion:@escaping(String)->()){
        socket.connect()
        DispatchQueue.main.async { [self] in
            manager.defaultSocket.on("connect"){ data, ack in
                socket.emit("set-room" , ["name1" : "\(senderUser)-\(receiptantUser)","name2": "\(receiptantUser)-\(senderUser)"])
                
                socket.emit("set-user-data","\(senderUser)")
                completion("\(data)")
                }
        }
    }
}
