valid([]).
valid([Head|Tail]) :-
  fd_all_different(Head),
  valid(Tail).

sudoku(Puzzle, Solution) :-
  Solution = Puzzle,
  Puzzle = [S11,S12,S13,S14,
            S21,S22,S23,S24,
            S31,S32,S33,S34,
            S41,S42,S43,S44],

  fd_domain(Puzzle, 1, 4),

  Row1 = [S11,S12,S13,S14],
  Row2 = [S21,S22,S23,S24],
  Row3 = [S31,S32,S33,S34],
  Row4 = [S41,S42,S43,S44],

  Col1 = [S11,S21,S31,S41],
  Col2 = [S12,S22,S32,S42],
  Col3 = [S13,S23,S33,S43],
  Col4 = [S14,S24,S34,S44],

  SQ1 = [S11,S12,S21,S22],
  SQ2 = [S13,S14,S23,S24],
  SQ3 = [S31,S32,S41,S42],
  SQ4 = [S33,S34,S43,S44],

  valid([Row1,Row2,Row3,Row4,
        Col1,Col2,Col4,Col3,
        SQ1,SQ2,SQ3,SQ4]).