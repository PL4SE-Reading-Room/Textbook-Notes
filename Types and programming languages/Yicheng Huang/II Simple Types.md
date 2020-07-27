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

