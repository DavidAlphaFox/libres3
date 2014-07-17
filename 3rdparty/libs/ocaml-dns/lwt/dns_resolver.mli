(*
 * Copyright (c) 2014 Anil Madhavapeddy <anil@recoil.org>
 * Copyright (c) 2012 Richard Mortier <mort@cantab.net>
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
 *)

type commfn =
  (Dns.Buf.t -> unit Lwt.t) *
  ((Dns.Buf.t -> Dns.Packet.t option) -> Dns.Packet.t Lwt.t) *
  (unit -> unit Lwt.t)

val resolve : 
  (module Dns.Protocol.CLIENT) ->
  ?dnssec:bool ->
  commfn -> Dns.Packet.q_class -> 
  Dns.Packet.q_type -> 
  Dns.Name.domain_name -> 
  Dns.Packet.t Lwt.t

val gethostbyname :
  ?q_class:Dns.Packet.q_class ->
  ?q_type:Dns.Packet.q_type -> commfn ->
  string -> Ipaddr.V4.t list Lwt.t

val gethostbyaddr :
  ?q_class:Dns.Packet.q_class ->
  ?q_type:Dns.Packet.q_type -> commfn ->
  Ipaddr.V4.t -> string list Lwt.t
