(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

type count = int
type score = int
type t = Grid.t * count * score

let init x y = Grid.init x y, 0, 0

let grid (g, _, _) = g
let count (_, c, _) = c
let score (_, _, s) = s

let move_and_score move (grid, count, score) =
  let sum = List.fold_left (+) 0 in
  let grid', removed = move grid in
  let score' = List.flatten removed |> sum in
  let is_changed = score' <> 0 || grid' <> grid in
  grid', (if is_changed then succ count else count), score + score'

let move_left = move_and_score Grid.move_left
let move_right = move_and_score Grid.move_right
let move_up = move_and_score Grid.move_up
let move_down = move_and_score Grid.move_down

let spawn (grid, count, score) =
  let empty_cells = Grid.empty_cells grid in
  let num_of_empty_cells = List.length empty_cells in
  if num_of_empty_cells <> 0 then
    let n = Random.int num_of_empty_cells in
    let x, y = List.nth empty_cells n in
    let num = if (Random.int 10 = 0) then 4 else 2 in
    (Grid.set x y num grid, count, score)
  else
    (grid, count, score)
