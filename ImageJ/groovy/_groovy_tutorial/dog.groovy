class Dog extends Animal{
  def owner;
 
  // Constructor Method
  def Dog(name, sound, owner){
 
    // Call the Animal constructor
    super(name, sound);
    this.owner = owner;
  }
 
  // Overwrite the Animal makeSound()
  def makeSound(){
    println("${name} says bark and ${sound}");
  }
}