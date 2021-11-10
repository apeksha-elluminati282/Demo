//
//  ViewController.swift
//  ProgrammaticConstraintDemo
//
//  Created by MacPro3 on 08/11/21.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
class ViewController: UIViewController {
    
    

    var btnSignOut: UIButton = UIButton.init()
    var tableView: UITableView = UITableView.init()
    
    var vwEntMsg:UIView = UIView.init()
    var txtVwMessage:UITextView = UITextView.init()
    var btnSend:UIButton = UIButton.init()
    
    var arrElements:[String] = ["Test1","Test2"]
    override func viewDidLoad() {
        super.viewDidLoad()
        settingConstraints()
        tableView.reloadData()
        
        tableView.register(ReceiveChatCell.self, forCellReuseIdentifier: "ReceiveChatCell")
        tableView.register(SendChatCell.self, forCellReuseIdentifier: "SendChatCell")
        // Do any additional setup after loading the view.
    }

    func settingConstraints()  {
        self.view.addSubview(tableView)
        self.view.addSubview(btnSignOut)
        self.view.addSubview(vwEntMsg)
        self.vwEntMsg.addSubview(txtVwMessage)
        self.vwEntMsg.addSubview(btnSend)
        
        
        btnSignOut.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        vwEntMsg.translatesAutoresizingMaskIntoConstraints = false
        txtVwMessage.translatesAutoresizingMaskIntoConstraints = false
        btnSend.translatesAutoresizingMaskIntoConstraints = false
        
        let buttonConstraints = [
            btnSignOut.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            btnSignOut.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -10),
            btnSignOut.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(buttonConstraints)
        let tableConstraints = [
            tableView.topAnchor.constraint(equalTo: btnSignOut.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: vwEntMsg.topAnchor, constant: 8)
//        tableView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height)
        ]
        NSLayoutConstraint.activate(tableConstraints)
        let vwSndMsgConstraints = [
            vwEntMsg.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            view.bottomAnchor.constraint(equalTo: vwEntMsg.bottomAnchor, constant: 8),
            vwEntMsg.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ]
        let txtVwConstraints = [
            txtVwMessage.topAnchor.constraint(equalTo: vwEntMsg.topAnchor, constant: 8),
            txtVwMessage.leftAnchor.constraint(equalTo: vwEntMsg.leftAnchor,constant: 8),
            vwEntMsg.bottomAnchor.constraint(equalTo: txtVwMessage.bottomAnchor, constant: 8),
            txtVwMessage.heightAnchor.constraint(equalToConstant: 50.0)
        ]
        let btnSendConstraints = [
            btnSend.centerYAnchor.constraint(equalTo: txtVwMessage.centerYAnchor),
            btnSend.leftAnchor.constraint(equalTo: txtVwMessage.rightAnchor,constant: 8),
            vwEntMsg.rightAnchor.constraint(equalTo: btnSend.rightAnchor,constant: 8),
            btnSend.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(txtVwConstraints)
        NSLayoutConstraint.activate(btnSendConstraints)
        NSLayoutConstraint.activate(vwSndMsgConstraints)
        btnSignOut.addTarget(self, action: #selector(onClickBtnSignOut(_:)), for: .touchUpInside)
        btnSignOut.setTitle("Sign Out", for: .normal)
        btnSignOut.setTitleColor(UIColor.black, for: .normal)
        txtVwMessage.text = "Enter your message here...."
        txtVwMessage.delegate = self
        btnSend.setTitle("SEND", for: .normal)
        btnSend.setTitleColor(.black, for: .normal)
        btnSend.backgroundColor = .white
        btnSend.addTarget(self, action: #selector(onClickBtnSend(_:)), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView.init()
        
        let _ = vwEntMsg.addBorders(edges: .top, color: .lightGray)
        
    }
    
    @objc func onClickBtnSend(_ sender:UIButton)  {
        
    }
    
    @objc func onClickBtnSignOut(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do{
            GIDSignIn.sharedInstance.signOut()
            ph.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            ph.synchronize();
            try firebaseAuth.signOut()
            
        }catch let signOutError as NSError
        {
            print("Error signing out : \(signOutError)")
        }
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrElements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let receiveCell:ReceiveChatCell? = tableView.dequeueReusableCell(withIdentifier: "ReceiveChatCell") as? ReceiveChatCell
        let sendCell:SendChatCell? = tableView.dequeueReusableCell(withIdentifier: "SendChatCell") as? SendChatCell
        if indexPath.row == 0
        {
            receiveCell?.setData(message: arrElements[indexPath.row])
            return receiveCell!
        }else{
            sendCell?.setData(message: arrElements[indexPath.row])
            return sendCell!
        }
        

//        if cell == nil
//        {
//            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
//        }
//        cell?.textLabel?.text = arrElements[indexPath.row]
        
        
    }
}
extension ViewController:UITextViewDelegate
{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty
        {
            textView.text = "Enter your message here...."
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
}
