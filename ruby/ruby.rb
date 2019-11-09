#!/usr/bin/env ruby
# class variable defined with prefix @@
class Dinosaur
    @@classification = "Like a Reptile, but like a bird"
    def self.classification 
        @@classification
    end
    def classification 
        @@classification
    end 
end

dino = Dinosaur.new
puts dino.classification

puts Dinosaur.classification


class TRex < Dinosaur
    @@classification = "Big teeth bird!"
end

puts TRex.classification

puts Dinosaur.classification

# class variables defined inside a module will bot overwrite their including classes class variables

module SomethingStrange
    @@classification = "Something Strange"
end

class DuckDinosaur < Dinosaur
    include SomethingStrange
end

puts DuckDinosaur.class_variables

puts SomethingStrange.class_variables

puts DuckDinosaur.classification

local_variable = "local" 
p local_variable

def some_method
    method_scope_var = "hi there" 
    p method_scope_var
end

some_method


3.times do |n|
    local_var = n
    p local_var
end

if true
    usable = "yay"
end

p usable

my_variable = "foo"

my_variable.split("").each do |char|
    puts "my variable #{my_variable},  char #{char}"
end

# rube global varialbes are declared with $

$i_am_global = "omg"

class Dinosaur
    def instance_method
        p "goval variables #{$i_am_global}, #{$another_gloval_var}"
    end

    def self.class_method
        $another_gloval_var = "srsly?"
        p "global vars eveyrwhere see? #{$i_am_global}"
    end
end

p Dinosaur.class_method
p dinosaur = Dinosaur.new
p dinosaur.instance_method

# instance variables are prefixed with @


# Envrmental variable
# ENV will retrieve the environment variables
p ENV['HOME']

# fetch will retrieve the first, argument, if fail retrieve second
p ENV.fetch('foo', 'bar')
p ENV.fetch('foo', 'HOME')
p ENV.fetch('HOME', 'foo')

# constants starts with a Capital letter, 
MY_CONSTANT = "Hello, world" # constant
Constant = "This is a constant" # contant
my_var = " this " # not constant

# constants cannot be defined in methods

# constants can be defined in a class
class Message
    DEFAULT_MESSAGE = "Hello, world"
    @abc = "abc"

    def speak(message = nil)
        if message
            p message
        else
            p DEFAULT_MESSAGE
            p @abc
        end
    end
end

p Message::DEFAULT_MESSAGE
m  = Message.new
m.speak()
m.speak("something")

# Ruby Constant
# __FILE__ is relative path of the file from the execution directory
p __FILE__

# absolute path of the directory
p __dir__

p $PROGRAM_NAME
p $0

p $1

p ARGV
p $*

# Arrays can be created with % syntax or []

# comparable, it is a comparison mentod, you have to "include" Comparable, and define
# the space-ship operatore (<=>)

class Rectangle
    include Comparable

    def initialize(a, b)
        @a = a 
        @b = b
    end

    def area 
        @a * @b 
    end

    def <=>(other)
        area <=> other.area 
    end
end

r1 = Rectangle.new(1, 1)
r2 = Rectangle.new(2, 2) 
r3 = Rectangle.new(3, 3)

p r2 >= r1 
p r2.between? r1, r3
p r3.between? r1, r3
p r3.between? r1, r2

# Simulate flipping a coin
result = [:heads, :tails].sample
if result == :heads
    puts 'The coin-toss came up "heads"'
else
    puts 'The coin-toss came up "tails"' 
end

# Enumerable iteration Iermable iterations such as loop and map
[1, 2, 3].each do |item|
    next if item.even?
    puts "#{item}"
end

# Hash is alike dictionary in python, hash is either created by using {} or, the hash method
my_hash = Hash.new
my_hash = {}
# the key value relationship can by dicted by the colon : or arrow => symbol

# Iterating over a hash, using a .each, .each_pair, .each_key, .each_value method
# .each and .each_pair iterate over each key-value pair
h = { "first_name" => "John", "last_name" => "Doe" } 
h.each do |key, value|
    puts "#{key} = #{value}" 
end

# convertion between hash and array can be done from .to_a and .to_h method

# lambda is similar to fat arrow functions in js

# difference between lambda and proc
# lambada returns back to scope, proc returns out of enclosing scope

# Enumerable is the most porpular modul in Ruby, we can inlcude it in a class
# it contains methods such is mapl select, reduce

class NaturalNumbers
    include Enumerable

    def initialize(upper_limit)
        @upper_limit = upper_limit
    end

    def each(&block)
        0.upto(@upper_limit).each(&block)
    end
end

n = NaturalNumbers.new(6)
p n.reduce(:+)
p n.select(&:even?)
p n.map { |number| number **2 }

# Exceptions
# A custom exception is any class that extends Exception or a sublcass of Exception
# you should always extend StandardError or a descendant. The Exception family are usually for
# virtual machine or system errros, recuing them can prevent a forced interfuption from working as expected

# Defines a nes custom exception called FileNotFound
class FileNotFound < StandardError
end

def read_file(path)
    File.exists?(path) || raise(FileNotFound, "File #{path} not found")
    File.read(path)
end

# p read_file("missing.txt")
p read_file("valid.txt")

# handle multiple execution with recue declaration

begin
    # an execution that may fail
rescue FirstError, SecondError => e
    # do something if FirstError or SecondError occurs
end

begin
    # an execution that may fail
rescue FirstError => e
  # do something if a FirstError occurs
rescue SecondError => e
  # do something if a SecondError occurs
rescue => e
  # do something if a StandardError occurs
end 

# ensure block is analogous to a finally block in java

# raising exception with rais

def hello(subject)
    if subject.to_s.empty?
        raise ArgumentError
    p "hello #{subject}"
    end
end

begin
    hello
rescue ArgumentError
    p "empty argument"
end

begin
    hello("world")
rescue ArgumentError
    p "empty argument"
end

class CustomError < StandardError 
    attr_reader :safe_to_retry
    def initialize(safe_to_retry = false, message = 'Something went wrong') 
        @safe_to_retry = safe_to_retry
        super(message)
    end 
end


begin
   # raise CustomError.new(true)

rescue CustomError => e 
    retry if e.safe_to_retry
end

# Classes
# Constuctor, uses method called initialize, and the method is invoked when a new instance of class is created

class Customer 
    def initialize(name)
        @name = name.capitalize
    end
    def name
        return @name
    end
end

sarah = Customer.new('sarah')
p sarah.name

# class mthod are either public, private and protected, default method is public, privated and protected method must be declared

class Cat
    def initialize(name, age)
        @name = name
        @age = age 
    end
    
    def speak
        puts "I'm #{@name} and I'm #{@age} years old"
    end
    
    private
    def own_age
        self.age 
    end

    private
    def name
        self.name
    end
end

cat1 = Cat.new("ricky", 2)
cat2 = Cat.new("lucy", 4)
cat3 = Cat.new("felix", 2)


# Inheritence with <

class Animal
    def say_hello
        "Meep!"
    end

    def eat 
        "Yum!"
    end
end

class Dog < Animal
    def say_hello
        'Woof!'
    end
end

spot = Dog.new
p spot.say_hello
p spot.eat
# in this example
# Dog inherits from Animal, making it a Subclass
# Dog gains boty the say_hello and eat methods from Animal
# Dog overrides the say_hello method with different functionality

# methods are inherited
class A
    def boo
        p 'boo'
    end
end

class B < A 
end

b = B.new
b.boo

# Class methods are inherited
class A 
    def self.boo
        p 'boo'
    end 
end

class B < A 
end

p B.boo

# Constants are inherited
class A WOO = 1
end
class B < A
end 
p B::WOO
# Constant overwritde
class B
    WOO = WOO + 1
end
p B::WOO

# instance varibles inherited
class A
    attr_accessor :ho 
    def initialize 
        @ho = 'haha'
    end
end

class B < A 
end

b = B.new
p b.ho

# Class instance variables are not inherited
class A 
    @foo = 'foo'
    class << self
        attr_accessor :foo
    end
end

class B < A
end

class B < A 
end

p B.foo

# The accessor is inherited, since it is a class method
B.foo

# Class variables aren't really inherited
class A 
    @@foo = 0
    def initialize
        @@foo += 1
        p @@foo 
    end
end

class B < A 
end

a = A.new
b = B.new

# Multiple inheritence
# Multiple inheritance is a feature that allows one class to inherit from 
# multiple classes. Ruby does not support multiple inheritance. It onluy supports single-inheritence
# class only have one parent. But you can use composition to build more complex clases 
# using modules

# Mixins is a way to achieve something similar to multiple inheritance. It allows
# us to inherit or rather to include methods defined in a module into a class. 
# These method can be included as wither instance or class methods

module SampleModule
    def self.included(base) 
        base.extend ClassMethods
    end
    module ClassMethods
        def method_static
            puts "This is a static method"
        end 
    end
    def insta_method
        puts "This is an instance method"
    end 
end

class SampleClass 
    include SampleModule
end

sc = SampleClass.new
sc.insta_method

p "this is an instance method"

sc.class.method_static
p "this is an static method"

# Refactor to support inheritance
# # eg we are going to refactor dog cat class
class Cat
    def eat
        die unless has_food?
        self.food_amount -= 1
        self.hungry = false
    end
    def sound
        puts "Meow"
    end
end
# class Dog
#     def eat
#         die unless has_food?
#         self.food_amount -= 1
#         self.hungry = false
#     end
#     def sound
#         puts "Woof"
#     end
# end

# refactored code using Animal
class Animal 
    def eat
        die unless has_food? 
        self.food_amount -= 1 
        self.hungry = false
    end
      # No sound method
end

class Cats < Animal 
    def sound
        puts "Meow" 
    end
end

class Dog < Animal
    def sound
        puts "Woof"
    end
end

dog = Dog.new
dog.sound

# Regular experssion 
# =~ operator, returns true and index of the match if the the regexp is in str
# regexp =~ str, and returns nul otherwise

p /stack/ =~ 'haystack'

# Defining Regexp
# using slashses: / /
# using %r{}
# using Regex.new

# following forms are equivalent
regexp_slash = /hello/
regexp_bracket = %r{hello}
regexp_new = Regexp.new('hello')

string_to_match = "hello world"

p string_to_match =~ regexp_slash
p string_to_match =~ regexp_bracket
p string_to_match =~ regexp_new

# Writing a string to a file with File class
file = File.new('tmp.txt', 'w')
file.write('NANANA\n')
file.write('Batman!\n')
file.close

# reading a file with File.open
f = File.open('tmp.txt', 'r') do |f|
    p f.read
end

# writing file with File.open
File.open('text.txt', 'w') do |f|
    f.write("yes\n")
    f.write("no\n")
end

f = File.open('text.txt', 'r') do |f|
    p f.read
end

# # Reading from STDIN using gets
# number1 = gets
# number2 = gets
# puts number1.to_i + number2.to_i

# # reading from ARGV
# number1 = ARGV[0]
# number2 = ARGV[1]
# p number1.to_i + number2.to_i

# Ruby access modifiers
# instance variables denoted by @, belongs to an object,
# instance variables are not shared between objects

# Class variable denoted by @@, same as static variables of java, are nto shared 
# among various objects of that class. Class Variables are stored in heap memory

# in ruby we can never call the method outside the class hierarchy it was defined in

# Summary
# Public: Public methods have manximum visibilityt
# Protected: Protected method can be called with an implicit receivier, as like private. In addition protected method can also be caleld by an explicit 
# receiver (only) if the receiver is "self" or "an object of the same class"
# Private: For a private method in Ruby, it can never be called with an explicit receiver.
# This also means we can call a private method forom within a class it is declared in as well
# as all subclasses of this class

# Design Patterns
# Decorator pattern: ads behavior to objects withoug affecting other objects
# of the same class. The decorate pattern is va useful alternative to creating sub classes
# Create a module for each decorator. This approach is more flexible than inheritance because you can mix
# and match responsibilities in more combinations. Additionally, because the transparency allows
# decorators tov be nesteed recursively, it allows for unlimited number of responsibilities

# class Pizza
#     def cost 
#         300
#     end
# end

# class PizzaWithCheese < Pizza
#     def cost
#         350
#     end
# end

# class LargePizza < Pizza
#     def cost
#         400
#     end
# end 

# we can simplify the approach with Module + extend + super decorator
class Pizza
    def cost
        300
    end
end

module CheesePizza
    def cost
        super + 50
    end
end

module LargePizza
    def cost
        super + 100
    end
end

pizza = Pizza.new
p pizza.cost
p pizza.extend(CheesePizza).cost
p pizza.extend(LargePizza).cost

# Observer pattern is a software design pattern in which an object maintains
# a list of its dependents (called observers), and notifies them automatically
# of any state changes, usually by calling one of their methods

# ruby provides a simple mechanism to implement the Observer design pattern