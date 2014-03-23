(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

let version = "0.1"

type move = Up | Down | Left | Right

type action = Move of move | Reset | Quit | Invalid

type state = Playing | Win | Lose

type t = state * Board.t

module Monad = struct
  let return board = (Playing, board)
  let bind game action =
    match game with
    | (Playing, board) -> action board
    | game -> game
end

module Infix = struct
  let ( >>= ) = Monad.bind
end

let get_state (state, _) = state
let get_board (_, board) = board

let winning_number = 2048

let playing = Monad.return
let lose board = (Lose, board)
let win board = (Win, board)

let spawn board =
  let empty_cells = Board.empty_cells board in
  let num_of_empty_cells = List.length empty_cells in
  if num_of_empty_cells = 0 then
    playing board
  else
    let n = Random.int num_of_empty_cells in
    let x, y = List.nth empty_cells n in
    let num = if (Random.int 10 = 0) then 4 else 2 in
    playing (Board.set x y num board)

let check board =
  if Board.contains winning_number board then
    win board
  else if Board.move_available board then
    playing board
  else
    lose board

let play movement board =
  let board' = movement board in
  let not_changed = board = board' in
  if not_changed then
    playing board
  else let open Infix in
    playing board' >>= spawn >>= check

let move m game =
  let open Infix in
  let action = match m with
  | Up -> Board.move_up
  | Down -> Board.move_down
  | Left -> Board.move_left
  | Right -> Board.move_right
  in game >>= play action

let init x y =
  Random.self_init ();
  let board = Board.init x y in
  let open Infix in
  playing board >>= spawn >>= spawn
