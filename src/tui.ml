(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

let init _ =
  print_endline "Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>";
  print_endline "All rights reserved. With BSD New License.";
  print_endline @@ "2048 in OCaml, Version " ^ Game.version

let repeat n a =
  let rec loop n acc =
    if n > 0 then
      loop (n - 1) (a :: acc)
    else
      acc
  in loop n []

let make_banner size =
  "|" ^ String.concat "+" (repeat size "----") ^ "|"

let draw_cell = function
  | 0 -> print_string "|    "
  | n -> Printf.printf "|%4d" n

let draw_stat board =
  let score = Board.score board in
  let count = Board.count board in
  Printf.printf "Score: %d / Move: %d\n" score count

let draw_board board =
  let grid = Board.grid board in
  let x, _ = Grid.size grid in
  let hr = make_banner x in
  let draw_row row =
    print_endline hr;
    List.iter draw_cell row;
    print_endline "|"
  in
  draw_stat board;
  List.iter draw_row (Grid.to_list grid);
  print_endline hr

let render game =
  print_endline "r to reset, q or <ESC> to quit";
  draw_board (Game.board game);
  let open Game in
  match state game with
  | Win -> print_endline "You win!"
  | Lose -> print_endline "You lose."
  | Playing ->
      print_endline "h j k l to move left, down, up, right respectively"

let cleanup () = print_endline "Bye."
