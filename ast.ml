type int31 = bool list

let dec_to_bin (x : int) : bool list =
  let rec d2b (x : int) (len : int) : bool list =
    match len with
    | 0 -> []
    | l -> let b = if (x mod 2 = 1) then true else false in
           b :: d2b (x / 2) (len-1)
  in
  List.rev (d2b x 31)

let bin_to_string (l : bool list) : string = 
  let rec b2s (l : bool list) : string = 
    match l with
    | false :: t -> "Int31.D0 " ^ b2s t
    | true :: t -> "Int31.D1 " ^ b2s t
    | [] -> ""
  in "Int31.I31 " ^ b2s l

let rec list_to_bin_string (l : bool list) : string =
match l with
  | true :: t -> "1" ^ list_to_bin_string t
  | false :: t -> "0" ^ list_to_bin_string t
  | [] -> ""

let rec pow2 (exp : int) : int =
  if (exp = 0) then 1 else (2 * (pow2 (exp-1)))

let rec list_to_dec (l : bool list) (weight : int) : int = 
match l with
  | true :: t -> pow2 weight + (list_to_dec t (weight - 1))
  | false :: t -> (list_to_dec t (weight - 1))
  | [] -> 0

let to_string_bin (x : int31) : string =
list_to_bin_string x

let to_string_dec (x : int31) : string =
string_of_int (list_to_dec x 30)