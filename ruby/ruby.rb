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

# Observer
# The observer pattern is a software design pattern in which an object (called subject)
# maintains a liust of its dependent (called observers), and notifies them automatically of any state changes
# usually by calling one of their methods

# Ruby provides a simple mechanism to implement the Observer design pattern.
# The module Observble provides the logic to notify the subscriber of any changes in the Observable object

# For this work the observable has to assert it has changed and notify
# the observers
# Objects observicng have to implement an update() method, which will be the callback for the Observer

require "observer"

class Moderator
    include Observable

    def initialize(name)
        @name = name
        @message = "hello world"
    end
    def write
        message = @message
        changed
        notify_observers(message)
        return message
    end
    def set( message )
         @message = message
    end
end

# moderator = Moderator.new("Rupert")
# p moderator.write
# moderator.set("else")
# p moderator.write

class Warner
    def initialize(moderator, limit)
        @limit = limit
        moderator.add_observer(self)
    end
end

class Subscriber < Warner
    def update(message)
        p "#{message}"
    end
end

moderator = Moderator.new("Ropert")
subscriber = Subscriber.new(moderator, 3)
p moderator.write
subscriber.update("no")
moderator.set("abcd")
p moderator.write

# Singleton pattern, singleton error is implemnted by including the
# Singleton module

# require 'singleton'

# class Logger
#     include Singleton
# end

# # If you try to instantiate this class as you normally would a regular class,
# # a NoMethodError exception is raised. The constructor is made private to
# # prevent other instances from being accidentally created

# begin
#     Logger.new
# rescue NoMethodError
#     p "NoMethodError"
# end

# # To access the instance of this class we need to use the instance() method
# first, second = Logger.instance, Logger.instance
# p first == second 

# Logger example
require 'singleton'

class Logger
    include Singleton
    def initialize
        @log = File.open("log.txt", "a")
    end
    def log(msg)
        @log.puts(msg)
    end
end

Logger.instance.log('message 2')

# Loading Source Files
# Require files to be loaded only once
# The require mehtod will load files only once (serveral calls to require will result the code int the file being evaluated only once)
# It will search your $LOAD_PATH to find the required file
# if the parameter is not an absolute path.
# Extensions like .rb, .so, .o, or .dll are optional. 
# Relative paths will bre resolved to the current working directory of the process

require 'awesome_print'

# the require_relative allows you to load files relative
# to the current source file
begin
    #require_relative 'myproj/version'
rescue
    p "cannot load"
end

# Thread
# User mutex to synchronizd access to a variable iss accessed from multiple threads
# counter = 0
# counter_mutex = Mutex.new

# # Start 3 parallel threads and increment counter
# 10.times.map do |index|
#     Thread.new do
#         counter_mutex.synchronize { counter += 1 }
#         p counter
#     end 
# end.each(&:join) # Wait for all threads to finish before killing the process
# p counter

# Otherwise, the value of counter currently visisble to one thread can be changed by naother thread
# Without Mutex (see e.g. Thread 0, where Before and After differ by kmore than 1)

# thread sematics
# A new thread separate from the main thread's executin, can be created using Thread.new

# thr = Thread.new {
#     sleep 1 # 1 second sleep of sub thread
#     p "Whats the big deal"
# }
# # This will automatically start the execution of the new thread
# # To freeze execution of the main Threadm until the new thread stops, use join:

# thr.join #=> ... "Whats the big deals"

# Terminating a thread
# A thread terminates if ti reaches the end of its code block
# The best way to terminate a thread early is to convince it 
# to reach the ned of tis code block. This way, the thread can run cleanup before dying

# This thread runs a loop while the instance variable continue is true.
# Set this variable to false, and the thread to die a natural death

# require 'thread'
# class CounterThread < Thread
#     def initialize
#         @count = 0
#         @continue = true
    
#         super do
#             @count += 1 while @continue
#             p "I counted up to #{@count} before i cruelly stopped"
#         end
#     end

#     def stop
#         @continue = false
#     end
# end

# counter = CounterThread.new
# sleep 2
# counter.stop

# how to kill a thread
# you can use Thread.kill or Thread.terminate

# thr = Thread.new { ... }
# Thread.kill(thr)

# Modules
# A simple mixin with include
# module SomeMixin
#     def foo
#         p "foo!"
#     end
# end

# class Bar
#     include SomeMixin
#     def baz
#         p "baz!"
#     end
# end
# b = Bar.new
# b.baz
# b.foo

# Now Bar is a mix of its own methods and the methods from SomeMixin
# Note that how a mixin is used in a class depends on how it is added
# The include keyword evaluates the modele code in the class context (eg. method definitions will be methods on instances of the class)
# extend will evaluate the module code in the context of the singleton class of the object (methods are
# available directly on the extended object)

# Module and Class Composition
# module to build mroe complex classes through composition. The include
# ModuleName directive incorporates a module's method into a class

# module Foo
#     def foo_method
#         p 'foo_method called!'
#     end
# end

# module Bar
#     def bar_method
#         p 'bar_method called!'
#     end
# end

# class Baz 
#     include Foo
#     include Bar
#     def baz_method
#         p 'baz_method called!'
#     end
# end

# new_baz = Baz.new
# new_baz.baz_method
# new_baz.bar_method
# new_baz.foo_method

# Module as Namespaces
# Modules can contain other modules and classes

module Namespaces
    module Child
        class Foo
        end
    end # module Child

    # Foo can be accessed as:
    Child::Foo
end # module Namespace

# Foo must be accessed as:
Namespaces::Child::Foo


# Introspection in Ruby
# Introspection is looking inward to know about what is inside
# Introspection is the ability to look at opject, class at runtime
# to know what is inside

# Instrospection of a class
class Aa
    def a 
    end
end
module Bb
    def b 
    end
end

class Cc < Aa 
    include Bb
    def c 
    end
end

# We can see instance of Cc by using instance method
p Cc.instance_methods

# What are the instance methods declared on Cc
p Cc.instance_methods(false)

# What are the ancestors of class Cc
p Cc.ancestors

# What are the superclass of Cc
p Cc.superclass

# Introspecting Instance class

s = 'Hello'
p s.class

p s.methods

# you want to know if s is instance of string
p s.instance_of?(String)

# public methods of instance
p s.public_methods

# private mthods of instance
p s.private_methods

# check if instance contains private method trap
p s.private_methods.include? :trap

# check if s have method upper
p s.respond_to?(:upper)

p s.respond_to?(:upcase)

# Monkey Patching
# a way of modifying and extending classes in ruby

# changing an existing ruby method
p "Hello readers".reverse

class String
    def reverse
        self.upcase
    end
end

p "Hello readers".reverse

# Monkey patching a class
# Override String Class to provide parsing to boolean
# we add the to_b() method to the String class
class String
    def to_b
        self =~ (/^(true|TRUE|True|1)/i) ? true : false
    end
end
p 'true'.to_b
p 'i'.to_b
p 'foo bar'.to_b

# Monkey patching an object, the difference from class is that
# only one instance can use the new method

s = 'true'
t = 'false'

def s.to_bb
    self =~ /true/ ? true : false
end

p s.to_bb
# p t.to_bb

# Recursion in ruby
# Tail recursion, many recursive algorithms can be expressed using iteration
# For instance, the greatest common denominator function can be written recusively
def gdc(x, y)
    return x if y == 0
    return gdc(y, x%y)
end

# iteratively
def gdc_iter (x, y)
    while yt != 0 do
        x, y = y, x%y
    end
    return x
end

# the 2 algorithms are equivalent in theory, but the recursive verison risks a SystemStackError. However, since
# the recursive mehtod ends with a call to itself, it could be optimized to avoid stack overflow.
# Another way to put it: the recursive algorithm can result in the same machine code as the iterative
# if the compiler knows to look for the recursive method call at the end of the method.
# Ruby doens't do tail call optimmization by defaiult, but you can to it on with it

RubyVM::InstructionSequence.compile_option = {
    tailcall_optimizasiton: true,
    trace_instruction: false
}

# JSON with Ruby
# by requiring the json package you can convert json to hash, or hash to json
require 'json'

j = '{"a": 1, "b": 2}'

p JSON.parse(j)

hash = { 'a' => 1, 'b' => 2 }
p json = hash.to_json
p JSON.parse(json)

# Gem suage
# To install a ruby gem, enter the command
# gem install [gemname]

# if you are working on a project with a list of gem dependencies, then these will be listed in a file called
# Gemfile. To install a new gen in the project, add the following line of code in the Gemfile
# gem 'gemname'
# This Gemfile is used buy the Buhndler gem to install dependencies your project requires, this does
# however mean that you'll have to install Bundler first by running (if you haven't already)
# gem install bundler
# Save the file, and then run the command
# bundle install
# version is denoted by the -v flag

# Gem installation from github/filesystem
# you can install a gem from githu=b or filesystem. If the gem has been checkout
# from git or somehow already on the filessytem, you could install it usiong
# gem install --local path_to_gem/filename.gem

# Install gem  from github. Download the sources from github
# mkdir newgem
# cd newgem
# git clone https://urltogem.get

# build the gem
# gem build GEMNAME.gemspec
# gem install gemname-version.gem

# checking if a require gem is installed from within code
# to check if a required gem is installed, from within your code,
# you can use the following (using nokogiri as an example)

# begin 
#     found_gem = Gem::Specification.find_by_name('nokogiri')
#     require 'nokogiri'
# rescue Gem::LoadError
# end

# However this can be further extend to a function that can be
# used in setting up functionality within your code

def gem_installed?(gem_name)
    found_gem = false
    begin
        found_gem = Gem::Specification.find_by_name(gem_name)
    rescue Gem::LoadError
        return false
    else
        return true
    end
end

if gem_installed?('nokogiri')
    require 'nokogiri'
else
    printf "nokogiri gem required\n"
    exit 1
end

#  installing gem by specifying in Gemfile
# source 'https://rubygem.org'
# gem 'bundler'

# # points to a release
# gem 'rack', '~>1.5.2'
# # User a specific version
# gem 'sinatra', '1.4.1'
# # use at least a version ro anything greater
# gem 'uglifier',  '>= 1.3.0'

# # pull gem from git repo
# gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git'
# # you can specify a sha
# gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', sha: '30d4fb468fd1d6373f82127d845b153f17b54c51'
# # you can also specify a branch, though this is often unsafe
# gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', branch: 'master'

# # you can group gem depending on what they are used for
# group :development, :test do
#     # This gem is only available in dev and test, not production. 
#     gem 'byebug'
# end

# to install gems from Gemfile
# gem install bundler
# bundle install

# Dynamically Creating Methods from Strings
xml = <<ENDXML 
<methods>
    <method name="go">puts "I'm going!"</method>
    <method name="stop">7*6</method>
</methods>
ENDXML


class Fooo 
    def self.add_method(name, code)
        body = eval( "Proc.new{ #{code} }")
        define_method(name, body)
    end
end

require 'nokogiri'
doc = Nokogiri.XML(xml)
doc.xpath('//method').each do |method|
    Fooo.add_method( method['name'], method.text )
end

f = Fooo.new
p Fooo.instance_methods(false)
p f.public_methods(false)
f.go
p f.stop

# you can evaluate a string like a code using the eval method

# you can execute command line argument with Open3
require 'open3'
# stdin, stdout, stderr, wait_thr = Open3.popen3("touch cmdline")
# puts "#{stdout.read} #{stderr.read} #{wait_thr.value.exitstatus}"

# cmd = 'git push origin master'
# Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thr|
#     puts "stdout is:" + stdout.read
#     puts "stderr is:" + stderr.read 
# end

# Open3.capture3('touch', stdin_data: 'example touch file')

# you can execute commandline uing popen3, exec, system or '`' backticks
# this is how you perform git commit using ruby
# require 'open3'

# p "please enter commit message"
# stdin_data = gets

# commands = ['git add .', \
#             'git commit -m "' + stdin_data +'"', \
#             'git push']

# for command in commands
#     stdin, stdout, stderr, wait_thr = Open3.popen3(command)
#     puts "stdout is:" + stdout.read
#     puts "stderr is:" + stderr.read
# #    system (command)
# #    p command
# end

# you can imbed other languages in ruby code using rubyinline
