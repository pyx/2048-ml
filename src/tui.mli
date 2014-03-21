(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Tui.

    Text (ascii) interface of the game.
 *)

val init : Game.t -> unit
(** [init g] prepares text interface for game [g]. *)

val render : Game.t -> unit
(** [render g] renders game [g] as ascii text. *)

val cleanup : unit -> unit
(** [cleanup] cleans up text interface before quitting. *)
