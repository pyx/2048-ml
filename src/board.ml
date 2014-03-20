(*
 * Copyright (c) 2014, Philip Xu <pyx@xrefactor.com>
 * All rights reserved.
 * License: BSD New, see LICENSE for details.
 *)

type elt = int
type t = elt array array

let empty = 0

(* Note: matrix created by make_matrix is transposed, that's why y, x here *)
let init x y = Array.make_matrix y x empty
let get x y board = board.(y).(x)
let set x y e board = board.(y).(x) <- e; board

let size board = Array.length board.(0), Array.length board

let to_list board =
  board
  |> Array.map Array.to_list
  |> Array.to_list

let contains e board =
  board
  |> to_list
  |> List.flatten
  |> List.mem e

let has_empty_cell = contains empty

let empty_cells_to_index =
  Array.mapi (fun y ->
    Array.mapi (fun x cell ->
      if cell = empty then Some (x, y) else None))

let filter_some =
  let rec loop acc = function
    | [] -> acc
    | None :: tl -> loop acc tl
    | Some e :: tl -> loop (e :: acc) tl
  in loop []

let empty_cells board =
  board
  |> empty_cells_to_index
  |> to_list
  |> List.flatten
  |> filter_some

let rec merge = function
  | x :: y :: t when x = y -> x + y :: merge t
  | h :: t -> h :: merge t
  | [] -> []

let remove_empty = List.filter ((<>) empty)

let take n row = Array.sub row 0 n

let merge_left row =
  let orig_len = Array.length row in
  let padding = Array.make orig_len empty in
  let add_padding = fun row -> Array.append row padding in
  row
  |> Array.to_list
  |> remove_empty
  |> merge
  |> Array.of_list
  |> add_padding
  |> take orig_len

let merge_right row =
  let reverse r = r |> Array.to_list |> List.rev |> Array.of_list in
  row |> reverse |> merge_left |> reverse

let transpose board =
  let dim_x, dim_y = size board in
  let board' = init dim_y dim_x in
  for x = 0 to pred dim_x do
    for y = 0 to pred dim_y do
      set y x (get x y board) board' |> ignore
    done;
  done;
  board'

let move_left = Array.map merge_left

let move_right = Array.map merge_right

let move_up board =
  board |> transpose |> move_left |> transpose

let move_down board =
  board |> transpose |> move_right |> transpose
