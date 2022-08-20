# Experiment 

[Largest Prime Number](https://projecteuler.net/problem=3)

## Test
The objective of doing this was to determine 
- how zig is to write
- how much faster multi threaded implementations were compared to single threaded


## Assumptions
- Because I couldn't figure out how to dynamically spawn threads and manage them, I found the highest iteration of the largest prime, which was around 100 million. Then decided to run the single threaded implementation to the 100 million cutoff and exit, while the multithreaded version ran in chunks of 10 million each thread.

## Findings
- Single Threaded run time: 0.675s
- Multi Threaded run time: 0.160s


## Questions to be Answered
- There is no guarantee of memory safety here, as the variable capturing the largest prime in the multi thread version is a global. finding a maintainable way to do this would be critical to moving forward.

