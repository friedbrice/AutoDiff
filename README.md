# AutoDiff

Code snippets accompanying the talk "Automatic Differentiation in Haskell."

This "README.md" and the code snippets contained in this repository are copyright (c) 2016 Daniel Brice, under the terms of the GNU GPL Version 3 (included as "LICENSE.txt").

Do not use these code snippets for anything important. Use Kmett's "ad" package, instead.

Pull requests welcomed.

## Tangent Line Problem: A Motivating Example

- Graph y = x^2
- Explain problem, find slope of tangent line at (3, 9)
- Manually approximate, difference quotient

## Numerical Differentiation

- Implement in Haskell
- Point out problems
  - complexity
  - accuracy

## Abstraction to the Rescue

- Think of the expression as an object of study in its own right
- Carry out the algorithm on the expression (not on the numbers)
- arrive at an expression for the derivative

## Automatic Differentiation

See the talk on [YouTube][https://www.youtube.com/watch?v=q1DUKEOUoxA&t=1870s] (I hate listening to recordings of my voice -\_-).

## Acknowledgments

Thanks to Branium for hosting. Thanks to the Santa Monica Haskell User Group for giving me the chance to speak.

Special thanks to Phil Freeman, for noticing that the symbolic differentiation works automatically, without needing to repeat the code in "AutoDiff.hs".

## Further Reading

- Justin Domke: [Automatic Differentiation: The most criminally underused tool in the potential machine learning toolbox?](https://justindomke.wordpress.com/2009/02/17/automatic-differentiation-the-most-criminally-underused-tool-in-the-potential-machine-learning-toolbox/)

- Edward Kmett: [The ad package](https://hackage.haskell.org/package/ad)

- Ben Kovach: [Symbolic Calculus in Haskell](http://5outh.blogspot.com/2013/05/symbolic-calculus-in-haskell.html)

- Alexey Radul: [Introduction to AUTOMATIC DIFFERENTIATION](http://alexey.radul.name/ideas/2013/introduction-to-automatic-differentiation/)

- Chris Taylor: [The Algebra of Algebraic Data Types, Part 3](http://chris-taylor.github.io/blog/2013/02/13/the-algebra-of-algebraic-data-types-part-iii/)

- DB: [Automatic Differentiation is Trivial in Haskell](http://www.danielbrice.net/blog/10/)

- DB: [AutoDiff](https://github.com/friedbrice/AutoDiff)
