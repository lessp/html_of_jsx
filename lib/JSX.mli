module Attribute : sig
  type t =
    | Bool of (string * bool)
    | String of (string * string)
    | Style of string
    | Event of (string * string)

  val to_string : t list -> string
end

type node = {
  tag : string;
  attributes : Attribute.t list;
  children : element list;
}

(** The type that represents a JSX.element, it's a recursive type that allows to represent any HTML structure *)
and element =
  | Null
  | String of string
  | Unsafe of string
  | Fragment of element list
  | Node of node
  | Component of (unit -> element)
  | List of element list

val string : string -> element
(** Helper to represent an element as a string *)

val unsafe : string -> element
(** Helper to bypass HTML encoding and treat output as unsafe. This can lead to
    HTML scaping problems, XSS injections and other security concerns, use with caution. *)

val null : element
(** Helper to represent nullability in Jsx, useful to pattern match *)

val int : int -> element
(** Helper to render an integer *)

val float : float -> element
(** Helper to render an integer *)

val list : element list -> element

val fragment : element list -> element
(** Fragment  *)

val node : string -> Attribute.t list -> element list -> element
(** The function to create a HTML DOM Node [https://developer.mozilla.org/en-US/docs/Web/API/Node]. Given the tag, list of attributes and list of childrens *)

val to_string : element -> string
(** The function to convert a JSX.element to a string *)
