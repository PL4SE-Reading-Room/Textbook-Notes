## 1. Introduction

### 1.1 Types in Computer Science

- **Formal methods**: helping ensure that a system behaves correctly

  - **Powerful** frameworks: e.g., Hoare logic, algebraic specification languages, modal logics, and denotational semantics.
  - **Modest/Lightweight**: e.g., model checkers, run-time monitoring, and **type systems** (by far the most popular and best established).

- **Defination of type systems**

  > A type system is a tractable syntactic method for proving the absence of certain program behaviors by classifying phrases according to the kinds of values they compute.

- Valuable comments

  > A type system can be regarded as calculating a kind of static approximation to the run-time behaviors of the terms in a program. 
  >
  > The tension between conservativity and expressiveness is a fundamental fact of life in the design of type systems.

### 1.2 What Type Systems Are Good For

- **Detecting Errors**

  - early detection instead of much later

- **Abstraction**

  - Type systems form the backbone of the module languages.
  - Interfaces discussed independently from eventual impl.

- **Documentation**

  - Giving useful hints about behavior

- **Language Safety**

  - A contentious concept

  - Informally, a safe language is one that **protects its own abstractions**.

    - e.g., an array can be changed only by `update` operation, instead of writing past the end of another structure.

  - Statically/Dynamically checked & safe/unsafe language

    |        | Statically checked      | Dynamically checked                  |
    | ------ | ----------------------- | ------------------------------------ |
    | Safe   | ML, Haskell, Java, etc. | Lisp, Scheme, Perl, Postscript, etc. |
    | Unsafe | C, C++, etc.            |                                      |

  - **Seldom absolute**: safe languages call functions written by other unsafe languages.

- **Efficiency**

  - Eliminate many dynamic checks by proving statically that they'll always be satisfied.
  - Type info improves efficiency in many surprising places.

- **Further Applications**

  - Computer and network security
  - Program analysis tools (by typechecking and inference algorithms)
  - Automated theorem proving
  - Database
  - Computational linguistics

### 1.3 Type Systems and Language Design

- Languages without type systems tend to offer features making typechecking difficult or infeasible.
- Complexity of concrete syntax: typed > untyped
- Well-designed statically typed language: **never** require huge amounts of type info explicitly and tediouly maintained by the programmer.



## 2. Mathematical Preliminaries

### 2.1 Sets, Relations, and Functions

- **undefined** partial function: $f(x)\uparrow$ or $f(x)=\uparrow$. **defined**: $f(x)\downarrow$.
- $P$ is **preserved** by $R$ if whenever we have $s$ $R$ $s'$ and $P(s)$, we also have $P(s')$.

### 2.2 Ordered Sets

- **Preorder**: reflexive + transitive; **Partial order**: preorder + antisymmetric; **Total order**: partial order + $\forall s,t,\in S,s\le t\ \textrm{or}\ t\le s$.
- Join (or **least upper bound**), meet (or **greatest lower bound**).
- **reflexive closure** of $R$: smallest reflexive relation $R'$ that contains $R$.
  - When proving this property, first prove "reflexive", then prove "smallest".
- **Decreasing chain**: each member of a sequence is **strictly** less than its predecessor.
- A preorder $\le$ is **well founded** if it contains no **infinite** decreasing chains. (e.g., 0 < 1 < 2 < ...)

### 2.4 Induction

- **Principle of Lexicographic Induction**: Suppose that $P$ is a predicate on pairs of natural numbers. If, for each pair $(m,n)$ of natural numbers, given $P(m',n')$ for all $(m',n') < (m,n)$ we can show $P(m,n)$, then $P(m,n)$ holds for all $m,n$.
  - $(m,n)\le (m',n')$ iff either $m<m'$ or else $m=m'$ and $n\le n'$.