(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Game.

    Game logic of 2048.
 *)

type move = Up | Down | Left | Right
(** Type of game movement. *)

type action = Move of move | Reset | Quit | Invalid
(** Type of game action. *)

type state = Playing | Win | Lose
(** Type of game state. *)

type t
(** Abstract type of game. *)

(** Monadic interface of game. *)
module Monad : sig
  val return : Board.t -> t
  (** [return b] creates a game with game board [b]. *)

  val bind : t -> (Board.t -> t) -> t
  (** [bind g f] plays action [f] on game [g], returns resulting game. *)
end

(** Monadic bind operator of game. *)
module Infix : sig
  val ( >>= ) : t -> (Board.t -> t) -> t
  (** [g >>= f] plays action [f] on game [g], returns resulting game. *)
end

val init : int -> int -> t
(** [init x y] creates a new game with game board of size [x] by [y]. *)

val get_state : t -> state
(** [get_state g] returns game state of game [g]. *)

val get_board : t -> Board.t
(** [get_board g] returns game board of game [g]. *)

val lose : Board.t -> t
(** [lose b] makes a lose game with game board [b]. *)

val win : Board.t -> t
(** [win b] makes a lose game with game board [b]. *)

val spawn : Board.t -> t
(** [spawn b] returns a game with an element added randomly
    in empty cell on game board [b].
 *)

val check : Board.t -> t
(** [check b] checks and update game state with game board [b]. *)

val move : move -> t -> t
(** [move m g] plays movement [m] on game [g]. *)
