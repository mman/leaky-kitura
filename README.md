# leaky-kitura

This is a simple Kitura based HTTPS server with basic auth that is leaking memory with every request.

### Steps to reproduce

1. Build this app with XCode (9.2 with swift 4.0 or 9.3 with swift 4.1).
2. Edit scheme for Run and Profile to change Options -> Working Directory to the project dir so that certificates are loaded properly.
3. Run with malloc stack logging or via leaks Instruments.

Start ``./test_load.sh`` script in another console to generate server load.

The server will start to allocate memory with every request and will never reclaim it.


### Root cause analysis

Not sure yet. The heaviest stack traces point toward leaking SSLContext and leaking buffers in Socket.

-![](Instruments1.png?raw=true "Profiling Kitura with Leaks Instrument")
-![](Instruments2.png?raw=true "Profiling Kitura with Leaks Instrument")

### Workaround

None at the moment.
