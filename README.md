# leaky-kitura

This is a simple Kitura based HTTP server with basic auth that is leaking memory with every request.

### Steps to reproduce

Build this app with XCode (9.2 with swift 4.0 or 9.3 with swift 4.1). Run with malloc stack logging or via leaks Instruments.

Start ``./test_load.sh`` script in another console to generate server load.

The server will start to allocate memory with every request and will never reclaim it.

### Root cause analysis

Looking at the instruments and malloc stack logging it seems that ``RouterRequest`` and ``RouterResponse`` instances are kept indefinitely which in the end leads to many instances being kept around.

![](Instruments.png?raw=true "Profiling Kitura with Leaks Instrument")
![](XCodeMallocDebugger.png?raw=true "Profiling Kitura with XCode Malloc Debugger")

### Workaround

None at the moment.
