// src/test.zig
const std = @import("std");
const mem = std.mem;
const print = std.debug.print;

var globVal: u64 = 2;

pub fn main() !void {
    var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    const gpa = general_purpose_allocator.allocator();
    const args = try std.process.argsAlloc(gpa);
    defer std.process.argsFree(gpa, args);
    const flag = args[1];

    if (mem.eql(u8, flag, "--single-thread")) {
        print("Running Single Thread \n", .{});
        try singleThread();
    } else {
        print("Running Multi Thread \n", .{});
        try multiThread();
    }
}

// Single Threaded Implementation
// `chunk` was added to keep the implementation time the same as the multithread version
fn singleThread() anyerror!void {
    const TARGET: u64 = 600851475143;
    const chunk = 100000000;

    var i: u64 = 2;
    var largestPrime: u64 = 1;
    while (i < chunk) {
        switch (@rem(TARGET, i)) {
            0 => {
                const val: u64 = @divExact(TARGET, i);
                if (largestPrime > val) {
                    break;
                } else if (is_prime_number(val)) {
                    largestPrime = val;
                }
            },
            else => {},
        }
        i += 1;
    }
    print("Largest Prime: {}\n", .{largestPrime});
}

fn is_prime_number(number: u64) bool {
    print("Checking {}\n", .{number});
    var i: u64 = 2;
    while (i < number) {
        if (@rem(number, i) == 0) {
            print("{} is not prime\n", .{number});
            return false;
        }
        i += 1;
    }
    print("{} is prime\n", .{number});
    return true;
}
//
//
//
// Multi Threaded Implementation
// TODO: make is_prime_number the spawner of procs so that
// TODO: figure out if this is memory safe in the slightest
// we can further segment this work.

fn loopThroughSection(min: u64, max: u64, TARGET: u64) void {
    var largestPrime: u64 = 2;
    var i: u64 = min;
    while (i < max) {
        switch (@rem(TARGET, i)) {
            0 => {
                const val: u64 = @divExact(TARGET, i);
                if (largestPrime > val) {
                    break;
                } else if (is_prime_number(val)) {
                    largestPrime = val;
                    if (largestPrime > globVal) globVal = largestPrime;
                }
            },
            else => {},
        }
        i += 1;
    }
}

fn multiThread() anyerror!void {
    const TARGET: u64 = 600851475143;
    const chunk = 10000000;

    const task_0 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 9, chunk * 10, TARGET });
    const task_1 = try std.Thread.spawn(.{}, loopThroughSection, .{ 2, chunk, TARGET });
    const task_2 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk, chunk * 2, TARGET });
    const task_3 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 2, chunk * 3, TARGET });
    const task_4 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 3, chunk * 4, TARGET });
    const task_5 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 4, chunk * 5, TARGET });
    const task_6 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 5, chunk * 6, TARGET });
    const task_7 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 6, chunk * 7, TARGET });
    const task_8 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 7, chunk * 8, TARGET });
    const task_9 = try std.Thread.spawn(.{}, loopThroughSection, .{ chunk * 8, chunk * 9, TARGET });

    task_0.join();
    task_1.join();
    task_2.join();
    task_3.join();
    task_4.join();
    task_5.join();
    task_6.join();
    task_7.join();
    task_8.join();
    task_9.join();
    std.log.info("Largest Prime: {}", .{globVal});
}
