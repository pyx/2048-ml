(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

open Game

let get_action = Input.get_action

let render game =
  Tui.render game;
  Gui.render game

let init () = Game.init 4 4

let main_loop game get_action render =
  let rec loop game' =
    render game';
    match get_action () with
    | Move m -> loop (move m game')
    | Reset -> loop (init ())
    | Quit -> print_endline "Quit."
    | Invalid -> loop game'
  in loop game

let main () =
  let game = init () in
  Tui.init game;
  Gui.init game;
  try
    main_loop game get_action render;
  with Graphics.Graphic_failure _ -> ();
  Gui.cleanup ();
  Tui.cleanup ()
