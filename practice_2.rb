# Object Oriented Programming
# Given a set of classes, some inheriting from others, correctly identify what methods an instance of each class has access to

# All children have access to parent class methods, defaulted to the perms (e.g., protected) from parent...
### Parents cannot access specific child methods (new methods defined specifically for child, OR methods that became overwritten by the child class)
### Children can overwrite both existing methods & variables from parent, as well as change permissions for methods (e.g., from private to public & vice versa)

##################

# Given a parent and child class, correctly use the super method, passing only the necessary arguments, in the child class initialize method to handle shared initialization logic

### What happens when we call super?
# When we call super in the child class, it looks for the method with the same name in the parent class. Then, it's situational depending on whether or not you pass arguments explicitly to the super method call... Example below :)

  class Municipality
    attr_reader :state

    def initialize(state = "California")
      @state = state
    end
  end

  # nyc.state = "New York"
  class City < Municipality
    def initialize(name, state) # name = "New York City", state = "New York"
      @name = name # sets name instance to name
      super(state) # calls super, i.e. initialize from parent Municipality --> In Municipality, state is passed in as "New York"; notice that state is passed in as second argument for City class, and so if you want to use state as the argument for super, you MUST explictly pass state in
    end
  end

  # oaktown.state = "500000"
  class Town < Municipality
    def initialize(population) # population = 500000
      @population = population # set population
      super # population argument gets passed into super, due to defaulting as super does not explicitly take in arguments; In Municipality, state is then passed in as "500000"
    end
  end

  # marin.state = "California"
  class County < Municipality # where is my initialize??????????? :((((((( Oh wait, I just get that from my Mommy Municipality :). In Municipality, we see that since no argument was received, "California" is set as the default for state
    def change_state(new_state)
      self.state = new_state
    end
  end

  nyc = City.new("New York City", "New York")
  oaktown = Town.new(500000)
  marin = County.new

# Implement a class inheritance chain using proper Ruby syntax

def class_chain(obj_class)
  return [nil] if obj_class.nil?

  last = class_chain(obj_class.superclass)
  [obj_class] + last
end

def class_chain_whyyyyyyyyyyyyyyyyyy(obj_class)
  my_chain = [obj_class]
  until obj_class.nil?
    superclass = obj_class.superclass
    my_chain << superclass
    obj_class = superclass
  end
  my_chain
end

p class_chain(nyc.class)
p class_chain_whyyyyyyyyyyyyyyyyyy(marin.class)


# Explain the difference between public, private, and protected methods

## public - can be called by anyone (no access control); methods are public by default (except for initialize, which is always private)
## private - no explicit receiver (w/ exception of self. for setters). Can only be called by defining class that it's called in
## protected - in between public and private; can be called w/ receivers, but only by instances of the same class & subclasses

# Explain the difference between inheriting from a class and including a module

## modules
## + do not create instances, i.e. they do not initialize (cred to Joe)
## + can be used by any class regardless of inheritence and whether the classes are related to each other, as the class will just take in the methods / behaviors described by the module
## + usually has dependency in terms of the expectation on existing instance methods used by the class (e.g., module may use self.name, which assumes the class/file including the module must have the predefined method)

## class inheritance
## + subclasses create instances, i.e. they DO initialize (may use parent initialize method if child does not overwrite it)
## + if methods are implemented after module w/ same name, then the corrsponding methods in module will be overwritten (see below)

module Joe
  def awesomeness
    puts "over 9000"
  end
end

class Joe2
  include Joe

  def initialize
  end

  def awesomeness # Note that this overrode the Module defined method of 'awesomeness'
    puts "negative 9000"
  end
  
end

joe2 = Joe2.new
joe2.awesomeness # puts negative 9000 :(