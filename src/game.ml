(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

let version = "0.3"

type move = Up | Down | Left | Right

type state = Playing | Win | Lose

type t = state * Board.t

let state (s, _) = s
let board (_, b) = b
let count (_, b) = Board.count b
let score (_, b) = Board.score b

let winning_number = 2048

let playing board = (Playing, board)
let lose board = (Lose, board)
let win board = (Win, board)

let check board =
  let grid = Board.grid board in
  if Grid.contains winning_number grid then
    win board
  else if Grid.move_available grid then
    playing board
  else
    lose board

module Monad = struct
  let return board = (Playing, board)
  let bind game action =
    match game with
    | Playing, board ->
        begin match action board with
        | Playing, board' -> check board'
        | game -> game
        end
    | game -> game
  let lift f game = board game |> f |> return
end

module Infix = struct
  let ( >>= ) = Monad.bind
end

let spawn board = Board.spawn board |> playing

let move m game =
  let open Infix in
  let action = match m with
  | Up -> Board.move_up
  | Down -> Board.move_down
  | Left -> Board.move_left
  | Right -> Board.move_right
  in Monad.lift action game >>= spawn

let init x y =
  Random.self_init ();
  let board = Board.init x y in
  let open Infix in
  playing board >>= spawn >>= spawn
