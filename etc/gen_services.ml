(*
 * Copyright (c) 2012 Anil Madhavapeddy <anil@recoil.org>
 *
 * Permission to use, copy, modify, and distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 *)

(* Convert a UNIX /etc/services into an ML module to lookup entries *)
open Printf

let hashtbl_add_list h k v =
  try
    let l = Hashtbl.find h k in
    l := v :: !l
   with Not_found -> Hashtbl.add h k (ref [v])

let _ =
  let fin = open_in Sys.argv.(1) in
  let tcp_ports = Hashtbl.create 1 in
  let udp_ports = Hashtbl.create 1 in
  let ports_tcp = Hashtbl.create 1 in
  let ports_udp = Hashtbl.create 1 in
  (try while true do
    let line = input_line fin in
    match line.[0] with
    |'#'|' ' -> ()
    |_ ->
      Scanf.sscanf line "%s %d/%s" (fun svc port proto ->
       match proto with
       |"tcp" ->
         hashtbl_add_list tcp_ports svc port;
         hashtbl_add_list ports_tcp port ("\""^svc^"\"");
       |"udp" ->
         hashtbl_add_list udp_ports svc port;
         hashtbl_add_list ports_udp port ("\""^svc^"\"");
       |"ddp" | "sctp" | "divert" -> ()
       |x -> failwith ("unknown proto " ^ x)
      )
  done with End_of_file -> ());
  printf "(* Autogenerated by gen_services.ml, do not edit directly *)\n";
  printf "let tcp_port_of_service = function\n";
  Hashtbl.iter (fun k v ->
   printf "  |\"%s\" -> [%s]\n" k (String.concat ";" (List.map string_of_int !v))
  ) tcp_ports;
  printf "  |_ -> []\n\n";
   printf "let udp_port_of_service = function\n";
  Hashtbl.iter (fun k v ->
   printf "  |\"%s\" -> [%s]\n" k (String.concat ";" (List.map string_of_int !v))
  ) udp_ports;
  printf "  |_ -> []\n\n";
  printf "let service_of_tcp_port = function\n";
  Hashtbl.iter (fun k v ->
   printf "  |%d -> [%s]\n" k (String.concat ";" !v)
  ) ports_tcp;
  printf "  |_ -> []\n\n";
   printf "let service_of_udp_port = function\n";
  Hashtbl.iter (fun k v ->
   printf "  |%d -> [%s]\n" k (String.concat ";" !v)
  ) ports_udp;
  printf "  |_ -> []\n\n";
  