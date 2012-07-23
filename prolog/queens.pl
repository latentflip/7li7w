count(0,[]).
count(Count, [Head|Tail]) :-
  count(TailCount, Tail),
  Count is TailCount + 1.


validQueen(Queen) :-
  (Row,Col) = Queen,
  fd_domain(Row,1,8),
  fd_domain(Col,1,8).

validQueens([]).
validQueens([Head|Tail]) :-
  validQueen(Head),
  validQueens(Tail).


checkRowsCols(Rows,Cols,[]).
checkRowsCols(Rows,Cols,[Head|Tail]) :-
  (Row,Col)=Head,
  append(Rows,[Row],NewRows),
  append(Cols,[Col],NewCols),
  checkRowsCols(NewRows,NewCols,Tail),
  fd_all_different(NewRows),
  fd_all_different(NewCols).

checkRowsCols([Head|Tail]) :-
  (Row,Col)=Head,
  checkRowsCols([Row],[Col],Tail).


checkUniq(Q,[]).
checkUniq(Queen,[Head|Tail]) :-
  Queen \= Head,
  checkUniq(Queen,Tail).

shiftQueen(NewQueen,Queen,Roffset,Coffset) :-
  (R,C) = Queen,
  (NR,NC) = NewQueen,
  NR is R + Roffset,
  NC is C + Coffset.

diagQueen(Queen, R, C,Others) :-
  shiftQueen(NQ,Queen,R,C),
  validQueen(NQ) -> checkUniq(NQ,Others),diagQueen(NQ,R,C,Others) ; true.

checkDiags([]).
checkDiags([Head|Tail]) :-
  diagQueen(Head,1,1,Tail),
  diagQueen(Head,1,-1,Tail),
  diagQueen(Head,-1,1,Tail),
  diagQueen(Head,-1,-1,Tail),
  checkDiags(Tail).

check_board(Queens) :-
  count(8,Queens),
  validQueens(Queens),
  checkRowsCols(Queens),
  checkDiags(Queens).

eight_queens(Queens) :-
  check_board(Queens).
