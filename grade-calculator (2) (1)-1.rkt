#lang dssl2

# HW1: Grade Calculator

###
### Data Definitions
###


let eight_principles = ["Know your rights.", "Acknowledge your sources.", "Protect your work.", "Avoid suspicion.", "Do your own work.", "Never falsify a record or permit another person to do so.", "Never fabricate data, citations, or experimental results.", "Always tell the truth when discussing your work with your instructor."]

let outcome? = OrC("got it", "almost there", "on the way", "not yet",
                   "missing honor code", "cannot assess")

struct homework:
    let outcome: outcome?
    let self_eval_score: nat?

struct project:
    let outcome: outcome?
    let docs_modifier: int?

let letter_grades = ["F", "D", "C-", "C", "C+", "B-", "B", "B+", "A-", "A"]
def letter_grade? (str):
    let found? = False
    for g in letter_grades:
        if g == str: found? = True
    return found?


###
### Modifiers
###

def worksheets_modifier (worksheet_percentages: VecKC[num?, num?]) -> int?:
    
    let hundred =0
    let eighty = 0
    let less = 0
    if worksheet_percentages[0] <= 1.0 and worksheet_percentages[1] <= 1.0:
         if worksheet_percentages[0] >= 0.0 and worksheet_percentages[1] >= 0.0:
             
            for x in worksheet_percentages:
                
                if x >= 0.8 and x < 1 :
                    eighty = eighty + 1
                    
                elif x == 1 :
                    hundred = hundred + 1
                
                elif x < 0.8 :
                    less = less + 1
                    
    if less == 1 or less == 2:
        return -1
    
    if hundred == 2 :
        return 1
        
    if eighty == 2: 
       return 0
                   
                    
                       
                 
    # pass
    #   ^ ADD YOUR WORK HERE

def exams_cal (exam: nat? ) -> int?:
    
    
    
      let stop = 0
      let modifier 
      if exam >= 0 and exam <= 20:
           
        while stop == 0:
          if exam <= 3 and exam >=0 :
            
            modifier = -3
            return modifier
            stop  =1
          
          elif exam <= 7 and exam >= 4 :
            
            modifier = -2
            return modifier
            stop  =1
          elif exam <= 10 and exam >=8 :
            
            modifier = -1
            return modifier
            stop  =1  
          elif exam <= 16 and exam >=11 :
            
            modifier = 0
            return modifier
            stop  =1
            
          elif exam <= 20 and exam >=17 :
            
            modifier = 1
            return modifier
            stop  =1
            
       
def exams_modifiers (exam1: nat?, exam2: nat?) -> int?:

    
    
    let mod1 = exams_cal(exam1)
    let mod2 = exams_cal(exam2)
    let mod3 = 0
    let improve= 0
    
    if mod2 > mod1:
        
       improve = (-1*(mod1 - mod2))
   
    if improve >= 2 :
        mod3= 1
        
    return (mod1 + mod2 + mod3)
    
    
    #   ^ ADD YOUR WORK HERE

def self_evals_modifier (hws: VecC[homework?]) -> int?:
    
    
     
     let count = 0
     for x in hws:
       count= count + 1
     
     let store = 0
     let results = [1,2,3,4,5]
     let best = 0
     let mid = 0
     let worst = 0
     if  count == 5:
       for vals in hws :
           store = vals.self_eval_score
           
           if store == 5:
               best = best +1 
               
           if store >= 3 and store < 5:
               mid = mid - 1
               
           if store <= 2 and store >= 0:
               worst = worst + 1
               
 #      for match in results:
 #          if best == match :
 #              return 1
       if best >= 4 :
           return 1
           
       elif  mid >= 3 or worst <= 2:
           return 0
           
       elif mid <= 2 or worst >= 3:
           return -1
           
     else:
         error("not right amount of hws")   
    #   ^ ADD YOUR WORK HERE

def in_class_modifier (scores: VecC[nat?]) -> int?:
    # 'scores' vector represenst the scores received 
    # on all in-class exercises conducted in class, 
    # including 0s due to missed classes. 
    # The length of the vector should be the number of 
    # exercises conducted in class.
    if scores.len() == 0: error('in_class_modifier: received empty vector')
    let total_ones = 0
    for score in scores:
        total_ones = total_ones + score
    # computes percentage and then rounds
    let in_class_percentage = (total_ones/scores.len())*100
    let in_class_percentage_rounded = (in_class_percentage + 0.5).floor()
    if in_class_percentage_rounded >= 90: return 1
    if in_class_percentage_rounded >= 50 and in_class_percentage_rounded < 90: return 0
    return -1

###
### Letter Grade Helpers
###

# Is outcome x enough to count as outcome y?
def is_at_least (x:outcome?, y:outcome?) -> bool?:
    if x == "got it": return True
    if x == "almost there" \
        and (y == "almost there" or y == "on the way" or y == "not yet"):
        return True
    if x == "on the way" and (y == "on the way" or y == "not yet"): return True
    return False

def apply_modifiers (base_grade: letter_grade?, total_modifiers: int?) -> letter_grade?:
    
#    let point = 0
     let set =0
    
     if base_grade == letter_grades[0] :
        return letter_grades[0]
                   
  
       
     else:
        
        for index, letter in range(len(letter_grades)):
            
         if base_grade == letter_grades[index]:
             set = index
             
        
       
            
        set = set+ total_modifiers 
            
             
            
        if set >= 9:
                
                return "A"
                
             
        elif set <= 0:
              
                return "F"  
        else:
            
            return letter_grades[set]
        
        
    
    
    #   ^ ADD YOUR WORK HERE


###
### Students
###

class Student:
    let name: str?
    let homeworks: VecKC[homework?, homework?, homework?, homework?, homework?]
    let project: project?
    let worksheet_percentages: VecKC[num?, num?]
    let in_class_scores: VecC[nat?]
    let exam_scores: VecKC[nat?, nat?]

    def __init__ (self, name, homeworks, project, worksheet_percentages, in_class_scores, exam_scores):
        
        self.name = name
        self.homeworks = homeworks
        self.project = project
        self.worksheet_percentages =  worksheet_percentages
        self.in_class_scores =  in_class_scores
        self.exam_scores = exam_scores
    #   ^ ADD YOUR WORK HERE

    def get_homework_outcomes(self) -> VecC[outcome?]:
        
        
        let outcome = []
       
#        for x in self.homeworks:
            
#            outcome = [outcome, x]
        let hmk_outcomes = [self.homeworks[0].outcome, self.homeworks[1].outcome, self.homeworks[2].outcome, 
          self.homeworks[3].outcome, self.homeworks[4].outcome ]
                     
  #      print("%p", outcomes)    
        return hmk_outcomes    
            
       
        
    #   ^ ADD YOUR WORK HERE

    def get_project_outcome(self) -> outcome?:
        
        let proj_outcome = self.project.outcome
        
        return proj_outcome
        
    #   ^ ADD YOUR WORK HERE

    def resubmit_homework (self, n: nat?, new_outcome: outcome?) -> NoneC:
        
        
        if n>= 1 and n<= 5:
#          for hmk in self.homeworks:
            
#            if self.homeworks[n] == hmk:
                n= n-1
                
                self.homeworks[n].outcome = new_outcome
                return None
        else:
            
            error("out of bounds")
                    
    #   ^ ADD YOUR WORK HERE

    def resubmit_project (self, new_outcome: outcome?) -> NoneC:
        
        
        self.project.outcome = new_outcome
        
    #   ^ ADD YOUR WORK HERE

    def base_grade (self) -> letter_grade?:
        let n_got_its       = 0
        let n_almost_theres = 0
        let n_on_the_ways   = 0
        for o in self.get_homework_outcomes():
            if is_at_least(o, "got it"):
                n_got_its       = n_got_its       + 1
            if is_at_least(o, "almost there"):
                n_almost_theres = n_almost_theres + 1
            if is_at_least(o, "on the way"):
                n_on_the_ways   = n_on_the_ways   + 1
        let project_outcome = self.get_project_outcome()
        if n_got_its == 5  and project_outcome == "got it": return "A-"
        # the 4 "almost there"s or better include the 3 "got it"s
        if n_got_its >= 3  and n_almost_theres >= 4 and n_on_the_ways >= 5 \
           and is_at_least(project_outcome, "almost there"):
            return "B"
        if n_got_its >= 2  and n_almost_theres >= 3 and n_on_the_ways >= 4 \
           and is_at_least(project_outcome, "on the way"):
            return "C+"
        if n_got_its >= 1  and n_almost_theres >= 2 and n_on_the_ways >= 3 \
           and is_at_least(project_outcome, "on the way"):
            return "D"
        return "F"

    def project_above_expectations_modifier (self) -> int?:
        let base_grade = self.base_grade()
        if base_grade == 'A-': return 0 # expectations are already "got it"
        if base_grade == 'B':
            if is_at_least(self.project.outcome, 'got it'):       return 1
            else: return 0
        else:
            # two steps ahead of expectations
            if is_at_least(self.project.outcome, 'got it'):       return 2
            # one step ahead of expectations
            if is_at_least(self.project.outcome, 'almost there'): return 1
            else: return 0

    def total_modifiers (self) -> int?:
       
        
       
    

       let q =  worksheets_modifier(self.worksheet_percentages)
        
       let w =  exams_modifiers(self.exam_scores[0], self.exam_scores[1])
        
       let r =  self_evals_modifier(self.homeworks)
        
       let f = in_class_modifier(self.in_class_scores)
        
       let d = self.project_above_expectations_modifier()
         
       let x = self.project.docs_modifier
         
       let total = q + w + r + f + d + x
        
       return total
        
    #   ^ ADD YOUR WORK HERE

    def letter_grade (self) -> letter_grade?:
        let b = self.base_grade()
        let m = self.total_modifiers()
        return apply_modifiers(b, m)

###
### Feeble attempt at a test suite
###
        
test "apply_modifiers":
    
 assert apply_modifiers('A-', -3) == 'B-' 
 assert apply_modifiers('B', -2) == 'C+'
 assert apply_modifiers('C+', -1) == 'C'
 assert apply_modifiers('C+', -2) == 'C-'
 assert apply_modifiers('D', -1) == 'F'
 assert apply_modifiers('D', -1) == 'F'
        
        
test 'worksheets_modifier, negative modifier':
    assert worksheets_modifier([0.5, 0.85]) == -1
    assert worksheets_modifier([0.3, 0.79]) == -1
   
test 'exam_modifier' :
   assert exams_modifiers(3, 16) ==  -2  
   assert exams_modifiers(16, 3) == -3
   assert exams_modifiers(7, 17) == 0
   
test 'Student#letter_grade, worst case scenario':
    let s = Student('Everyone, at the start of the quarter',
                    [homework("not yet", 0),
                     homework("not yet", 0),
                     homework("not yet", 0),
                     homework("not yet", 0),
                     homework("not yet", 0)],
                    project("not yet", -1),
                    [0.0, 0.0],
                    [0],
                    [0, 0])
    assert s.base_grade() == 'F'
    assert s.total_modifiers() == -10
    assert s.letter_grade() == 'F'

test 'Student#letter_grade, best case scenario':
    let s = Student('This could be you, if youre willing to work hard',
                    [homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5)],
                    project("got it", 1),
                    [1.0, 1.0],
                    [1, 1, 1, 1, 1],
                    [20, 20])
    assert s.base_grade() == 'A-'
    assert s.total_modifiers() == 6
    assert s.letter_grade() == 'A'
    
    

test'self_evals':
  let m =  [homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 1),
                     homework("got it", 2),
                     homework("got it", 5)]  
  assert self_evals_modifier(m) ==0
#  assert self_evals_modifier([5,5,5,5,1]) == 1
#  assert self_evals_modifier( [5,1,2,5,1]) == -1
    
    
    
 
    
        
test 'homework_outcomes':
    
     let m = Student('This could be you, if you are willing to work hard',
                    [homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5)],
                    project("got it", 1),
                    [1.0, 1.0],
                    [1, 1, 1, 1, 1],
                    [20, 20])
     
     let f = m.get_homework_outcomes()
     
     assert f == ["got it","got it","got it","got it","got it"]
     
     
test 'resubmit_homework':
    
      let j = Student('This could be you, if you are willing to work hard',
                    [homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5),
                     homework("got it", 5)],
                    project("got it", 1),
                    [1.0, 1.0],
                    [1,1,1,1,1],
                    [20, 20])
                    
      j.resubmit_homework(1, "almost there")
     
      let w = j.get_homework_outcomes()
         
      assert w == ["almost there","got it","got it","got it","got it"]
     

     
