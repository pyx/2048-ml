(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Grid.

    Represents grid of game board.
 *)

type elt = int
(** Element of cell. *)

type t
(** Abstract type of grid. *)

val init : int -> int -> t
(** [init x y] creates a new grid with size [x] by [y]. *)

val get : int -> int -> t -> elt
(** [get x y g] returns the element at [x], [y] on grid [g]. *)

val set : int -> int -> elt -> t -> t
(** [set x y e g] returns a copy of grid [g] with [e] set to [x], [y]. *)

val size : t -> int * int
(** [size g] returns dimension of grid [g] as tuple [(x, y)]. *)

val to_list : t -> elt list list
(** [to_list g] creates a list of lists of [elt] from [g]. *)

val contains : elt -> t -> bool
(** [contains e g] returns true if grid [g] contains element [e]. *)

val has_empty_cell : t -> bool
(** [has_empty_cell e] returns true if grid [g] has any empty cell. *)

val empty_cells : t -> (int * int) list
(** [empty_cells g] returns a list of indices of all empty cells on [g]. *)

val move_left : t -> t * elt list list
(** [move_left g] returns tuple (grid, remved) as [g] being moved left. *)

val move_right : t -> t * elt list list
(** [move_right g] returns tuple (grid, removed) as [g] being moved right. *)

val move_up : t -> t * elt list list
(** [move_up g] returns tuple (grid, removed) as [g] being moved up. *)

val move_down : t -> t * elt list list
(** [move_down g] returns tuple (grid, removed) as [g] being moved down. *)

val move_available : t -> bool
(** [move_available g] returns true if any cell on [g] is possible to move *)
