(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Input.

    Interface to user input.
 *)

val get_action : unit -> Game.action
(** [get_action] waits and return the next action from user input. *)
