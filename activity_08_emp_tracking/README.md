Study carefully the conceptual data model for an “employee time tracking system” illustrated by the E/R diagram below (in Chen's notation). 

![pic1.png](pics/pic1.png)

An employee is uniquely identified by a number (the “id” attribute).  For each employee, the system stores the employee’s name, sex (0: not known, 1: male, 2: female, 3: not applicable), and hourly wage. Some employees are supervisors and are not paid by the hour. Those employees earn a fixed salary instead. A supervisor can (potentially) supervise many employees. An employee can have up to one (designated) supervisor. Employees that are supervisors do not have a supervisor.  

Wage-paid employees have to register their working hours in the system by entering the date when they worked, starting and ending hours. All registered working hours need to be approved by the employee’s (designated) supervisor in order to be eligible for payment.  Because supervisors change from time to time, the system needs to maintain (for auditing purposes) the information about which supervisor approved which hours.  

## Part A: Relational Model 

Your first task in this activity is to derive a Relational Model from the conceptual E/R Model detailed in the previous section.  Use the techniques described in the textbook (section 4.5, pages 157-165) and discussed in class to determine how to create relations from the entity sets and relationships of a given E/R Model.  Write your model as a relational schema identifying each  relation, their attributes, attribute domains, and primary keys. Any attribute domain that is not primitive (integer, floating-point, text, char, boolean, date, or time) must be explicitly defined in your solution.   

Employees(id: int [key], name: string, wage: double, sex: int, suid: int [foreign_key])
Supervisors(id: int [key], salary: double)
WorkingHours(emp_id: int [foreign_key], date: date [key], starttime: time [key], endtime: time, sup_id: int [foreign_key])

## Part B: Relational Algebra

Use relational algebra to answer the queries listed in this section.  To reduce repetitive work, you can use := to create useful temporary relations (see section 2.4.13, page 51 of the textbook).  For example, let’s say you are constantly having to join relations A and B to answer different queries.  You can assign the natural join of A and B to C using C := A ⋈ B and then reuse C.   

a) List all male employees. 
 selection: sex:= 1 (employees)
b) List the names of all female employees. 
 projection: name [selection sex:= 2 (employees)]
c) List the name and salary of employees that are supervisors.  
Supervisors' := Employees natural join Supervisors
 projection: name,salary (Supervisors')
d) List all employees that are supervised by “Mary”. 
Employees E join with Supervisors'
S'name = 'mary' and
e id_= s'id
 
e) List the hours entered by “Janet” for the hours she worked on September 15, 2020.  
project start,end (employees natural join workinghours)
e_id = w.emp_id and
w data = 'sept 15 2020'
and e_names = 'janet'
f) List the name of all employees that have non-approved hours for the month of September.  
projection: name (Employee E natural join working hours w)
    E.id = w.emp_id and w.date month = 'september' and w.sup_id = NULL
g) List the names of all supervisors that earn more than $65K.  
projection name [selection salary > 650000 (Supervisors')]

OR

Supevisors' join Employees E 
    s_id = E_sup_id and s.sal > 65k
h) List all wage-paid employees that do not have a (designated) supervisor.  
    Selectionsup_id = NULL (Employees left join Supervisors)
i) List all supervisors that are not supervising any employee.  
    
j) List the name of each wage-paid employee followed by its supervisor’s name and the employee’s hours (date, start, and end) entered for the month of September. For each hour displayed, show whether the hour has been approved or not.  