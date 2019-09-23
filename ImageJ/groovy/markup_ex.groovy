// from https://www.youtube.com/watch?v=BXRDTiJfrSE
// complex example issue....
// doesn't work in Fiji editor...

import groovy.xml.MarkupBuilder
if(!(args.size() in 1..2)){
	println "Incorrect number of arguments"
	println()
	println("USEAGE: textAnalyzer TEXTFILE [STRING]")
	System.exit 1
}

def content = new File(args[0].text)
def charCount = content.size()
def wordCount = content.split(/\W+/).size()
def stringCount
if(args.size() == 2{
	stringCount = content.count(args[1])
}

println "Characters:".padRight(15) + charCount
println "Words:".padRight(15) + wordCount
