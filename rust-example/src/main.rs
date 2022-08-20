use std::env;
use std::sync::mpsc;
use std::thread;

fn main() {
    let args : Vec<String> = env::args().collect();
    let style : &String = &args[1];
    match style {
        x if x == "--single-thread" => single_thread(),
        _ => multi_thread()
    }


}
// Single Threaded Implementation
// this needs to be chunkable by the loop basically. 
// trying to split this out on prime number is going to be a waste for now
// because we have n prime numbers to search through and no way to verify
fn single_thread() {
    println!("Running Single Threaded Build");
    const MAX_VALUE : u64 = 600851475143;
    let mut i : u64 = 2;
    let mut largest_prime :u64 = 2;
    const CHUNK : u64 = 100000000;

    while i < CHUNK {
        match i {
            x if MAX_VALUE % x == 0 && largest_prime > MAX_VALUE / x => break,
            x if MAX_VALUE % x == 0 && is_prime_value(MAX_VALUE / x) => 
                largest_prime = MAX_VALUE / x,
            _ => {}
        }


        i += 1;
    }
    println!("Largest Prime: {}", largest_prime);
}

fn  is_prime_value(num : u64) -> bool {
    println!("Checking {}", num);
    let mut i :u64 = 2;
    while i < num {
        if num % i == 0 {
            return false
        }

        i += 1;
    }
    return true;

}



fn loop_through_section(sender : mpsc::Sender<u64>, min:u64, max:u64) {
    const MAX_VALUE : u64 = 600851475143;
    let mut i : u64 = min;

    while i < max {
        if MAX_VALUE % i == 0 && is_prime_value(MAX_VALUE/i) {
            sender.send(MAX_VALUE/i).unwrap();
        }
        i += 1;
    }

}

fn multi_thread() {
    println!("Running Multi Threaded Build");
    let mut largest_prime :u64 = 2;
    const CHUNK : u64 = 10000000;

    let (tx, rx) = mpsc::channel();
    let tx1 = tx.clone();
    let tx2 = tx.clone();
    let tx3 = tx.clone();
    let tx4 = tx.clone();
    let tx5 = tx.clone();
    let tx6 = tx.clone();
    let tx7 = tx.clone();
    let tx8 = tx.clone();
    let tx9 = tx.clone();

    thread::spawn(move || {loop_through_section(tx, 2, CHUNK) });
    thread::spawn(move || {loop_through_section(tx2, CHUNK, CHUNK * 2)});
    thread::spawn(move || {loop_through_section(tx3, CHUNK * 2, CHUNK * 3)});
    thread::spawn(move || {loop_through_section(tx4, CHUNK * 3, CHUNK * 4)});
    thread::spawn(move || {loop_through_section(tx5, CHUNK * 4, CHUNK * 5)});
    thread::spawn(move || {loop_through_section(tx6, CHUNK * 5, CHUNK * 6)});
    thread::spawn(move || {loop_through_section(tx7, CHUNK * 6, CHUNK * 7)});
    thread::spawn(move || {loop_through_section(tx8, CHUNK * 7, CHUNK * 8)});
    thread::spawn(move || {loop_through_section(tx9, CHUNK * 8, CHUNK * 9)});
    thread::spawn(move || {loop_through_section(tx1, CHUNK * 9, CHUNK * 10)});

    for received in rx {
        if received > largest_prime {
            largest_prime = received
        }
    }
    println!("Largest Prime: {}", largest_prime)
}
