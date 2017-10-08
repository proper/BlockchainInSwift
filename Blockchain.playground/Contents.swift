/**
 *  MIT License
 *
 *  Copyright (c) 2017 Li Linyu
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the
 *  "Software"), to deal in the Software without restriction, including
 *  without limitation the rights to use, copy, modify, merge, publish,
 *  distribute, sublicense, and/or sell copies of the Software, and to
 *  permit persons to whom the Software is furnished to do so, subject to
 *  the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 *  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 *  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 *  DEALINGS IN THE SOFTWARE.
 */

import Foundation

struct Block {
    public private(set) var previousBlockHashValue: Int
    public private(set) var transactions:[String] // Use String for simplicity. This can be an array of any type.
    
    var blockHashValue: Int {
        get {
            var hashValues:Float = Float(previousBlockHashValue)
            
            for transaction in transactions {
                hashValues += Float(transaction.hashValue)
            }
            
            return String(hashValues).hashValue
        }
    }

    
    init(_ transactions:[String], _ previousBlockHashValue: Int) {
        self.transactions = transactions
        self.previousBlockHashValue = previousBlockHashValue
    }
}

struct BlockChain {
    public private(set) var arrayOfBlocks:[Block] = [Block]() // A block chain is an array of Block types
    public private(set) var lastBlockHashValue:Int = 0
    
    mutating func add(_ newBlock: Block) {
        if lastBlockHashValue == 0 || lastBlockHashValue == newBlock.previousBlockHashValue {
            arrayOfBlocks.append(newBlock)
            lastBlockHashValue = newBlock.blockHashValue
            print("Added block hash: \(lastBlockHashValue)")
        } else {
            print("Failed to add block hash: \(newBlock.blockHashValue)")
        }
    }
}

// A new blockchain
var blockchain = BlockChain()

// Every blockchain needs a genesis block
let genesisBlock = Block(["1233", "1234", "1235"], 0)
blockchain.add(genesisBlock)
print("genesisBlock hash: \(genesisBlock.blockHashValue), blockchain count \(blockchain.arrayOfBlocks.count)")

// Second block
let block2 = Block(["2233", "2234", "2235"], genesisBlock.blockHashValue)
blockchain.add(block2)
print("second block hash: \(block2.blockHashValue), blockchain count \(blockchain.arrayOfBlocks.count)")

// 3rd block
let block3 = Block(["3233", "3234", "3235"], block2.blockHashValue)
blockchain.add(block3)
print("third block hash: \(block3.blockHashValue), blockchain count \(blockchain.arrayOfBlocks.count)")

// Fake block, added a new transaction to block3 and tried to add this block after block3 was added
let fakeBlock = Block(["3233", "3234", "3235", "FakeTransaction"], block2.blockHashValue)
blockchain.add(fakeBlock)
print("fake block hash: \(fakeBlock.blockHashValue), blockchain count \(blockchain.arrayOfBlocks.count)")

