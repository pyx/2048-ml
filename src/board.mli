(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Board.

    Represents game board.
 *)

type t
(** Abstract type of game board. *)

val init : int -> int -> t
(** [init x y] creates a new game board with grid of size [x] by [y]. *)

val grid : t -> Grid.t
(** [grid b] returns the grid associated with game board [b]. *)

val count : t -> int
(** [count b] returns move count played so far on game board [b]. *)

val score : t -> int
(** [score b] returns the scoreof game board [b] so far . *)

val move_left : t -> t
(** [move_left b] moves [b] left and returns a new board as result. *)

val move_right : t -> t
(** [move_left b] moves [b] left and returns a new board as result. *)

val move_up : t -> t
(** [move_left b] moves [b] left and returns a new board as result. *)

val move_down : t -> t
(** [move_left b] moves [b] left and returns a new board as result. *)

val spawn : t -> t
(** [spawn b] returns a new board with an element randomly added on [b]. *)
