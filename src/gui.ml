(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

open Graphics
open Game

let side = 80
let margin = side
let line_width = side / 10

let window_size game =
  let x, y = Board.size (get_board game) in
  let margins = margin + margin in
  x * side + margins, y * side + margins

let frame_color = 0xbbada0
let info_color = 0x201403

let get_colors = function
  | 2    -> 0x776e65, 0xeee4da
  | 4    -> 0x776e65, 0xede0c8
  | 8    -> 0xf9f6f2, 0xf2b179
  | 16   -> 0xf9f6f2, 0xf59563
  | 32   -> 0xf9f6f2, 0xf67c5f
  | 64   -> 0xf9f6f2, 0xf65e3b
  | 128  -> 0xf9f6f2, 0xedcf72
  | 256  -> 0xf9f6f2, 0xedcc61
  | 512  -> 0xf9f6f2, 0xedc850
  | 1024 -> 0xf9f6f2, 0xedc53f
  | 2048 -> 0xf9f6f2, 0xedc22e
  | _    -> 0x776e65, 0xcdc0b4

let draw_centered_text x y w h text =
  let text_w, text_h = text_size text in
  let text_x, text_y = x + (w - text_w) / 2, y + (h - text_h) / 2 in
  moveto text_x text_y;
  draw_string text

let draw_cell x y cell =
  let fg, bg = get_colors cell in
  let text = string_of_int cell in
  set_color bg;
  fill_rect x y side side;
  set_color frame_color;
  set_line_width line_width;
  draw_rect x y side side;
  set_color fg;
  if cell <> 0 then draw_centered_text x y side side text

let draw_board board =
  let dim_x, dim_y = Board.size board in
  for x = 0 to pred dim_x do
    for y = 0 to pred dim_y do
      let cord_x, cord_y = x * side + margin, y * side + margin in
      let cell = Board.get x (pred dim_y - y) board in
      draw_cell cord_x cord_y cell
    done;
  done

let draw_info game =
  let width, height = window_size game in
  let info = "2048 in OCaml, r to reset, q or <ESC> to quit" in
  set_color info_color;
  draw_centered_text 0 (height - margin) width margin info;
  let sign = "Copyright (c) 2014 pyx." in
  let offset, _ = text_size sign in
  moveto (width - offset - 2) 2;
  draw_string sign;
  let draw_text = draw_centered_text 0 0 width margin in
  match get_state game with
  | Win -> draw_text "You win!"
  | Lose -> draw_text "You lose."
  | Playing -> draw_text "h j k l to move left, down, up, right respectively"

let init game =
  open_graph "";
  set_window_title "2048 in OCaml";
  let width, height = window_size game in
  resize_window width height

let render game =
  let board = get_board game in
  auto_synchronize false;
  clear_graph ();
  draw_board board;
  draw_info game;
  auto_synchronize true

let cleanup = close_graph
