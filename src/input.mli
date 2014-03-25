(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Input.

    Interface to user input.
 *)

type action = Move of Game.move | Reset | Quit | Invalid
(** Type of game action. *)

val action : unit -> action
(** [get_action] waits and return the next action from user input. *)
