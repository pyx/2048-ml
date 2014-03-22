(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

open Game

let init _ =
  print_endline "Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>";
  print_endline "All rights reserved. With BSD New License.";
  print_endline @@ "2048 in OCaml, Version " ^ version

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

let draw_board_text board =
  let board' = Board.to_list board in
  let row_len = fst (Board.size board) in
  let hr = make_banner row_len in
  let draw_row row =
    print_endline hr;
    List.iter draw_cell row;
    print_endline "|"
  in
  List.iter draw_row board';
  print_endline hr

let render game =
  print_endline "r to reset, q or <ESC> to quit";
  draw_board_text (get_board game);
  match get_state game with
  | Win -> print_endline "You win!"
  | Lose -> print_endline "You lose."
  | Playing ->
      print_endline "h j k l to move left, down, up, right respectively"

let cleanup () = print_endline "Bye."
