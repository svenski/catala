(* This file is part of the Catala compiler, a specification language for tax and social benefits
   computation rules. Copyright (C) 2020 Inria, contributor: Nicolas Chataing
   <nicolas.chataing@ens.fr>

   Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
   in compliance with the License. You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software distributed under the License
   is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
   or implied. See the License for the specific language governing permissions and limitations under
   the License. *)

module UidMap = Uid.UidMap

(* Scopes *)
type binder = string Pos.marked

type definition = Lambda.default_term

type assertion = Lambda.term

type variation_typ = Increasing | Decreasing

type reference_typ = Decree | Law

type meta_assertion =
  | FixedBy of reference_typ Pos.marked
  | VariesWith of Lambda.term * variation_typ Pos.marked option

type scope = {
  scope_uid : Uid.t;
  scope_defs : definition UidMap.t;
  scope_sub_defs : definition UidMap.t UidMap.t;
  scope_assertions : assertion list;
  scope_meta_assertions : meta_assertion list UidMap.t;
}

let empty_scope (uid : Uid.t) : scope =
  {
    scope_uid = uid;
    scope_defs = UidMap.empty;
    scope_sub_defs = UidMap.empty;
    scope_assertions = [];
    scope_meta_assertions = UidMap.empty;
  }

type program = scope UidMap.t