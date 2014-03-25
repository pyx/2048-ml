(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

open Game

type action = Move of move | Reset | Quit | Invalid

let key_to_action = function
  | 'k' -> Move Up
  | 'j' -> Move Down
  | 'h' -> Move Left
  | 'l' -> Move Right
  | 'r' -> Reset
  | 'q' -> Quit
  | c ->
      match int_of_char c with
      | 3 | 27 -> Quit  (* <Ctrl-C> = 3, <ESC> = 27 *)
      | _ -> Invalid

let action () = Graphics.read_key () |> key_to_action
