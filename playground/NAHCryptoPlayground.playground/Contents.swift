//: Playground - noun: a place where people can play

import UIKit
import NAHCrypto

let cryptor = NAHAESCrypto.aes256Cryptor(withPassword: "bigglesworth")
let message = "meet me under the old oak tree"
let messageData = message.data(using: .utf8)!

print("\nOriginal message: \(message)")
print("Original message data: \(messageData as NSData)")

let encryptedMessage = try! cryptor.encrypt(messageData)
print("\nEncrypted message: \(encryptedMessage.encryptedData as NSData)")
print("Encrypted message IV: \(encryptedMessage.iv as NSData)")

let decryptedMessageData = try! cryptor.decrypt(encryptedMessage)
let decryptedMessage = String(data: decryptedMessageData, encoding: .utf8)!
print("\nDecrypted message data: \(decryptedMessageData as NSData)")
print("Decrypted message: \(decryptedMessage)")

let cryptor2 = NAHAESCrypto.aes256Cryptor(withPassword: "red baron")
let decryptedMessageData2 = try! cryptor2.decrypt(encryptedMessage)
let decryptedMessage2 = String(data: decryptedMessageData2, encoding: .utf8)
print("\nDecrypted message data 2: \(decryptedMessageData2 as NSData)")
print("Decrypted message 2: \(String(describing: decryptedMessage2))")
