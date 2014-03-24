(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Game.

    Game logic of 2048.
 *)

val version : string
(** Version description *)

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

val state : t -> state
(** [state g] returns game state of game [g]. *)

val board : t -> Board.t
(** [board g] returns game board of game [g]. *)

val count : t -> int
(** [count g] returns move count of game [g] so far. *)

val score : t -> int
(** [score g] returns score of game [g] so far. *)

val move : move -> t -> t
(** [move m g] plays movement [m] on game [g]. *)
