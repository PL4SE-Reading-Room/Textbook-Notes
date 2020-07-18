## Chapter 3: Untyped Arithmetic Expressions

### 3.1 Introduction

```
t ::=                             // terms:
      true                        // constant true
      false                       // constant false
      if t then t else t          // conditional
      0                           // constant zero
      succ t                      // successor
      pred t                      // predecessor
      iszero t                    // zero test
```

### 3.2 Syntax

- **Inductive definition**: The set of *terms​* is the **smallest** set $\mathcal{T}$ such that
  1. $\{\texttt{true},\texttt{false},\texttt{0}\subseteq\mathcal{T}\};$
  2. if $t_1\in\mathcal{T}$, then $\{\texttt{succ t}_1,\texttt{pred t}_1,\texttt{iszero t}_1\}\subseteq\mathcal{T};$
  3. if $t_1\in\mathcal{T}$, $t_2\in\mathcal{T}$, and $t_3\in\mathcal{T}$, then $\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\in\mathcal{T}$.

- **Inference rules**: The set of *terms* is defined by the following rules:
  - $\texttt{true}\in\mathcal{T}\qquad \texttt{false}\in\mathcal{T}\qquad 0\in\mathcal{T}$
  - $\dfrac{\texttt{t}_1\in\mathcal{T}}{\texttt{succ t}_1\in\mathcal{T}}\qquad \dfrac{\texttt{t}_1\in\mathcal{T}}{\texttt{pred t}_1\in\mathcal{T}}\qquad\dfrac{\texttt{t}_1\in\mathcal{T}}{\texttt{iszero t}_1\in\mathcal{T}}$
  - $\dfrac{\texttt{t}_1\in\mathcal{T}\qquad \texttt{t}_2\in\mathcal{T}\qquad \texttt{t}_3\in\mathcal{T}}{\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\in\mathcal{T}}$

- **Concretely**: For each natural number $i$, define a set $S_i$ as follows:

  - $S_0 = \emptyset$
  - $S_{i+1}=\{\texttt{true},\texttt{false},\texttt{0}\}\\\cup\{\texttt{succ t}_1,\texttt{pred t}_1,\texttt{iszero t}_1\mid \texttt{t}_1\in S_i\}\\\cup\{\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\mid\texttt{t}_1,\texttt{t}_2,\texttt{t}_3\in S_i\}$

  - Finally, let $S = \bigcup\limits_{i}S_i$.

### 3.3 Induction on Terms

- 可以对terms的函数做归纳定义（如$Consts(t)$、$size(t)$），也可以对terms的性质做归纳证明（如$|Consts(t)|\le size(t)$，用**结构归纳法**证明）

### 3.4 Semantic Styles

**How terms are evaluated?**

1. **Operational semantics**: define a simple abstract machine (state & transition function)
2. **Denotational semantics**: more abstract, use mathematical objects. Find a collection of *semantic domains* and then define an *interpretation function* mapping items into elements of these domains.
3. **Axiomatic semantics**: take the laws *themselves* as the definition of the language.

## 3.5 Evaluation

- Just boolean expressions:

  - Syntax

    ```
    t ::= 										// terms:
          true								// constant true
          false								// constant false
          if t then t else t	// conditional
    v ::= 										// values:
          true								// true value
          false								// false value
    ```

  -  $\texttt{t}\to\texttt{t}'$ (operational semantics)

    - $\texttt{if true then t}_2\texttt{ else t}_3\to\texttt{t}_2$    (E-IFTRUE)
    - $\texttt{if false then t}_2\texttt{ else t}_3\to\texttt{t}_3$    (E-IFFALSE)
    - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{if t}_1\texttt{ then t}_2\texttt{ else t}_3\to\texttt{if t}_1'\texttt{ then t}_2\texttt{ else t}_3}$    (E-IF)

- An *instance*（实例） of an interface rule is obtained by consistently replacing each metavariable by the same term in the rule's conclusion and all its premises (if any).
- The *one-step evaluation relation* $\to$ is the smallest binary relation on terms satisfying  the three rules. When the pair $(\texttt{t},\texttt{t}')$ is in the evaluation relation, we say that "the evaluation *statement* (or *judgment*) $\texttt{t}\to\texttt{t}'$ is derivable."

- **Determinacy** of one-step evaluation: if $\texttt{t}\to\texttt{t}'$ and $\texttt{t}\to\texttt{t}''$, then $\texttt{t}'=\texttt{t}''$.
- A term $\texttt{t}$ is in **normal form** if no evaluation rule applies to it (i.e., no $\texttt{t}'$ such that $\texttt{t}\to\texttt{t}'$). Every value is in normal form. *Every term in normal form is a value*.
- The *multi-step evaluation* relation $\to^*$ is the reflexive, transitive closure of one-step evaluation (i.e., the smallest relation such that (1) if $\texttt{t}\to\texttt{t}'$ then $\texttt{t}\to^*\texttt{t}'$, (2) $\texttt{t}\to^*\texttt{t}$ for all $\texttt{t}$, and (3) if $\texttt{t}\to^*\texttt{t}'$ and $\texttt{t}'\to^*\texttt{t}''$, then $\texttt{t}\to^*\texttt{t}''$).
- **Uniqueness** of normal forms: If $\texttt{t}\to^*\texttt{u}$ and $\texttt{t}\to^*\texttt{u}'$, where $\texttt{u}$ and $\texttt{u}'$ are both normal forms, then $\texttt{u}=\texttt{u}'$.
- **Termination** of evaluation: For every term $\texttt{t}$ there is some normal form $\texttt{t}'$ such that $\texttt{t}\to^*\texttt{t}'$.

- Arithmetic expressions:

  - Syntax

    ```
    t ::= 								// terms:
          0								// constant zero
          succ t					// successor
          pred t					// predecessor
          iszero t				// zero test
    v ::=									// values:
          nv							// numeric value
    nv ::=								// numeric values:
          0								// zero value
          succ nv					// succesor value
    ```

  - Operational semantics (evaluation rules)

    - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{succ t}_1\to\texttt{succ t}_1'}$    (E-SUCC)    $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{pred t}_1\to\texttt{pred t}_1'}$ (E-PRED)
    - $\texttt{pred 0}\to\texttt{0}$ (E-PREDZERO)    $\texttt{pred (succ nv}_1\texttt{)}\to\texttt{nv}_1$ (E-PREDSUCC)
    - $\texttt{iszero 0}\to\texttt{true}$ (E-ISZEROZERO)
    - $\texttt{iszero (succ nv}_1\texttt{)}\to\texttt{false}$ (E-ISZEROSUCC)
    - $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{iszero t}_1\to\texttt{iszero t}_1'}$ (E-ISZERO)

- A closed term is **stuck** if it is in normal form but not a value. (*run-time error*)

## Chapter 4: An ML Implementation of Arithmetic Expressions

see `code/Chapter 4.ml`.

## Chapter 5: The Untyped Lambda-Calculus

### 5.1 Basics

```
t ::= 										// terms:
      x										// variable
      λx.t								// abstraction
      t t									// application
```

- Two conventions when writing lambda-terms in linear form
  - Application associates to the **left**. (e.g., `s t u` stands for the same tree as `(s t) u`)
  - The bodies of abstraction are taken to extend **as far to the right** as possible. (e.g., `λ x. λy. x y x` stands for the same tree as `λx. (λy. ((x y) x))`)

- An occureence of the variable `x` is said to be *bound* when it occurs in the body `t` of an abstraction `λx. t`. (*free* otherwise) A term with no free variables is said to be *closed*; closed terms are also called *combinators*. (Simplest combinator: *identity function* `id = λx.x`)
- Operational semantics
  - Application: $\texttt{(}\lambda\texttt{x.t}_{12}\texttt{)t}_2\to\texttt{[x}\mapsto\texttt{t}_2\texttt{]t}_{12}$  replace all **free** occurences of $\texttt{x}$ in $\texttt{t}_{12}$ by $\texttt{t}_{2}$. (called *beta-reduction*)
  - Strategies
    - **Full beta-reduction**: any redex may be reduced at any time, begin with the *innermost* rededex.
    - **Normal order**: The *leftmost, outermost* redex is always reduced first.
    - **Call by name**: Allow no reductions inside abstractions. Starting from the same term, we would perform the first two reductions as under *normal-order*, but *stop* before the last.
    - **Call by value**: Only *outermost* redexes are reduced and where a redex is reduced only when its *right-hand* side has already been reduced to a *value* (a term that cannot be reduced any further). [**used by most languages**]

### 5.2 Programming in the Lambda-Calculus

- Examples

  - **Multiple Arguments**: $\texttt{f}=\lambda\texttt{x.}\lambda\texttt{y.s}$. $\texttt{f v w}=\texttt{((}\lambda\texttt{y.[x}\mapsto\texttt{v]s)w))}=\texttt{[y}\mapsto\texttt{w][x}\mapsto\texttt{v]s}$.

  - **Church Booleans**

    - $\texttt{tru}=\lambda\texttt{t.}\lambda\texttt{f.t}$
    - $\texttt{fls}=\lambda\texttt{t.}\lambda\texttt{f.f}$
    - $\texttt{test}=\lambda\texttt{l.}\lambda\texttt{m.}\lambda\texttt{n. l m n}$. e.g, $\texttt{test tru v w = v}$
    - $\texttt{and}=\lambda\texttt{b.}\lambda\texttt{c. b c fls}$.

  - **Pairs**

    - $\texttt{pair}=\lambda\texttt{t.}\lambda\texttt{s.}\lambda\texttt{b. b f s}$
    - $\texttt{fst}=\lambda\texttt{p. p tru}$
    - $\texttt{snd}=\lambda\texttt{p. p fls}$
    - e.g., $\texttt{fst (pair v w) = v}$

  - **Church Numerals**

    - $\texttt{c}_0=\lambda\texttt{s.}\lambda\texttt{z. z}\quad\texttt{c}_1=\lambda\texttt{s.}\lambda\texttt{z. s z}\quad\texttt{c}_2=\lambda\texttt{s.}\lambda\texttt{z. s (s z)}$, ...
    - $\texttt{scc}=\lambda\texttt{n.}\lambda\texttt{s.}\lambda\texttt{z. s (n s z)}$.
    - $\texttt{plus}=\lambda\texttt{m.}\lambda\texttt{n.}\lambda\texttt{s.}\lambda\texttt{z. m s (n s z)}$
    - $\texttt{times}=\lambda\texttt{m.}\lambda\texttt{n. m (plus n) c}_0$
    - $\texttt{iszro}=\lambda\texttt{m. m (}\lambda\texttt{x. fls) tru}$. e.g., $\texttt{iszro c}_1=\texttt{fls}$, $\texttt{iszro (times c}_0\texttt{ c}_2\texttt{)}=\texttt{tru}$.
    - Subtraction is a bit more difficult, which can be done by "predecessor function". $\texttt{zz}=\texttt{pair c}_0\texttt{ c}_0\qquad\texttt{ss}=\lambda\texttt{p. pair (snd p) (plus c}_1\texttt{ (snd p))}$$\texttt{prd}=\lambda\texttt{m. fst (m ss zz)}$. In which, $\texttt{m ss zz}$ yields $\texttt{pair c}_0\texttt{ c}_0$ when $\texttt{m}=0$ and $\texttt{pair c}_{m-1}\texttt{c}_m$ when $\texttt{m}$ is positive.

  - **Enriching the Calculus**

    - $\texttt{realbool}=\lambda\texttt{b. b true false}$ (church boolean $\to$ primitive boolean)
    - $\texttt{churchbool} = \lambda\texttt{b. if b then tru else fls}$ (primitive boolean $\to$ church boolean)
    - $\texttt{realeq}=\lambda\texttt{m. }\lambda\texttt{n. (equal m n) true false}$ (2 church numerals $\to$ real boolean)
    - $\texttt{realnat}=\lambda\texttt{m. m (}\lambda\texttt{x. succ x) 0}$ (church numeral $\to$ primitive number)

  - **Recursion**

    - Some terms cannot be evaluated to a normal form (e.g., the *divergent* combinator $\texttt{omega}=\texttt{(}\lambda\texttt{x. x x)} \texttt{(}\lambda\texttt{x. x x)}$). Terms with no normal are said to be **diverge**.

    - **fixed-point combinator**: $\texttt{fix}=\lambda\texttt{f. (}\lambda\texttt{x. f (}\lambda\texttt{y. x x y))}\texttt{ (}\lambda\texttt{x. f (}\lambda\texttt{y. x x y))}$ 

      e.g., if we define R$\texttt{g}=\lambda\texttt{fct. }\lambda\texttt{n. if realeq n c}_0\texttt{ then c}_1\texttt{ else (times n (fct (prd n)))}$ , then $\texttt{factorial c}_3=\texttt{fix g c}_3=\dots=\texttt{c}_6'$, where $\texttt{c}_6'$ is behaviorally equivalent to $\texttt{c}_6$.

  - **Representation**: there is no observable difference between the real numbers and their Church-numeral representation.

### 5.3 Formalities

#### Syntax

- **Terms**: Let $\mathcal{V}$ be a countable set of variable names. The set of terms is the smallest set $\mathcal{T}$ such that
  1. $\texttt{x}\in\mathcal{T}$ for every $\texttt{x}\in\mathcal{V}$;
  2. if $\texttt{t}_1\in\mathcal{T}$ and $\texttt{x}\in\mathcal{V}$, then $\lambda\texttt{x.t}_1\in\mathcal{T}$;
  3. if $\texttt{t}_1\in\mathcal{T}$ and $\texttt{t}_2\in\mathcal{T}$, then $\texttt{t}_1\texttt{t}_2\in\mathcal{T}$.

#### Substitution

- Definition
  - $\texttt{[x}\mapsto\texttt{s]x}=\texttt{s}$
  - $\texttt{[x}\mapsto\texttt{s]y}=\texttt{y}\qquad \mathrm{if}\ \texttt{x}\neq\texttt{y}$
  - $\texttt{[x}\mapsto\texttt{s](}\lambda\texttt{y.t}_1\texttt{)}=\lambda\texttt{y.[x}\mapsto\texttt{s]t}_1\qquad\mathrm{if}\ \texttt{y}\neq\texttt{x}\ \mathrm{and}\ \texttt{y}\notin FV(\texttt{s})$
  - $\texttt{[x}\mapsto\texttt{s](t}_1\texttt{t}_2\texttt{)}=\texttt{([x}\mapsto\texttt{s]t}_1\texttt{)([x}\mapsto\texttt{s]t}_2\texttt{)}$
- Convention: Terms that differ only in the names of bound variables are interchangeable in all contexts.

#### Operational Semantics

```
t ::= 								// terms:
      x								// variable
      λx.t						// abstraction
      t t							// application
v ::=									// values:
      λx.t						// abstraction value
```

- $\dfrac{\texttt{t}_1\to\texttt{t}_1'}{\texttt{t}_1\texttt{t}_2\to\texttt{t}_1'\texttt{t}_2}$  (E-APP1)
- $\dfrac{\texttt{t}_2\to\texttt{t}_2'}{\texttt{v}_1\texttt{t}_2\to\texttt{v}_1\texttt{t}_2'}$  (E-APP2)
- $\texttt{(}\lambda\texttt{x.t}_{12}\texttt{)v}_{2}\to\texttt{[x}\mapsto\texttt{v}_2\texttt{]t}_{12}$  (E-APPABS)
- Order of evaluation for an application $\texttt{t}_1\texttt{t}_2$: first E-APP1, then E-APP2, finally E-APPABS.

## Chapter 6: Nameless Representation of Terms

- About renaming bound variables, more ways to choose from:
  - Define an operation that **explicitly** replaces bound variables with "fresh" names
  - Introduce a new convention: names of all bound variables **must all be different** from each other and from any free variables we may use.
  - Devise some "canonical" representation of variables and terms that does not require renaming [*This book's choice*]
  - Introduce mechanisms such as **explicit substitutions**
  - ...

### 6.1 Terms and Contexts

- Bruijn's idea: **make variable occureences point directly to their binders, rather than referring to them by name.** The number $\texttt{k}$ stands for the variable bound by the $k$'th enclosing $\lambda$.
  - e.g., The ordinary term $\lambda\texttt{x.x}$ corresponds to the *nameless term* $\lambda\texttt{.0}$
  - e.g., $\lambda\texttt{x.}\lambda\texttt{y. x (y x)}$ corresponds to $\lambda\texttt{.}\lambda\texttt{. 1 (0 1)}$
- **Terms**: Let $\mathcal{T}$ be the smallest family of sets $\{\mathcal{T}_0,\mathcal{T}_1,\mathcal{T}_2,\dots\}$ such that
  1. $\texttt{k}\in\mathcal{T}_n$ whenever $0\le\texttt{k}<n$
  2. if $\texttt{t}_1\in\mathcal{T}_n$ and $n>0$, then $\lambda\texttt{.t}_1\in\mathcal{T}_{n-1}$
  3. if $\texttt{t}_1\in\mathcal{T}_n$ and $\texttt{t}_2\in\mathcal{T}_n$, then $\texttt{(t}_1\texttt{t}_2\texttt{)}\in\mathcal{T}_n$

### 6.2 Shifting and Substitution

Define a substitution operation $\texttt{([k}\mapsto\texttt{s]t)}$ on nameless terms. **Shifting**: renumber the indices of free variables in a term.

- **Shifting**: The $d$-place shift of a term $\texttt{t}$ above  cutoff $c$ (control which variables be shifted), written $\uparrow_c^d(\texttt{t})$, is defined as follows:
  - $\uparrow_c^d(\texttt{k})=\left\{\begin{aligned}& k & \mathrm{if}\ k < c \\ & k + d & \mathrm{if}\ k\ge c\end{aligned}\right.$
  - $\uparrow_c^d(\lambda\texttt{.t}_1)=\lambda\texttt{.}\uparrow_{c+1}^d(\texttt{t}_1)$
  - $\uparrow_c^d(\texttt{t}_1\texttt{t}_2)=\uparrow_c^d(\texttt{t}_1)\uparrow_c^d(\texttt{t}_2)$
- **Substitution**: The substitution of a term $\texttt{s}$ for variable number $\texttt{j}$ in a term $\texttt{t}$, written $\texttt{[j}\mapsto\texttt{s]t}$, is defined as follows:
  - $\texttt{[j}\mapsto\texttt{s]k}=\left\{\begin{aligned}& \texttt{s} & \mathrm{if}\ \texttt{k}=\texttt{j}\\ & \texttt{k} & \mathrm{otherwise}\end{aligned}\right.$
  - $\texttt{[j}\mapsto\texttt{s](}\lambda\texttt{.t}_1\texttt{)}=\lambda\texttt{.[j}+1\mapsto\uparrow^1\texttt{(s)]t}_1$
  - $\texttt{[j}\mapsto\texttt{s](t}_1\texttt{t}_2\texttt{)}=\texttt{([j}\mapsto\texttt{s]t}_1\texttt{[j}\mapsto\texttt{s]t}_2$

## 6.3 Evaluation

- **E-APPABS**
  - $\texttt{(}\lambda\texttt{.t}_{12}\texttt{)v}_2\to\uparrow^{-1}([\texttt{0}\mapsto\uparrow^1(\texttt{v}_2)]\texttt{t}_{12})$
  - e.g., $\texttt{(}\lambda\texttt{.1 0 2) (}\lambda\texttt{.0)}\rightarrow \texttt{0 (}\lambda\texttt{.0) 1}$

## Chapter 7: An ML Implementation of the Lambda-Calculus

see `code/Chapter 7.ml`.