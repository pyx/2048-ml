(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

(** Module Gui.

    Graphical interface of the game.
 *)

val init : Game.t -> unit
(** [init g] prepares graphical mode for game [g]. *)

val render : Game.t -> unit
(** [render g] renders game [g] in graphical mode. *)

val cleanup : unit -> unit
(** [cleanup] cleans up graphical interface before quitting. *)
