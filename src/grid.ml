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
let get x y grid = grid.(y).(x)
let set x y e grid = grid.(y).(x) <- e; grid

let size grid = Array.length grid.(0), Array.length grid

let to_list grid = grid |> Array.map Array.to_list |> Array.to_list

let contains e grid = grid |> to_list |> List.flatten |> List.mem e

let has_empty_cell = contains empty

let empty_cells_to_index =
  Array.mapi (fun y ->
    Array.mapi (fun x cell ->
      if cell = empty then Some (x, y) else None))

let filter_some =
  let rec loop acc = function
    | None :: tl -> loop acc tl
    | Some e :: tl -> loop (e :: acc) tl
    | [] ->
        match acc with
        | [] -> None
        | _ -> Some acc
  in loop []

let empty_cells grid =
  grid |> empty_cells_to_index |> to_list |> List.flatten |> filter_some

let merge =
  let rec loop acc removed = function
    | x :: y :: t when x = y -> loop (x + y :: acc) (x :: y :: removed) t
    | h :: t -> loop (h :: acc) removed t
    | [] -> List.rev acc, List.rev removed
  in loop [] []

let merge_left row =
  let orig_len = Array.length row in
  let padding = Array.make orig_len empty in
  let remove_empty = List.filter ((<>) empty) in
  let add_padding = fun row -> Array.append row padding in
  let take n row = Array.sub row 0 n in
  let row', removed = Array.to_list row |> remove_empty |> merge in
  Array.of_list row' |> add_padding |> take orig_len, removed

let merge_right row =
  let reverse r = r |> Array.to_list |> List.rev |> Array.of_list in
  let row', removed = reverse row |> merge_left in
  reverse row', removed

let transpose grid =
  let dim_x, dim_y = size grid in
  let grid' = init dim_y dim_x in
  for x = 0 to pred dim_x do
    for y = 0 to pred dim_y do
      set y x (get x y grid) grid' |> ignore
    done;
  done;
  grid'

let move_with merge grid =
  let rows, removed = Array.map merge grid |> Array.to_list |> List.split in
  Array.of_list rows, removed

let move_left = move_with merge_left

let move_right = move_with merge_right

let move_up grid =
  let grid', removed = grid |> transpose |> move_left in
  transpose grid', removed

let move_down grid =
  let grid', removed = grid |> transpose |> move_right in
  transpose grid', removed

let move_available grid =
  has_empty_cell grid ||
  fst (move_left grid) <> grid ||
  fst (move_right grid) <> grid ||
  fst (move_up grid) <> grid ||
  fst (move_down grid) <> grid
