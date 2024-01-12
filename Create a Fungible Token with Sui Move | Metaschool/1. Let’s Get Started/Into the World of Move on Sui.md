# Into the World of Move on Sui

Hey folks, we’re so glad for you to complete the first two courses of this Sui learning path. In this lesson, we will revise a little bit of both, Sui and Move. We know you want to get into coding right away, but revising some of the concepts will help you work on code with ease.

## Let’s revise, the importance of objects in Sui

Objects are like structs in any other programming language. Each object can store any data whether an integer, boolean, or address. They play a huge part in storing a large amount of data in an efficient way. Each object has ownership that identifies who owns the object. Ownership tells us how the transactions will take place for objects. In Sui, there are two types of objects:

1. Single owner object
2. Shared owner object

Here’s how you define an object in Move on Sui.

```
struct ExampleObject has key {
		 id: UID,
		 data_1: u8,
		 data_2: u8,
}
```

**Note:** The object definition does not define the ownership of the object. We define it in the initialization and transferring ownership process. 

## Let’s recall, how to write a contract in Move on Sui

We covered Move contract writing in detail in the previous course. Let's recap with the "Hello World" example code.

```
// Copyright (c) 2022, Sui Foundation
// SPDX-License-Identifier: Apache-2.0

/// A basic Hello World example for Sui Move, part of the Sui Move intro course:
/// https://github.com/sui-foundation/sui-move-intro-course
/// 
module hello_world::hello_world {

    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    /// An object that contains an arbitrary string
    struct HelloWorldObject has key, store {
        id: UID,
        /// A string contained in the object
        text: string::String
    }

    public entry fun mint(ctx: &mut TxContext) {
        let object = HelloWorldObject {
            id: object::new(ctx),
            text: string::utf8(b"Hello World!")
        };
        transfer::public_transfer(object, tx_context::sender(ctx));
    }

}
```

Let's take a moment to review what was accomplished in this contract. We will summarize the key points for clarity.

**module Definition**

You define the contract using the `module` keyword. Here’s how you are defining it in the above program.

```
module hello_world::hello_world
```

**Import libraries**

Right after defining the module, we import the important libraries we need to mint the contract in Move on Sui just like we are doing in the `hello_world` contract.

```
use std::string;
use sui::object::{Self, UID};
use sui::transfer;
use sui::tx_context::{Self, TxContext};
```

**Define an object**

Without an object, a contract in Sui is incomplete. It defines the object with the `key` ability and an `id` in Sui. Other abilities come along to make the object work better. Here’s how we’re defining it in the `hello_world` contract.

```
/// An object that contains an arbitrary string
struct HelloWorldObject has key, store {
    id: UID,
    /// A string contained in the object
    text: string::String
}
```

**Define an `entry` function**

It is important to define a function with an `entry` keyword if you want to mint the object and transfer it to the owner. Here’s what the mint function looks like in the `hello_world` contract. 

```
public entry fun mint(ctx: &mut TxContext) {
    let object = HelloWorldObject {
        id: object::new(ctx),
        text: string::utf8(b"Hello World!")
    };
    transfer::public_transfer(object, tx_context::sender(ctx));
}
```

The `mint` function here, calls the `transfer::public_transfer()` method and minted the `HelloWorldObject` to the Sui global storage.

## Wrap up

Alright, guys, that's a wrap on Sui and Move! You recalled how you could define the simple contract in Move on Sui. While writing the token contract, you will replicate your knowledge and create your own token in Move on Sui.

In the next lesson, you will set up the environment for writing your own contract. Don't forget to complete the assignment before moving on!