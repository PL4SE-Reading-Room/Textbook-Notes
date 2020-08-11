## Chapter 15: Subtyping

### 15.1 Subsumption

- Motivating example: `(λr:{x:Nat}. r.x) {x=0,y=1}` not typable in simply typed lambda-calculus. But it's always safe to pass an argument of type `{x:Nat,y:Nat}​` to a function that expects type `{x:Nat}`.
- `S` is a subtype of `T` (i.e., `S<:T`), if any term of type `S` can safely be used in a context where a term of type `T` is expected.
  - the elements of `S` are a subset of the elements of `T`. (subset semantics)
- **Rule of subsumption**
  - $\dfrac{\Gamma\vdash\texttt{t:S}\quad\texttt{S}<:\texttt{T}}{\Gamma\vdash\texttt{t:T}}$        (T-SUB)

### 15.2 The Subtype Relation

- **Reflexive**: $\texttt{S}<:\texttt{S}$        (S-REFL)
- **Transitive**: $\dfrac{\texttt{S}<:\texttt{U}\quad\texttt{U}<:\texttt{T}}{\texttt{S}<:\texttt{T}}$        (S-TRANS)
- Width subtyping rule: $\texttt{\{l}_i\texttt{:T}_i^{i\in 1\dots n+k}\texttt{\}}<:\texttt{\{l}_i\texttt{:T}_i^{i\in 1\dots n}\texttt{\}}$        (S-RCDWIDTH)
- Depth subtyping rule: $\dfrac{\textrm{for each }i\quad\texttt{S}_i<:\texttt{T}_i}{\{\texttt{l}_i\texttt{:S}_i^{i\in1\dots n}\texttt{\}}<:\{\texttt{l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{\}}}$        (S-RCDDEPTH)
- $\dfrac{\texttt{\{k}_j\texttt{:S}_j^{j\in 1\dots n}\texttt{\}}\textrm{ is a permutation of }\texttt{\{l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{\}}}{\texttt{\{k}_j\texttt{:S}_j^{j\in 1\dots n}\texttt{\}}<: \texttt{\{l}_i\texttt{:T}_i^{i\in 1\dots n}\texttt{\}}}$        (S-RCDPERM)
- $\dfrac{\texttt{T}_1<:\texttt{S}_1\quad \texttt{S}_2<:\texttt{T}_2}{\texttt{S}_1\to\texttt{S}_2<:\texttt{T}_1\to\texttt{T}_2}$        (S-ARROW)
- Supertype of every type: a new type constant $\texttt{Top}$
  - $\texttt{S}<:\texttt{Top}$        (S-TOP)

### 15.3 Properties of Subtyping and Typing

- Lemma [Inversion of the Subtype Relation]
  1. If $\texttt{S}<:\texttt{T}_1\to\texttt{T}_2$, then $\texttt{S}$ has the form $\texttt{S}_1\to\texttt{S}_2$, with $\texttt{T}_1<:\texttt{S}_1$ and $\texttt{S}_2<:\texttt{T}_2$.
  2. If $\texttt{S}<:\texttt{\{l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{\}}$, then $\texttt{S}$ has the form $\texttt{\{k}_j\texttt{:S}_j^{j\in1\dots m}\texttt{\}}$, with at least the labels $\texttt{\{l}_i^{i\in1\dots n}\texttt{\}}$ — i.e., $\texttt{\{l}_i^{i\in1\dots n}\texttt{\}}\subseteq \texttt{\{k}_j^{j\in1\dots m}\texttt{\}}$ — and with $\texttt{S}_j<:\texttt{T}_i$ for each common label $\texttt{l}_i=\texttt{k}_j$.
- Theorem [Preservation]
  - If $\Gamma\vdash\texttt{t:T}$ and $\texttt{t}\to\texttt{t}'$, then $\Gamma\vdash\texttt{t}'\texttt{:T}$.
- Lemma [Canonical Forms]
  1. If $\texttt{v}$ is a closed value of type $\texttt{T}_1\to\texttt{T}_2$, then $\texttt{v}$ has the form $\lambda\texttt{x:S}_1\texttt{.t}_2$.
  2. If $\texttt{v}$ is a closed value of type $\texttt{\{l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{\}}$, then $\texttt{v}$ has the form $\texttt{\{k}_a\texttt{=v}_a^{a\in1\dots m}\texttt{\}}$, with $\texttt{\{l}_i^{i\in1\dots n}\texttt{\}}\subseteq\texttt{\{k}_a^{a\in1\dots m}\texttt{\}}$.
- Theorem [Progress]
  - If $\texttt{t}$ is closed, well-typed term, then either $\texttt{t}$ is a value or else there is some $\texttt{t}'$ with $\texttt{t}\to\texttt{t}'$.

### 15.4 The Top and Bottom Type

- We **can** also complete the subtype relation with a *minimal* element.
  - Syntax: $\texttt{T}::=\texttt{Bot}$
  - Subtyping rules: $\texttt{Bot}<:\texttt{T}$       (S-BOT)
- Though useful, $\texttt{Bot}$ complicates the problem of building a typechecker.

### 15.5 Subtyping and Other Feature

#### Ascription and Casting

- Up-cast: $\dfrac{\Gamma\vdash\texttt{t:S}\quad\texttt{S}<:\texttt{T}}{\Gamma\vdash\texttt{t as T: T}}$
- Down-cast: $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:S}}{\Gamma\vdash\texttt{t}_1\texttt{ as T: T}}$ (T-DOWNCAST, Unsafe), $\dfrac{\vdash\texttt{v}_1\texttt{:T}}{\texttt{v}_1\texttt{ as T}\to\texttt{v}_1}$ (E-DOWNCAST)

#### Variants

- Note: Compare with records!
- **Syntax**: `t ::= ... | <l=t> (no as)`
- **Typing rules**: $\dfrac{\Gamma\vdash\texttt{t}_1\texttt{:T}_1}{\Gamma\vdash\texttt{<l}_1\texttt{=t}_1\texttt{>:<l}_1\texttt{:T}_1\texttt{>}}$        (T-VARIANT)
- **Subtyping rules**
  - $\texttt{<l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{>}<:\texttt{<l}_i\texttt{:T}_i^{i\in1\dots n+k}\texttt{>}$        (S-VariantWidth)
  - $\dfrac{\textrm{for each }i\quad\texttt{S}_i<:\texttt{T}_i}{\texttt{<l}_i\texttt{:S}_i^{i\in1\dots n}\texttt{>}\quad<:\texttt{<l}_i\texttt{:T}_i^{i\in1\dots n}\texttt{>}}$        (S-VariantPerm)

#### Lists

-  Covariant constructor: $\dfrac{\texttt{S}_1<:\texttt{T}_1}{\texttt{List S}_1<:\texttt{List T}_1}$        (S-LIST)

#### References

- Invariant constructor: $\dfrac{\texttt{S}_1<:\texttt{T}\quad\texttt{T}_1<:\texttt{S}_1}{\texttt{Ref S}_1<:\texttt{Ref T}_1}$        (S-REF)
- Restrictive to preserve type safety

#### Arrays

- Invariant constructor: $\dfrac{\texttt{S}_1<:\texttt{T}\quad\texttt{T}_1<:\texttt{S}_1}{\texttt{Array S}_1<:\texttt{Array T}_1}$        (S-ARRAY)
- Operations on arrays include forms of both dereferencing and assignment.

#### References Again

- `Source T`: read values of type `T` from a cell; `Sink T`: write values of type `T` to a cell.
- Typing rules
  - $\dfrac{\Gamma\mid\Sigma\vdash\texttt{t}_1\texttt{:Source T}_{11}}{\Gamma\mid\Sigma\vdash\texttt{!t}_1\texttt{:T}_{11}}$        (T-DEREF)
  - $\dfrac{\Gamma\mid\Sigma\vdash\texttt{t}_1\texttt{:Sink T}_{11}\quad \Gamma\mid\Sigma\vdash\texttt{t}_2\texttt{:T}_{11}}{\Gamma\mid\Sigma\vdash\texttt{t}_1\texttt{:=t}_2\texttt{:Unit}}$        (T-ASSIGN)
- Subtyping rules
  - $\dfrac{\texttt{S}_1<:\texttt{T}_1}{\texttt{Source S}_1<:\texttt{Source T}_1}$        (S-SOURCE)
  - $\dfrac{\texttt{T}_1<:\texttt{S}_1}{\texttt{Sink S}_1<:\texttt{Sink T}_1}$        (S-SINK)
  - $\texttt{Ref T}_1<:\texttt{Source T}_1$        (S-REFSOURCE)
  - $\texttt{Ref T}_1<:\texttt{Sink T}_1$        (S-REFSINK)

#### Base Types

- We can introduce a subtyping axiom $\texttt{Bool}<:\texttt{Nat}$, since in many languages the boolean values $\texttt{true}$ and $\texttt{false}$ are actually represented by the number $\texttt{1}$ and $\texttt{0}$.

### 15.6 Coercion Semantics for Subtyping

#### Problems with the Subset Semantics

- On most real machines, the concrete representations of intergers and floats are entirely different. We can use *tagged* representation for numbers, but it significantly degrades performance.
- When records are combined with subtyping, the presence of the permutation rules foils the technique of "position searching".

#### Coercion Semantics

- Goal: "Compile away" subtyping by replacing it with **run-time** coercions.

- Expressed as a **function** that transforms terms from this language into a **lower-level language without subtyping**.
- Translation function for **types**: just replaces $\texttt{Top}$ with $\texttt{Unit}$.
  - ![](pic1.png)
  - e.g., $[[\texttt{Top}\to\texttt{\{a:Top,b:Top\}}]]=\texttt{Unit}\to\texttt{\{a:Unit,b:Unit\}}$.

- Translation function for **subtyping**
  - Write $\mathcal{C}::\texttt{S}<:\texttt{T}$ to mean "$\mathcal{C}$ is a subtyping derivation tree whose conclusion is $\texttt{S}<:\texttt{T}$"
  - Given a derivation $\mathcal{C}$ for the subtyping statement $\texttt{S}<:\texttt{T}$, generates a coercion $[[\mathcal{C}]]$, which is nothing but a **function** from type $[[\texttt{S}]]$ to type $[[\texttt{T}]]$.
  - ![](pic2.png)

- Translation function for **typing**
  - Write $\mathcal{D}::\Gamma\vdash\texttt{t:T}$ to mean "$\mathcal{D}$ is a typing derivation whose conclusion is $\Gamma\vdash\texttt{t:T}$"
  - If $\mathcal{D}$ is a derivation of the statement $\Gamma\vdash\texttt{t:T}$, then its translation $[[\mathcal{D}]]$ is a target-language term of type $[[\texttt{T}]]$.
  - ![](pic3.png)

- Now we can just evaluate the high-level language with subtyping by typechecking them, using the evaluation relation of this language to obtain their *operational behavior*.

#### Coherence

- A pitfall: promote $\texttt{Bool}$ to $\texttt{Int}$, we can $\texttt{Bool}\Rightarrow\texttt{Float}\Rightarrow\texttt{String}$ or $\texttt{Bool}\Rightarrow\texttt{Int}\Rightarrow\texttt{String}$, but `"1" != "1.000"`. In other words, the choice of how to prove $\vdash\texttt{(}\lambda\texttt{x:String.x)true:String}$ affects the way the translated program behaves.
- Solution: Impose an additional requirement, called *coherence*, on the definition of the translation functions.
  - **Definition: **A translation $[[-]]$ from typing derivations in one language to terms in another is *coherent* if, for every pair of derivations $\mathcal{D}_1$ and $\mathcal{D}_2$ with the same conclusion $\Gamma\vdash\texttt{t:T}$, the translations $[[\mathcal{D}_1]]$ and $[[\mathcal{D}_2]]$ are behaviorally equivalent terms of the target language.
  - Revisit the above example, `floatToString(0.0)="0", floatToString(1.0)="1"`

### 15.7 Intersection and Union Types

- $\texttt{T}_1\wedge\texttt{T}_2$ are terms belonging to *both* $\texttt{S}$ and $\texttt{T}$.
  - $\texttt{T}_1\wedge\texttt{T}_2<:\texttt{T}_1$        (S-INTER1)
  - $\texttt{T}_1\wedge\texttt{T}_2<:\texttt{T}_2$        (S-INTER2)
  - $\dfrac{\texttt{S}<:\texttt{T}_1\quad\texttt{S}<:\texttt{T}_2}{\texttt{S}<:\texttt{T}_1\wedge\texttt{T}_2}$         (S-INTER3)
  - $\texttt{S}\to\texttt{T}_1\wedge\texttt{S}\to\texttt{T}_2<:\texttt{S}\to\texttt{(T}_1\wedge\texttt{T}_2\texttt{)}$        (S-INTER4)