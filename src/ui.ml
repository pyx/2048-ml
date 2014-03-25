(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

let render game =
  Tui.render game;
  Gui.render game

let init () = Game.init 4 4

let main_loop action render game =
  let rec loop game' =
    render game';
    match action () with
    | Input.Move m -> loop (Game.move m game')
    | Input.Reset -> loop (init ())
    | Input.Quit -> print_endline "Quit."
    | Input.Invalid -> loop game'
  in loop game

let main () =
  let game = init () in
  Tui.init game;
  Gui.init game;
  try
    main_loop Input.action render game;
  with Graphics.Graphic_failure _ -> ();
  Gui.cleanup ();
  Tui.cleanup ()
