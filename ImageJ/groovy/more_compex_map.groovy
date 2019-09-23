// more complex map
// from https://www.youtube.com/watch?v=BXRDTiJfrSE
// a saner mapping
// curly braces are lambda functions
// without an explicit variable, `it` is implicit

(0..<10).stream().map {2 ** it}.forEach {println it}