# What this is
A Feature comparison between two languages implementing the same (ish) algorithm

[Project Euler Problem 3](https://projecteuler.net/problem=3)


## Why I did this
to compare the feel and performance of each language when running under similar conditions. Ideally I wanted to get as many easy features out of the way so that I could get a feel for the headache each language would bring, as well as which may be a better candidate to move forward with.


There is a single threaded and multi threaded example for each language.



## Thoughts
Zig is really really bare bones by comparison. I felt really akin to the days of writing JS before good build tools were introduced, but also there was the annoyance of all of the non-GC related encounters that could arise. Luckily the docs for Zig are pretty servicable, but nonetheless I found myself quickly annoyed. 

Rust by comparison is a breeze in someways and a headache in others. The end product leaves you feeling confident, but you will fight the compiler along the whole way. The rode does seem much more worn by comparison which is great, but at the same time most of your head space is consumed with "will this cover the language feature requirement?" rather than "will this solve the problem I am having with this application?" There is a veiled layer of abstraction that doesn't seem to get considered here that may stunt growth when learning about low level programming.


## Running Each Application

### Zig
* Build: `zig build -Drelease-fast=true`
* ./zig-example/zig-out/bin/project-3 --single-thread
* ./zig-example/zig-out/bin/project-3 --multi-thread



## Rust
* Build: `cargo build -r`
* ./rust-example/target/release/project-3 --single-thread
* ./rust-example/target/release/project-3 --multi-thread
    
