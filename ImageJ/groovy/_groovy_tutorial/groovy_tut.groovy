/*
Posted by Derek Banas on Apr 7, 2016 
http://www.newthinktank.com/2016/04/groovy-tutorial/

Install Groovy on Mac

1. Update Java to at least Java 7 in the System Preferences Java Control Panel
 
2. Type in Terminal /usr/libexec/java_home -V
to get something like
1.7.0_55, x86_64:	"Java SE 7"	/Library/Java/JavaVirtualMachines/jdk1.7.0_55.jdk/Contents/Home
 
3. Type in terminal export JAVA_HOME=`/usr/libexec/java_home -v 1.7.0_55, x86_64`
 
4. Type in terminal java -version and make sure you have at least Java 7
 
5. Install HomeBrew at http://brew.sh/
 
6. Type in terminal brew install groovy
 
7. In Atom Open Command Palette -> Install Packages Themes -> Type language-groovy and install
 
Install Groovy on Windows
 
1. Go here http://groovy-lang.org/download.html
 
2. Click Windows Installer and click next a bunch of times until it is installed.
*/
 
class GroovyTut {
 
// main is where execution starts
static void main(String[] args){
 
  // Print to the screen
  println("Hello World");
 
  // ---------- MATH ----------
  // Everything in Groovy is an object
  // including numbers
 
  // def is used when you define a variable
  // Variables start with a letter and can
  // contain numbers and _
  // Variables are cynamically typed and can
  // hold any value
  def age = "Dog";
  age = 40;
 
  // The basic integer math operators
  println("5 + 4 = " + (5 + 4));
  println("5 - 4 = " + (5 - 4));
  println("5 * 4 = " + (5 * 4));
  println("5 / 4 = " + (5.intdiv(4)));
  println("5 % 4 = " + (5 % 4));
 
  // Floating point math operators
  println("5.2 + 4.4 = " + (5.2.plus(4.4)));
  println("5.2 - 4.4 = " + (5.2.minus(4.4)));
  println("5.2 * 4.4 = " + (5.2.multiply(4.4)));
  println("5.2 / 4.4 = " + (5.2 / 4.4));
 
  // Order of operations
  println("3 + 2 * 5 = " + (3 + 2 * 5));
  println("(3 + 2) * 5 = " + ((3 + 2) * 5));
 
  // Increment and decrement
  println("age++ = " + (age++));
  println("++age = " + (++age));
  println("age-- = " + (age--));
  println("--age = " + (--age));
 
  // Largest values
  println("Biggest Int " + Integer.MAX_VALUE);
  println("Smallest Int " + Integer.MIN_VALUE);
 
  println("Biggest Float " + Float.MAX_VALUE);
  println("Smallest Float " + Float.MIN_VALUE);
 
  println("Biggest Double " + Double.MAX_VALUE);
  println("Smallest Double " + Double.MIN_VALUE);
 
  // Decimal Accuracy
  println("1.1000000000000001 + 1.1000000000000001 "
  + (1.1000000000000001111111111111111111111111111111111111 + 1.1000000000000001111111111111111111111111111111111111));
 
  // Math Functions
  def randNum = 2.0;
  println("Math.abs(-2.45) = " + (Math.abs(-2.45)));
  println("Math.round(2.45) = " + (Math.round(2.45)));
  println("randNum.pow(3) = " + (randNum.pow(3)));
  println("3.0.equals(2.0) = " + (3.0.equals(2.0)));
  println("randNum.equals(Float.NaN) = " + (randNum.equals(Float.NaN)));
  println("Math.sqrt(9) = " + (Math.sqrt(9)));
  println("Math.cbrt(27) = " + (Math.cbrt(27)));
  println("Math.ceil(2.45) = " + (Math.ceil(2.45)));
  println("Math.floor(2.45) = " + (Math.floor(2.45)));
  println("Math.min(2,3) = " + (Math.min(2,3)));
  println("Math.max(2,3) = " + (Math.max(2,3)));
 
  // Number to the power of e
  println("Math.log(2) = " + (Math.log(2)));
 
  // Base 10 logarithm
  println("Math.log10(2) = " + (Math.log10(2)));
 
  // Degrees and radians
  println("Math.toDegrees(Math.PI) = " + (Math.toDegrees(Math.PI)));
  println("Math.toRadians(90) = " + (Math.toRadians(90)));
 
  // sin, cos, tan, asin, acos, atan, sinh, cosh, tanh
  println("Math.sin(0.5 * Math.PI) = " + (Math.sin(0.5 * Math.PI)));
 
  // Generate random value from 1 to 100
  println("Math.abs(new Random().nextInt() % 100) + 1 = " + (Math.abs(new Random().nextInt() % 100) + 1));
 
  // ---------- STRINGS ----------
 
  def name = "Derek";
 
  // A string surrounded by single quotes is taken literally
  // but backslashed characters are recognized
  println('I am ${name}\n');
  println("I am $name\n");
 
  // Triple quoted strings continue over many lines
  def multString = '''I am
  a string
  that goes on
  for many lines''';
 
  println(multString);
 
  // You can access a string by index
  println("3rd Index of Name " + name[3]);
  println("Index of r " + name.indexOf('r'));
 
  // You can also get a slice
  println("1st 3 Characters " + name[0..2]);
 
  // Get specific Characters
  println("Every Other Character " + name[0,2,4]);
 
  // Get characters starting at index
  println("Substring at 1 " + name.substring(1));
 
  // Get characters at index up to another
  println("Substring at 1 to 4 " + name.substring(1,4));
 
  // Concatenate strings
  println("My Name " + name);
  println("My Name ".concat(name));
 
  // Repeat a string
  def repeatStr = "What I said is " * 2;
  println(repeatStr);
 
  // Check for equality
  println("Derek == Derek : " + ('Derek'.equals('Derek')));
  println("Derek == derek : " + ('Derek'.equalsIgnoreCase('derek')));
 
  // Get length of string
  println("Size " + repeatStr.length());
 
  // Remove first occurance
  println(repeatStr - "What");
 
  // Split the string
  println(repeatStr.split(' '));
  println(repeatStr.toList());
 
  // Replace all strings
  println(repeatStr.replaceAll('I', 'she'));
 
  // Uppercase and lowercase
  println("Uppercase " + name.toUpperCase());
  println("Lowercase " + name.toLowerCase());
 
  // <=> returns -1 if 1st string is before 2nd
  // 1 if the opposite and 0 if equal
  println("Ant <=> Banana " + ('Ant' <=> 'Banana'));
  println("Banana <=> Ant " + ('Banana' <=> 'Ant'));
  println("Ant <=> Ant " + ('Ant' <=> 'Ant'));
 
  // ---------- OUTPUT ----------
  // With double quotes we can insert variables
  def randString = "Random";
  println("A $randString string");
 
  // You can do the same thing with printf
  printf("A %s string \n", randString);
 
  // Use multiple values
  printf("%-10s %d %.2f %10s \n", ['Stuff', 10, 1.234, 'Random']);
 
  /*
 
  // ---------- INPUT ----------
  print("Whats your name ");
  def fName = System.console().readLine();
  println("Hello " + fName);
 
  // You must cast to the right value
  // toInteger, toDouble
  print("Enter a number ");
  def num1 = System.console().readLine().toDouble();
  print("Enter another ");
  def num2 = System.console().readLine().toDouble();
  printf("%.2f + %.2f = %.2f \n", [num1, num2, (num1 + num2)]);
 
  */
 
  // ---------- LISTS ----------
  // Lists hold a list of objects with an index
 
  def primes = [2,3,5,7,11,13];
 
  // Get a value at an index
  println("2nd Prime " + primes[1]);
  println("3rd Prime " + primes.get(2));
 
  // They can hold anything
  def employee = ['Derek', 40, 6.25, [1,2,3]];
 
  println("2nd Number " + employee[3][1]);
 
  // Get the length
  println("Length " + primes.size());
 
  // Add an index
  primes.add(17);
 
  // Append to the right
  primes<<19;
  primes.add(23);
 
  // Concatenate 2 Lists
  primes + [29,31];
 
  // Remove the last item
  primes - [31];
 
  // Check if empty
  println("Is empty " + primes.isEmpty());
 
  // Get 1st 3
  println("1st 3 " + primes[0..2]);
 
  println(primes);
 
  // Get matches
  println("Matches " + primes.intersect([2,3,7]));
 
  // Reverse
  println("Reverse " + primes.reverse());
 
  // Sorted
  println("Sorted " + primes.sort());
 
  // Pop last item
  println("Last " + primes.pop());
 
  // ---------- MAPS ----------
  // List of objects with keys versus indexes
 
  def paulMap = [
    'name' : 'Paul',
    'age' : 35,
    'address' : '123 Main St',
    'list' : [1,2,3]
  ];
 
  // Access with key
  println("Name " + paulMap['name']);
  println("Age " + paulMap.get('age'));
  println("List Item " + paulMap['list'][1]);
 
  // Add key value
  paulMap.put('city', 'Pittsburgh');
 
  // Check for key
  println("Has City " + paulMap.containsKey('city'));
 
  // Size
  println("Size " + paulMap.size());
 
  // ---------- RANGE ----------
  // Ranges represent a range of values in shorthand notation
 
  def oneTo10 = 1..10;
  def aToZ = 'a'..'z';
  def zToA = 'z'..'a';
 
  println(oneTo10);
  println(aToZ);
  println(zToA);
 
  // Get size
  println("Size " + oneTo10.size());
 
  // get index
  println("2nd Item " + oneTo10.get(1));
 
  // Check if range contains
  println("Contains 11 " + oneTo10.contains(11));
 
  // Get last item
  println("Get Last " + oneTo10.getTo());
 
  println("Get First " + oneTo10.getFrom());
 
  // ---------- CONDITIONALS ----------
  // Conditonal Operators : ==, !=, >, <, >=, <=
 
  // Logical Operators : && || !
 
  def ageOld = 6;
 
  if(ageOld == 5){
    println("Go to Kindergarten");
  } else if((ageOld > 5) && (ageOld < 18)) {
    printf("Go to grade %d \n", (ageOld - 5));
  } else {
    println("Go to College");
  }
 
  def canVote = true;
 
  // Ternary operator
  println(canVote ? "Can Vote" : "Can't Vote");
 
  // Switch statement
  switch(ageOld) {
    case 16: println("You can drive");
    case 18:
      println("You can vote");
 
      // Stops checking the rest if true
      break;
    default: println("Have Fun");
  }
 
  // Switch with list options
  switch(ageOld){
    case 0..6 : println("Toddler"); break;
    case 7..12 : println("Child"); break;
    case 13..18 : println("Teenager"); break;
    default : println("Adult");
  }
 
  // ---------- LOOPING ----------
  // While loop
 
  def i = 0;
 
  while(i < 10){
 
    // If i is odd skip back to the beginning of the loop
    if(i % 2){
      i++;
      continue;
    }
 
    // If i equals 8 stop looping
    if(i == 8){
      break;
    }
 
    println(i);
    i++;
  }
 
  // Normal for loop
  for (i = 0; i < 5; i++) {
    println(i);
  }
 
  // for loop with a range
  for(j in 2..6){
    println(j);
  }
 
  // for loop with a list (Same with string)
  def randList = [10,12,13,14];
 
  for(j in randList){
    println(j);
  }
 
  // for loop with a map
  def custs = [
    100 : "Paul",
    101 : "Sally",
    102 : "Sue"
  ];
 
  for(cust in custs){
    println("$cust.value : $cust.key ");
  }
 
  // ---------- METHODS ----------
  // Methods allow us to break our code into parts and also
  // allow us to reuse code
 
  sayHello();
 
  // Pass parameters
  println("5 + 4 = " + getSum(5,4));
 
  // Demonstrate pass by value
  def myName = "Derek";
  passByValue(myName);
  println("In Main : " + myName);
 
  // Pass a list for doubling
  def listToDouble = [1,2,3,4];
  listToDouble = doubleList(listToDouble);
  println(listToDouble);
 
  // Pass unknown number of elements to a method
  def nums = sumAll(1,2,3,4);
  println("Sum : " + nums);
 
  // Calculate factorial (Recursion)
  def fact4 = factorial(4);
  println("Factorial 4 : " + fact4);
 
  // ---------- CLOSURES ----------
  // Closures represent blocks of code that can except parameters
  // and can be passed into methods.
 
  // Alternative factorial using a closure
  // num is the excepted parameter and call can call for
  // the code to be executed
  def getFactorial = { num -> (num <= 1) ? 1 : num * call(num - 1) }
  println("Factorial 4 : " + getFactorial(4));
 
  // A closure can access values outside of it
  def greeting = "Goodbye";
  def sayGoodbye = {theName -> println("$greeting $theName")}
 
  sayGoodbye("Derek");
 
  // each performs an operation on each item in list
  def numList = [1,2,3,4];
  numList.each { println(it); }
 
  // Do the same with a map
  def employees = [
    'Paul' : 34,
    'Sally' : 35,
    'Sam' : 36
  ];
 
  employees.each { println("${it.key} : ${it.value}"); }
 
  // Print only evens
  def randNums = [1,2,3,4,5,6];
  randNums.each {num -> if(num % 2 == 0) println(num);}
 
  // find returns a match
  def nameList = ['Doug', 'Sally', 'Sue'];
  def matchEle = nameList.find {item -> item == 'Sue'}
  println(matchEle);
 
  // findAll finds all matches
  def randNumList = [1,2,3,4,5,6];
  def numMatches = randNumList.findAll {item -> item > 4}
  println(numMatches);
 
  // any checks if any item matches
  println("> 5 : " + randNumList.any {item -> item > 5});
 
  // every checks that all items match
  println("> 1 : " + randNumList.every {item -> item > 1});
 
  // collect performs operations on every item
  println("Double : " + randNumList.collect { item -> item * 2});
 
  // pass closure to a method
  def getEven = {num -> return(num % 2 == 0)}
  def evenNums = listEdit(randNumList, getEven);
  println("Evens : " + evenNums);
 
  // ---------- FILE IO ----------
 
  // Open a file, read each line and output them
  new File("test.txt").eachLine {
    line -> println "$line";
  }
 
  // Overwrite the file
  new File("test.txt").withWriter('utf-8') {
    writer -> writer.writeLine("Line 4");
  }
 
  // Append the file
  File file = new File("test.txt");
  file.append('Line 5');
 
  // Get the file as a string
  println(file.text);
 
  // Get the file size
  println("File Size : ${file.length()} bytes");
 
  // Check if a file or directory
  println("File : ${file.isFile()}");
  println("Dir : ${file.isDirectory()}");
 
  // Copy file to another file
  def newFile = new File("test2.txt");
  newFile << file.text;
 
  // Delete a file
  newFile.delete();
 
  // Get directory files
  def dirFiles = new File("").listRoots();
  dirFiles.each {
    item -> println file.absolutePath;
  }
 
  // ---------- OOP ----------
  // Classes are blueprints that are used to define objects
  // Every object has attributes (fields) and capabilities
  // (methods)
 
  // Create an Animal object with named parameters
  // def king = new Animal(name : 'King', sound : 'Growl');
  // or with a Constructor
  def king = new Animal('King', 'Growl');
 
  println("${king.name} says ${king.sound}");
 
  // Change an object attribute with a setter
  king.setSound('Grrrr');
  println("${king.name} says ${king.sound}");
 
  king.run();
 
  println(king.toString());
 
  // With inheritance a class can inherit all fields
  // and methods of another class
  def grover = new Dog('Grover', 'Grrrrr', 'Derek');
 
  king.makeSound();
  grover.makeSound();
 
  // Mammal inherits from the abstract class Thing
  def hamster = new Mammal('Furry');
  hamster.getInfo();
 
  // ---------- EXCEPTION HANDLING ----------
  // Handles runtime errors
 
  try {
    File testFile;
    testFile.append('Line 5');
  }
  catch(NullPointerException ex){
 
    // Prints exception
    println(ex.toString());
 
    // Prints error message
    println(ex.getMessage());
  }
  catch(Exception ex){
    println("I Catch Everything");
  }
  finally {
    println("I perform clean up")
  }
 
 
}
 
// ---------- METHODS ----------
 
// Define them with def and static which means it is shared
// by all instances of the class
static def sayHello() {
  println("Hello");
}
 
// Methods can receive parameters that have default values
static def getSum(num1=0, num2=0){
  return num1 + num2;
}
 
// Any object passed to a method is pass by value
static def passByValue(name){
 
  // name here is local to the function and can't
  // be accessed outside of it
  name = "In Function";
  println("Name : " + name);
}
 
// Receive and return a list
static def doubleList(list){
 
  // Collect performs a calculation on every item in the list
  def newList = list.collect { it * 2};
  return newList;
}
 
// Pass unknown number of elements to a method
static def sumAll(int... num){
  def sum = 0;
 
  // Performs a calculation on every item with each
  num.each { sum += it; }
  return sum;
}
 
// Calculate factorial (Recursion)
static def factorial(num){
  if(num <= 1){
    return 1;
  } else {
    return (num * factorial(num - 1));
  }
}
 
// 1st: num = 4 * factorial(3) = 4 * 6 = 24
// 2nd: num = 3 * factorial(2) = 3 * 2 = 6
// 3rd: num = 2 * factorial(1) = 2 * 1 = 2
 
// ---------- CLOSURES ----------
// pass closure to a method
 
static def listEdit(list, clo){
  return list.findAll(clo);
}
 
}