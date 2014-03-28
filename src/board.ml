(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

type count = int
type score = int
type t = Grid.t * count * score

module Monad = struct
  let return grid = (grid, 0, 0)
  let bind (grid, count, score) move =
    let sum = List.fold_left (+) 0 in
    let grid', removed = move grid in
    let score' = List.flatten removed |> sum in
    let is_changed = score' <> 0 || grid' <> grid in
    grid', (if is_changed then succ count else count), score + score'
end

module Infix = struct
  let ( >>= ) = Monad.bind
end

let init x y = Grid.init x y |> Monad.return

let grid (g, _, _) = g
let count (_, c, _) = c
let score (_, _, s) = s

let spawn (grid, count, score) =
  match Grid.empty_cells grid with
  | Some cells ->
      let num_of_cells = List.length cells in
      let n = Random.int num_of_cells in
      let x, y = List.nth cells n in
      let num = if (Random.int 10 = 0) then 4 else 2 in
      (Grid.set x y num grid, count, score)
  | None -> (grid, count, score)

open Infix

let move_left board = board >>= Grid.move_left
let move_right board = board >>= Grid.move_right
let move_up board = board >>= Grid.move_up
let move_down board = board >>= Grid.move_down
