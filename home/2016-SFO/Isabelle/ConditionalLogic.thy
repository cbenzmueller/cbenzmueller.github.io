(* Christoph Benzmüller and Arc Kocurek, February 2016 *)

theory ConditionalLogic
imports Main

begin

typedecl i -- "type for possible worlds" 
typedecl \<mu> -- "type for individuals"      
type_synonym \<sigma> = "(i\<Rightarrow>bool)"

consts f :: "i\<Rightarrow>(i\<Rightarrow>bool)\<Rightarrow>(i\<Rightarrow>bool)"     -- "selection function f"   

abbreviation mtrue  :: "\<sigma>" ("\<^bold>\<top>")
  where "\<^bold>\<top> \<equiv> \<lambda>w. True" 
abbreviation mfalse :: "\<sigma>" ("\<^bold>\<bottom>") 
  where "\<^bold>\<bottom> \<equiv> \<lambda>w. False"   
abbreviation mnot   :: "\<sigma>\<Rightarrow>\<sigma>" ("\<^bold>\<not>_"[52]53)
  where "\<^bold>\<not>\<phi> \<equiv> \<lambda>w. \<not>\<phi>(w)" 
abbreviation mand   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<and>"51)
  where "\<phi>\<^bold>\<and>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<and>\<psi>(w)"   
abbreviation mor    :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<or>"50)
  where "\<phi>\<^bold>\<or>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<or>\<psi>(w)"   
abbreviation mimp   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<rightarrow>"49) 
  where "\<phi>\<^bold>\<rightarrow>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<longrightarrow>\<psi>(w)"  
abbreviation mequ   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<^bold>\<leftrightarrow>"48)
  where "\<phi>\<^bold>\<leftrightarrow>\<psi> \<equiv> \<lambda>w. \<phi>(w)\<longleftrightarrow>\<psi>(w)"  
abbreviation mall   :: "('a\<Rightarrow>\<sigma>)\<Rightarrow>\<sigma>" ("\<^bold>\<forall>")      
  where "\<^bold>\<forall>\<Phi> \<equiv> \<lambda>w.\<forall>x. \<Phi>(x)(w)"
abbreviation mallB  :: "('a\<Rightarrow>\<sigma>)\<Rightarrow>\<sigma>" (binder"\<^bold>\<forall>"[8]9)
  where "\<^bold>\<forall>x. \<phi>(x) \<equiv> \<^bold>\<forall>\<phi>"   
abbreviation mexi   :: "('a\<Rightarrow>\<sigma>)\<Rightarrow>\<sigma>" ("\<^bold>\<exists>") 
  where "\<^bold>\<exists>\<Phi> \<equiv> \<lambda>w.\<exists>x. \<Phi>(x)(w)"
abbreviation mexiB  :: "('a\<Rightarrow>\<sigma>)\<Rightarrow>\<sigma>" (binder"\<^bold>\<exists>"[8]9)
  where "\<^bold>\<exists>x. \<phi>(x) \<equiv> \<^bold>\<exists>\<phi>"   
abbreviation meq    :: "\<mu>\<Rightarrow>\<mu>\<Rightarrow>\<sigma>" (infixr"\<^bold>="52) -- "Equality"  
  where "x\<^bold>=y \<equiv> \<lambda>w. x = y"
abbreviation meqL    :: "\<mu>\<Rightarrow>\<mu>\<Rightarrow>\<sigma>" (infixr"\<^bold>=\<^sup>L"52) -- "Leibniz Equality"   
  where "x\<^bold>=\<^sup>Ly \<equiv> \<^bold>\<forall>\<phi>. \<phi>(x)\<^bold>\<rightarrow>\<phi>(y)"
(*
abbreviation mbox   :: "\<sigma>\<Rightarrow>\<sigma>" ("\<^bold>\<box>_"[52]53)
  where "\<^bold>\<box>\<phi> \<equiv> \<lambda>w.\<forall>v. w r v \<longrightarrow> \<phi>(v)"
abbreviation mdia   :: "\<sigma>\<Rightarrow>\<sigma>" ("\<^bold>\<diamond>_"[52]53)
  where "\<^bold>\<diamond>\<phi> \<equiv> \<lambda>w.\<exists>v. w r v \<and> \<phi>(v)"
*)

abbreviation mcond  :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infix "\<^bold>\<supset>" 53)
  where "\<phi>\<^bold>\<supset>\<psi> \<equiv> \<lambda>w.\<forall>v. f(w)(\<phi>)(v) \<longrightarrow> \<psi>(v)"



text {* Finally, a formula is valid if and only if it is satisfied in all worlds. *}

abbreviation valid :: "\<sigma>\<Rightarrow>bool" ("\<lfloor>_\<rfloor>"[8]109)
  where "\<lfloor>p\<rfloor> \<equiv> \<forall>w. p w"

abbreviation msubset :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>bool" (infix "\<^bold>\<subseteq>" 53)
  where "\<phi> \<^bold>\<subseteq> \<psi> \<equiv> \<forall>x. \<phi> x \<longrightarrow> \<psi> x"


abbreviation ID
  where "ID \<equiv> \<^bold>\<forall>\<phi>. \<phi> \<^bold>\<supset> \<phi>"

abbreviation ID_sem 
  where "ID_sem \<equiv> \<forall>w. \<forall>\<phi>. f(w)(\<phi>) \<^bold>\<subseteq> \<phi>"

lemma "\<lfloor>ID\<rfloor>" nitpick

lemma "\<lfloor>ID\<rfloor> \<longleftrightarrow> ID_sem" sledgehammer by simp

end

