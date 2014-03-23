(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Board.

    Represents game board.
 *)

type elt = int
(** Element of cell. *)

type t
(** Type of game board. *)

val init : int -> int -> t
(** [init x y] creates a new board with size [x] by [y]. *)

val get : int -> int -> t -> elt
(** [get x y b] returns the element at [x], [y] on [b]. *)

val set : int -> int -> elt -> t -> t
(** [set x y e b] returns a copy of [b] with [e] set to [x], [y]. *)

val size : t -> int * int
(** [size b] returns dimension of [b] as tuple [(x, y)]. *)

val to_list : t -> elt list list
(** [to_list b] creates a list of lists of [elt] from [b]. *)

val contains : elt -> t -> bool
(** [contains e b] returns true if [b] contains [e]. *)

val has_empty_cell : t -> bool
(** [has_empty_cell e] returns true if [b] has any empty cell. *)

val empty_cells : t -> (int * int) list
(** [empty_cells b] returns a list of indices of all empty cells on [b]. *)

val move_left : t -> t
(** [move_left b] returns a new board as [b] being moved left. *)

val move_right : t -> t
(** [move_right b] returns a new board as [b] being moved right. *)

val move_up : t -> t
(** [move_up b] returns a new board as [b] being moved up. *)

val move_down : t -> t
(** [move_down b] returns a new board as [b] being moved down. *)

val move_available : t -> bool
(** [move_available b] returns true if any cell on [b] is possible to move *)
