#lang dssl2

# HW2: Stacks and Queues

import ring_buffer


let eight_principles = ["Know your rights.", "Acknowledge your sources.", "Protect your work.", "Avoid suspicion.", "Do your own work.", "Never falsify a record or permit another person to do so.", "Never fabricate data, citations, or experimental results.", "Always tell the truth when discussing your work with your instructor."]

interface STACK[T]:
    def push(self, element: T) -> NoneC
    def pop(self) -> T
    def empty?(self) -> bool?

# Defined in the `ring_buffer` library; copied here for reference.
# Do not uncomment! or you'll get errors.
# interface QUEUE[T]:
#     def enqueue(self, element: T) -> NoneC
#     def dequeue(self) -> T
#     def empty?(self) -> bool?

# Linked-list node struct (implementation detail):
struct _cons:
    let data
    let next: OrC(_cons?, NoneC)

###
### ListStack
###

class ListStack[T] (STACK):

    # Any fields you may need can go here.

    
    let head
    let length
    # Constructs an empty ListStack.
    def __init__ (self):
        
        
        
        self.head = None
        self.length = 0
    #   ^ ADD YOUR WORK HERE

    # Other methods you may need can go here.
        
    def empty?(self) -> bool?:
        
    
      return self.length == 0 
    
    def push(self, element: T) -> NoneC:
    
      if self.empty?() == True:
          
          self.head = _cons(element, None)
          self.length = self.length + 1 
      else:
          self.head = _cons(element, self.head)
          
          self.length = self.length + 1    
         
    
    def pop(self) -> T:
        
        if self.empty?()== True:
           
           error("Nothing in here")
            
        else:
            let store = self.head.data
            self.head = self.head.next
            self.length = self.length - 1
            return store
                
                
    def len(self) -> nat?:
         
         return self.length        
                
    
   
    
       
test "woefully insufficient":
    let s = ListStack()
    s.push(2)
    assert s.pop() == 2
    
    
### Graders test  :
    
    
###Basic stack test  
    
test "push twice, pop twice should return earliest":    
    
    let m = ListStack()
    m.push(4)
    m.push(5)
    assert m.pop() == 5
    assert m.len() == 1
    assert m.pop() == 4
    
test " push 5 times, pop 4 times should return second thing we pushed" :
    
    let e = ListStack()
    e.push(10)
    e.push(11)
    e.push(12)
    e.push(14)
    e.push(16)
    e.pop()
    assert e.pop() == 14
    e.pop()
    assert e.pop() == 11
    
    
    
## Running Advanced Stack Tests??? ask office hours:
    
test"push 4 times, pop 3, push 1, pop 3 should error":
    let a = ListStack()
    a.push("now")
    assert a.pop() == "now"
    a.push(20)
    a.push(30)
    a.push(25)
    a.push(7)
    assert a.pop() == 7
    assert a.pop() == 25
    assert a.pop() == 30
    a.push("love")
    a.pop()
    a.pop()
    assert_error a.pop() == "Nothing in here"


    
    
    

###
### ListQueue
###

class ListQueue[T] (QUEUE):

    # Any fields you may need can go here.
    let head
    let length
    let tail 
    # Constructs an empty ListQueue.
    def __init__ (self):
        
        
       
        self.head = None 
        self.length = 0
        self.tail = None
    #   ^ ADD YOUR WORK HERE
        
       

    # Other methods you may need can go here.
    
    def enqueue(self, element: T) -> NoneC:
         
     let m = self.tail
     
     if self.empty?() == True:
        
         self.tail = _cons(element, None)
         self.head = self.tail
#         print("%p", self.head)
 #        print("%p", self.tail)
     else:
         m.next = _cons(element, None)
 #        self.head.next = m
         
#         let x = self.tail.next == _cons(element, None)

#         print("%p", self.tail)
         self.tail = m.next
         
#         print("%p", self.tail)
         
     self.length = self.length + 1
     
    def dequeue(self) -> T:
        
      if self.empty?() :
          
          error("Nothing in here")
          
          
      else:
          
       
        #print("%p", self.head.data)  
        let v = self.head.data  
        
       
        
        self.length = self.length - 1
       
        self.head = self.head.next
        
       
       
        return v
        
        
         
     
     
     
     
    def empty?(self) -> bool?:
        
        return self.length == 0
     
     
       
test "woefully insufficient, part 2":
    let q = ListQueue()
    q.enqueue(2)
    assert q.dequeue() == 2

    
    
    
### Running basic queue tests:
    
test " enqueue twice, dequeue twice should return the second thing we enqueued":
    
    let r = ListQueue()
    r.enqueue("play")
    r.enqueue("stop")
    assert r.dequeue() == "play"
    assert r.dequeue() == "stop"
    
test " enqueue 5 times, dequeue 4 times should return next to last":
    
    let j = ListQueue()
    
    j.enqueue("40")
    j.enqueue("45")
    j.enqueue("87")
    j.enqueue("2")
    j.enqueue("4")
    
    j.dequeue()
    j.dequeue()
    j.dequeue()
    assert j.dequeue() == "2"
    
#### Running advanced queue tests:
    
test"enqueue 4 times, dequeue 3x, enqueue 1x, dequeue 3x should error ":

    let best = ListQueue()
    
    best.enqueue("30")
    best.enqueue("100")
    best.enqueue("200")
    best.enqueue("300")
    
    best.dequeue()  
    best.dequeue()
    best.dequeue()
    
    best.enqueue("400")
    
    best.dequeue() 
    best.dequeue()
    assert_error best.dequeue() == "Nothing in here"
###
### Playlists
###

struct song:
    let title: str?
    let artist: str?
    let album: str?

# Enqueue five songs of your choice to the given queue, then return the first
# song that should play.
def fill_playlist (q: QUEUE!):
   
  let best_playlist = [song('Kiss', 'Prince', 'Parade-Music from the Motion Picture Under the Cherry Moon')
                ,song('Purple Rain', 'Prince', 'Purple Rain')
                , song('I would Die 4 U', 'Prince', 'Purple Rain'), 
                song('Smoooth CRIMINAL','Micheal Jackson','Bad 25th Anniversary'), 
                song('Fear is Not My Future', 'Todd Galberth', 'Encounter')]
                    
    
  for song in best_playlist:
        q.enqueue(song)
    
  return q.dequeue()
    
    
    
#   ^ ADD YOUR WORK HERE

test "ListQueue playlist":
    
    let got_it = ListQueue()
    
    assert fill_playlist(got_it) == song('Kiss', 'Prince', 'Parade-Music from the Motion Picture Under the Cherry Moon')
    
# To construct a RingBuffer: RingBuffer(capacity)
test "RingBuffer playlist":
    
    let rock_with_you = RingBuffer(5)
    
    assert fill_playlist(rock_with_you) == song('Kiss', 'Prince', 'Parade-Music from the Motion Picture Under the Cherry Moon')
    