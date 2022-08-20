# Experiment

[Project Euler Problem 3](https://projecteuler.net/problem=3)

## Trials
- Single Threaded Implementation
- Multi Threaded Implementation
- Time to see results
- TODO: Multi Threaded with thread spawning prime number search?


## Results
- Single Threaded Time - 0.650s
- Multi Threaded Time - 0.155s



## Notes
This was pretty interesting when compared with the zig trials of the same code base. I found this one to be surpisingly easier to implement. Now granted I did the zig trials first so the idea of spawning threads was clear to me as the correct way forward, whereas with zig I had to get over the "should this be async" hump. There is plenty of fighting the compiler in this language, but as a benefit there is little doubt that when it does run you still have "is this safe?" thoughts to be concerned with. If that is a good or a bad trait to have for a language moving forward is another debate entirely.

Having a compiler to battle with ensures that it will always guide you to safety. However this does have the drawback of hiding the implementation details from you of the system you are working on. e.g. If I am doing something unsafe on the OS - should that be for a compiler to tell me or for me to understand why that thing is unsafe myself? I do feel like rust would get me up and running a bit faster, but Zig would ultimately help me understand why everything is the way it is better, although more painfully. 
