/* a standalone multiline comment
   spanning two lines 

   see syntax here:
   http://groovy-lang.org/syntax.html
   
*/


/**
 * Groovydoc comment
 */
 
String[] arrStr = ['Ananas', 'Banana', 'Kiwi']
println(arrStr)

/**
 * 

Table 1. Keywords

as        assert     break      case     catch       class     
const     continue   def        default  do          else
enum      extends    false      finally  for         goto
if        implements import     in       instanceof  interface
new       null       package    return   super       switch
this      throw      throws     trait    true        try
while

Identifiers start with a letter, a dollar or an underscore.
They cannot start with a number.

A letter can be in the following ranges:
'a' to 'z' (lowercase ascii letter)
'A' to 'Z' (uppercase ascii letter)
'\u00C0' to '\u00D6'
'\u00D8' to '\u00F6'
'\u00F8' to '\u00FF'
'\u0100' to '\uFFFE'

Here are a few examples of valid identifiers (here, variable names):
def name
def item3
def with_underscore
def $dollarStart

But the following ones are invalid identifiers:
def 3tier
def a+b
def a#b

All keywords are also valid identifiers when following a dot:
foo.as
foo.assert
foo.break
foo.case
foo.catch

The integral literal types are the same as in Java:

byte  char  short
int   long  java.lang.BigInteger

We can force a number (including binary, octals and hexadecimals) to have a specific type by giving a suffix (see table below), either uppercase or lowercase.

Type	Suffix
BigInteger

G or g

Long

L or l

Integer

I or i

BigDecimal

G or g

Double

D or d

Float

F or f

 */

assert arrStr instanceof String[]    
assert !(arrStr instanceof List)
def numArr = [1, 2, 3] as int[]      
assert numArr instanceof int[]       
assert numArr.size() == 3

def matrix3 = new Integer[3][3]         
assert matrix3.size() == 3

Integer[][] matrix2                     
matrix2 = [[1, 2], [3, 4]]
assert matrix2 instanceof Integer[][]

println(matrix2)

String[] names = ['Cédric', 'Guillaume', 'Jochen', 'Paul']
assert names[0] == 'Cédric' 

println(names)

names[2] = 'Blackdrag'          
assert names[2] == 'Blackdrag'

def colors = [red: '#FF0000', green: '#00FF00', blue: '#0000FF']
assert colors['red'] == '#FF0000'

println(Integer.MAX_VALUE)

println(Long.MAX_VALUE)
// note negative
println(Long.MAX_VALUE + 1) 

println(Integer.MIN_VALUE)
println(Integer.MIN_VALUE - 1)

int xInt = 0b10101111;
println(xInt)

float  f = 1.234
println(f)

double d = 2.345
println(d)

long creditCardNumber = 1234_5678_9012_3456L
println(creditCardNumber)
long socialSecurityNumbers = 999_99_9999L
println(socialSecurityNumbers)

