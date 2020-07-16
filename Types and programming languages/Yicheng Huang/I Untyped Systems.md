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

