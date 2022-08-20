//
//  SocketConnect.swift
//  HRM
//
//  Created by MacBook M1 on 05/08/22.
//

import Foundation
import SocketIO

let manager = SocketManager(socketURL: URL(string: "http://34.231.88.85:8001/chat")!, config: [.log(true), .compress])
var socket = manager.defaultSocket
