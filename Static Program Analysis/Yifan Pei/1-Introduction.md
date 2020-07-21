# Chapter 1. Introduction

## 1.1. Applications of Static Program Analysis

- program optimization: optimize compilers
  - e.g. dead code, redundant computation, ...
- program correctness: detect error
  - e.g. null pointer dereference, array access bound, assertion guaranteed, ...
- program development: IDE's features
  - e.g. function call, variable assign, ...

## 1.2. Approximative Answers

- No precise analysis
  - Rice’s theorem: all interesting (non-trivial) questions about the behavior of programs are undecidable.
- approximate analysis
  - conservative / safe: all errors lean to the same side
  - sound: never gives incorrect results (may miss errors)

## 1.3. Undecidability of Program Correctness