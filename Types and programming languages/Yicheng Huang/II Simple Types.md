## Chapter 8: Typed Arithmetic Expressions

### 8.1 Types

- Motivation

  > We would therefore like to be able to tell, without actually evaluating a term, that its evaluation will definitely not get stuck.

- Conservative analysis: make use only of **static** infomation (e.g., $\texttt{if (iszero 0) then 0 else false}$ will get stuck)

### 8.2 The Typing Relation

- $\mathbb{B}$ (typed)
  - New syntactic forms: $\texttt{T} ::= \texttt{Bool}$.
  - New typing rules for booleans
    - $\texttt{true : Bool}$        (T-TRUE)
    - $\texttt{false : Bool}$        (T-FALSE)
    - $\dfrac{\texttt{t}_1\texttt{ : Bool}\qquad\texttt{t}_2\texttt{ : T}\qquad\texttt{t}_3\texttt{ : T}}{\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\texttt{ : T}}$        (T-IF)

- $\mathbb{B}\ \mathbb{N}$ (typed)
  - New syntactic forms: $\texttt{T}::=\texttt{Nat}$.
  - New Typing rules for numbers
    - $\texttt{0 : Nat}$        (T-SUCC)
    - $\dfrac{\texttt{t}_1\texttt{ : Nat}}{\texttt{succ t}_1\texttt{ : Nat}}$        (T-SUCC)
    - $\dfrac{\texttt{t}_1\texttt{ : Nat}}{\texttt{pred t}_1\texttt{ : Nat}}$        (T-PRED)
    - $\dfrac{\texttt{t}_1\texttt{ : Nat}}{\texttt{iszero t}_1\texttt{ : Bool}}$        (T-ISZERO)

- The **typing relation** for arithmetic expressions is the smallest binary relation between terms and types satisfying all instances of the rules above. A term $\texttt{t}$ is *typable* if there is some $\texttt{T}$ such that $\texttt{t : T}$.
- LEMMA (Inversion of the typing relation)
  1. If $\texttt{true : R}$, then $\texttt{R = Bool}$.
  2. If $\texttt{false : R}$, then $\texttt{R = Bool}$.
  3. If $\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\texttt{ : R}$, then $\texttt{t}_1\texttt{ : Bool}$, $\texttt{t}_2\texttt{ : R}$, and $\texttt{t}_3\texttt{ : R}$.
  4. If $\texttt{0 : R}$, then $\texttt{R = Nat}$.
  5. If $\texttt{succ t}_1\texttt{ : R}$, then $\texttt{R = Nat}$ and $\texttt{t}_1\texttt{ : Nat}$.
  6. If $\texttt{pred t}_1\texttt{ : R}$, then $\texttt{R = Nat}$ and $\texttt{t}_1\texttt{ : Nat}$.
  7. If $\texttt{iszero t}_1\texttt{ : R}$, then $\texttt{R = Bool}$ and $\texttt{t}_1\texttt{ : Nat}$.

- **Derivations**: deductions based on typing rules.
- **Uniqueness** of types: Each term $\texttt{t}$ has at most one type.

### 8.3 Safety = Progress + Preservation

- **Progress**: A well-typed term is not stuck (either it is a value or it can take a step according to the evaluation rules). Formally, suppose $\texttt{t}$ is a well-typed term (that is, $\texttt{t : T}$ for some $\texttt{T}$), then $\texttt{t}$ is a value or else there is some $\texttt{t}'$ with $\texttt{t}\to\texttt{t}'$.
- **Preservation**: If a well-typed term takes a step of evaluation, then the resulting term is also well typed. Formally, if $\texttt{t : T}$ and $\texttt{t}\to\texttt{t}'$, then $\texttt{t}'\texttt{ : T}$.
- LEMMA (Canonical forms)
  - If $\texttt{v}$ is a value of type $\texttt{Bool}$, then $\texttt{v}$ is either $\texttt{true}$ or $\texttt{false}$.
  - If $\texttt{v}$ is a value of type $\texttt{Nat}$, then $\texttt{v}$ is a numeric value according to the grammar in Figure 3-2.

## Chapter 9: Simply Typed Lambda-Calculus

### 9.1 Function Types

```
T ::=             // types:
      Bool        // type of booleans
      T->T        // type of functions
```

### 9.2 The Typing Relation

#### Syntax

```
t ::=             // terms:
      x           // variable
      λx:T.t      // abstraction
      t t         // application
v ::=             // values:
      λx:T.t      // abstraction value
T ::=             // types:
      T->T        // type of functions
Γ ::=             // contexts:
      ∅           // empty context
      Γ,x:T       // term variable binding
```

#### Evaluation

- $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{t}_2\to\texttt{t}_1'\texttt{t}_2}$        (E-APP1)
- $\dfrac{\texttt{t}_2\to\texttt{t}_2'}{\texttt{v}_1\texttt{t}_2\to\texttt{v}_1\texttt{t}_2'}$        (E-APP2)
- $\texttt{(}\lambda\texttt{x:T}_{11}\texttt{.t}_{12}\texttt{)v}_2\to\texttt{[x}\mapsto\texttt{t}_2\texttt{]t}_{12}$        (E-APPABS)

#### Typing rules

- $\dfrac{\Gamma\texttt{,x:T}_1\vdash\texttt{t}_2\texttt{:T}_2}{\Gamma\vdash\lambda\texttt{x:T}_1\texttt{.t}_2\texttt{:T}_1\to\texttt{T}_2}$        (T-ABS)
- $\dfrac{\texttt{x:T}\in\Gamma}{\Gamma\vdash\texttt{x:T}}$        (T-VAR)
- $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_{11}\to\texttt{T}_{12}\qquad\Gamma\vdash\texttt{t}_2\texttt{:T}_{11}}{\Gamma\vdash\texttt{t}_1\texttt{t}_2\texttt{:T}_{12}}$        (T-APP)
- $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:Bool}\qquad\Gamma\vdash\texttt{t}_2\texttt{:T}\qquad\Gamma\vdash\texttt{t}_3\texttt{:T}}{\Gamma\vdash\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\texttt{ : T}}$        (T-IF)

### 9.3 Properties of Typing

- Inversion lemma & uniqueness of types
- LEMMA (Canonical forms)
  - If $\texttt{v}$ is a value of type $\texttt{Bool}$, then $\texttt{v}$ is either $\texttt{true}$ or $\texttt{false}$.
  - If $\texttt{v}$ is a value of type $\texttt{T}_1\to\texttt{T}_2$, then $\texttt{v}=\lambda\texttt{x:T}_1\texttt{.t}_2$.
- **Progress**: Suppose $\texttt{t}$ is a closed, well-typed term (that is, $\vdash\texttt{t:T}$ for some $\texttt{T}$). Then either $\texttt{t}$ is a value or else there is some $\texttt{t}'$ with $\texttt{t}\to\texttt{t}'$.
- **Preservation**: If $\Gamma\vdash\texttt{t:T}$ and $\texttt{t}\to\texttt{t}'$, then $\Gamma\vdash\texttt{t}'\texttt{:T}$.

### 9.4 The Curry-Howard Correspondence

- **Introduction rule** (T-ABS): how elements of the type can be *created*
- **Elimination rule** (T-APP): how elements of the type can be *used*

Introduction/elimination terminology arised from a connection between **type theory** and **logic** known as the **Curry-Howard correspondence**.

| LOGIC                       | PL                                            |
| --------------------------- | --------------------------------------------- |
| propositions                | types                                         |
| proposition $P\supset Q$    | type $\texttt{P}\to\texttt{Q}$                |
| proposition $P\wedge Q$     | type $\texttt{P}\times\texttt{Q}$             |
| proof of proposition $P$    | term $\texttt{t}$ of type $\texttt{P}$        |
| proposition $P$ is provable | type $\texttt{P}$ is inhabited (by some term) |

### 9.5 Erasure and Typability

> In effect, programs are converted back to an untyped form before they are evaluated. This style of semantics can be formalized using an erasure function mapping simply typed terms into the corresponding untyped terms.

- **Erasure** (a function mapping simply typed terms into the corresponding untyped terms)
  - $\mathit{erase}(\texttt{x})=\texttt{x}$
  - $\mathit{erase}(\lambda\texttt{x:T}_1\texttt{.t}_2)=\lambda\texttt{x.}\mathit{erase}(\texttt{t}_2)$
  - $\mathit{erase}(\texttt{t}_1\texttt{t}_2)=\mathit{erase}(\texttt{t}_1)\mathit{erase}(\texttt{t}_2)$
- Theorem:
  1. If $\texttt{t}\to\texttt{t}'$ under the typed evaluation relation, then $\mathit{erase}(\texttt{t})\to\mathit{erase}(\texttt{t}')$.
  2. If $\mathit{erase}(\texttt{t})\to\texttt{m}'$ under the typed evaluation relation, then there is a simply typed term $\texttt{t}'$ such that $\texttt{t}\to\texttt{t}'$ and $\mathit{erase}(\texttt{t}')=\texttt{m}'$.

- A term $\texttt{m}$ in the untyped lambda-calculus is said to be **typable** in $\lambda_\to$ if there are simply typed term $\texttt{t}$, type $\texttt{T}$, and context $\Gamma$ such that $\mathit{erase}(\texttt{t})=\texttt{m}$ and $\Gamma\vdash\texttt{t:T}$.

### 9.6 Curry-Style vs. Church-Style

- **Curry-style**: define the terms $\rightarrow$ define a semantics $\to$ give a type system (reject some terms)

  > Semantics is prior to typing.

  - for implicitly typed presentations

- **Church-style**: define the terms $\to$ identify the well-typed terms $\to$ give semantics

  > Typing is prior to semantics. Never ask the question "what is the behavior of an ill-typed term?"

  - for explicitly typed presentations

## Chapter 11: Simple Extensions

### 11.1 Base Types

`Bool, Nat, Float, String`

We use $\texttt{A},\texttt{B},\texttt{C}$ as the names of base types.

### 11.2 The Unit Type

- **Syntax**: term $\texttt{unit}$, constant value $unit$ (the only possible value), type $unit$.
- **Typing rule**: $\Gamma\vdash\texttt{unit}:\texttt{Unit}$        (T-UNIT)

### 11.3 Derived Forms: Sequencing and Wildcards

- One way to formalize sequencing (same as above)
  - **Evaluation rules**
    - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1;\texttt{t}_2\to\texttt{t}_1';\texttt{t}_2}$        (E-SEQ)
    - $\texttt{unit};\texttt{t}_2\to\texttt{t}_2$        (E-SEQNEXT)
  - **Typing rule**
    - $\dfrac{\Gamma\vdash\texttt{t}_1:\texttt{Unit}\quad \Gamma\vdash\texttt{t}_2:\texttt{T}_2}{\Gamma\vdash\texttt{t}_1;\texttt{t}_2:\texttt{T}_2}$        (T-SEQ)

- Another way (regard $\texttt{t}_1;\texttt{t}_2$ as $(\lambda\texttt{x}:\texttt{Unit.t}_2)\texttt{t}_1$, $x\notin FV(\texttt{t}_2)$)

- Derived forms are often called *syntactic sugar*.
- **Wildcard**: write $\lambda\_:\texttt{S.t}$ to abbreviate $\lambda\texttt{x}:\texttt{S.t}$., where $\texttt{x}$ is some variable not occuring in $\texttt{t}$.

### 11.4 Ascription

- "$\texttt{t as T}$" for "the term $\texttt{t}$, to which we ascribe the type $\texttt{T}$"
- **Syntax**: $\texttt{t}::=\texttt{t as T}$
- **Evaluation rules**
  - $\texttt{v}_1\texttt{ as T}\to\texttt{v}_1$        (E-ASCRIBE) just throws away the ascription.
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{ as T}\to\texttt{t}_1'\texttt{ as T}}$        (E-ASCRIBE1)
- **Typing rules**
  - $\dfrac{\Gamma\vdash\texttt{t}_1:\texttt{T}}{\Gamma\vdash\texttt{t}_1\texttt{ as T : T}}$        (T-ASCRIBE)

- Applications: documentation, printing, abstraction.

### 11.5 Let Bindings

- **Syntax**: $\texttt{t}::=\texttt{let x=t in t}$
- **Evaluation rule**
  - $\texttt{let x=v}_1\texttt{ in t}_2\to\texttt{[x}\mapsto\texttt{v}_1\texttt{]t}_2$        (E-LETV)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{let x=t}_1\texttt{ in t}_2\mapsto\texttt{let x=t}_1'\texttt{ in t}_2}$        (E-LET)
- **Typing rule**
  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_1\quad\Gamma,\texttt{x:T}_1\vdash\texttt{t}_2\texttt{:T}_2}{\Gamma\vdash\texttt{let x=t}_1\texttt{ in t}_2\texttt{:T}_2}$        (T-LET)
- Derived form: $\texttt{let x=t}_1\texttt{ in t}_2\stackrel{\mathrm{def}}{=}(\lambda\texttt{x:T}_1\texttt{.t}_2))\texttt{t}_1$ (Here, $\texttt{T}_1$ comes from the typechecker)

### 11.6 Pairs

- **Syntax**

  ```
  t ::= ...        // terms:
        {t,t}      // pair
        t.1        // first projection
        t.2        // second projection
  v ::= ...        // values:
        {v,v}      // pair value
  T ::= ...        // types:
        T1×T2      // product type
  ```

- **Evaluation rules**

  - $\texttt{\{v}_1\texttt{,v}_2\texttt{\}.1}\to\texttt{v}_1$        (E-PAIRBETA1)
  - $\texttt{\{v}_1\texttt{,v}_2\texttt{\}.2}\to\texttt{v}_2$        (E-PAIRBETA2)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{.1}\to\texttt{t}_1'\texttt{.1}}$        (E-PROJ1)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{.2}\to\texttt{t}_1'\texttt{.2}}$        (E-PROJ2)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{\{t}_1\texttt{,t}_2\texttt{\}}\to\texttt{\{t}_1'\texttt{,t}_2\texttt{\}}}$       (E-PAIR1) 
  - $\dfrac{\texttt{t}_2\to\texttt{t}_2'}{\texttt{\{v}_1\texttt{,t}_2\texttt{\}}\to\texttt{\{v}_1\texttt{,t}_2'\texttt{\}}}$       (E-PAIR2) 

- **Typing rules**

  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_1\quad\Gamma\vdash\texttt{t}_2\texttt{:T}_2}{\Gamma\vdash\texttt{\{t}_1\texttt{,t}_2\texttt{\}:T}_1\times\texttt{T}_2}$        (T-PAIR)
  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_{11}\times\texttt{T}_{12}}{\Gamma\vdash\texttt{t}_1\texttt{.1:T}_{11}}$        (T-PROJ1)
  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_{11}\times\texttt{T}_{12}}{\Gamma\vdash\texttt{t}_1\texttt{.2:T}_{12}}$        (T-PROJ2)

### 11.7 Tuples

- **Syntax**
  - $\texttt{t}::=\dots\mid\texttt{\{t}_i^{i\in1\dots n}\texttt{\}}\mid\texttt{t.i}$        (tuple | projection)
  - $\texttt{v}::=\cdots\mid\texttt{\{v}_i^{i\in1\dots n}\texttt{\}}$        (tuple value)
  - $\texttt{T}::=\cdots\mid\texttt{\{T}_i^{i\in1\dots n}\texttt{\}}$        (tuple type)

- **Evaluation rules**
  - $\texttt{\{v}_i^{i\in1\dots n}\texttt{\}.j}\to\texttt{v}_j$        (E-PROJTUPLE)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{.i}\to\texttt{t}_1'\texttt{.i}}$        (E-PROJ)
  - $\dfrac{\texttt{t}_j\to\texttt{t}_j'}{\texttt{\{v}_i^{i\in1\dots j-1}\texttt{,t}_j\texttt{,t}_k^{k\in j+1\dots n}\texttt{\}}\to\texttt{\{v}_i^{i\in1\dots j-1}\texttt{,t}_j'\texttt{,t}_k^{k\in j+1\dots n}\texttt{\}}}$   
- **Typing rules**
  - $\dfrac{\textrm{for each }i\quad \Gamma\vdash\texttt{t}_i\texttt{:T}_i}{\Gamma\vdash\texttt{\{t}_i^{i\in 1\dots n}\texttt{\}:\{T}_i^{i\in 1\dots n}\texttt{\}}}$        (T-TUPLE)
  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:\{T}_i^{i\in 1\dots n}\texttt{\}}}{\Gamma\vdash\texttt{t}_1\texttt{.j:T}_j}$        (T-PROJ)

### 11.8 Records

- **Syntax**
  - $\texttt{t}::=\cdots\mid\texttt{\{l}_i\texttt{=t}_i^{i\in1\dots n}\texttt{\}}\mid\texttt{t.l}$        (record | projection)
  - $\texttt{v}::=\cdots\mid\texttt{\{l}_i\texttt{=v}_i^{i\in1\dots n}\texttt{\}}$        (record value)
  - $\texttt{T}::=\cdots\mid\texttt{\{l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{\}}$        (type of records)
- **Evaluation rules**
  - $\texttt{\{l}_i\texttt{=v}_i^{i\in 1\dots n}\texttt{\}}\texttt{.l}_j\to\texttt{v}_j$        (E-PROJRCD)
  - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{.l}\to\texttt{t}_1'\texttt{.l}}$        (E-PROJ)
  - $\dfrac{\texttt{t}_j\to\texttt{t}_j'}{\texttt{\{l}_i\texttt{=v}_i^{i\in 1\dots j-1}\texttt{,l}_j\texttt{=t}_j\texttt{,l}_k\texttt{=t}_k^{k\in j+1\dots n}\texttt{\}}\to\texttt{\{l}_i\texttt{=v}_i^{i\in 1\dots j-1}\texttt{,l}_j\texttt{=t}_j'\texttt{,l}_k\texttt{=t}_k^{k\in j+1\dots n}\texttt{\}}}$        (E-RCD)
- **Typing rules**
  - $\dfrac{\textrm{for each }i\quad \Gamma\vdash\texttt{t}_i\texttt{:T}_i}{\Gamma\vdash\texttt{\{l}_i\texttt{=t}_i^{i\in 1\dots n}\texttt{\}:\{l}_i\texttt{:T}_i^{i\in 1\dots n}\texttt{\}}}$        (T-RCD)
  - $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:\{l}_i\texttt{:T}_i^{i\in 1\dots n}\texttt{\}}}{\Gamma\vdash\texttt{t}_1\texttt{.l}_j\texttt{:T}_j}$        (T-PROJ)
- **extension: record patterns** (omitted)

### 11.9 Sums

