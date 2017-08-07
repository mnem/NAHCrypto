//: Playground - noun: a place where people can play

import UIKit
import NAHCrypto

let keySize = 16;
let keyProvider = NAHStringPasswordKeyProvider(password: "foo", salt: "salty".data(using: .utf8)!, keySize: UInt(keySize))
let ivGenerator = NAHRandomInitializationVector(vectorByteLength: UInt(keySize))
let cryptor = NAHAESCryptor(keyProvider: keyProvider, initializationVectorGenerator: ivGenerator);


let toEncrypt = "16 Shells from a Thirty-ought-six"

let encrypted = try! cryptor?.encrypt(toEncrypt.data(using: .utf8)!)
print(String(describing:encrypted!))

let decrypted = try! cryptor?.decrypt(encrypted!)
print(String(data: decrypted!, encoding: .utf8))

