require 'pry'
require 'pry-debugger'
require 'pry-stack_explorer'


# Classes
class Node
  attr_accessor :question, :yes, :no

  def initialize(question)
    self.question = question
    self.yes = nil
    self.no = nil
  end

  def link(parent, bool)
    parent.yes = self if bool
    parent.no = self if !bool
  end

  def to_s
    "#{self.question} - yes:#{self.yes.question} - no:#{self.no.question}"
  end

end

class Tree
  attr_accessor :root

  def initialize
    self.root = Node.new('Celeb?')
  end
end


# Seeding
tree = Tree.new

last_childy = Node.new("Yay, play again!")
last_childn = Node.new("Nay, play again!")

child1y = Node.new("Was she in Parent Trap?")
child1y.link(tree.root, true)
last_childn.link(tree.root, false)

child2y = Node.new("Is it Lindsay Lohan?")
child2y.link(child1y, true)
child2n = Node.new("Is he married to Angelina Jolie")
child2n.link(child1y, false)

last_childy.link(child2y, true)
last_childn.link(child2y, false)
child3y = Node.new("Is it Brad Pitt?")
child3y.link(child2n, true)
last_childn.link(child2n, false)

last_childy.link(child3y, true)
last_childn.link(child3y, false)


# Game logic
def start_game(node, tree)
  puts node.question
  print 'y/n: '
  answer = gets.chomp!
  if answer == 'y'
    if node.yes.nil?
      start_game(tree.root, tree)
    end
    start_game(node.yes, tree)
  elsif answer == 'n'
    if node.no.nil?
      start_game(tree.root, tree)
    end
    start_game(node.no, tree)
  end
end

start_game(tree.root, tree)