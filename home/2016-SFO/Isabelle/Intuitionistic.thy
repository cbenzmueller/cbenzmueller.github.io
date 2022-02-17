
theory Intuitionistic
imports QML

begin
axiomatization where
  S4: "S4_sem"

(* This here is the Gödel Translation *)
abbreviation inotG  :: "\<sigma>\<Rightarrow>\<sigma>" ("\<not>\<^sup>G_"[52]53)
  where "\<not>\<^sup>G\<phi> \<equiv> \<^bold>\<not>\<^bold>\<box>\<phi>" 
abbreviation iimpG   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<rightarrow>\<^sup>G"49) 
  where "\<phi> \<rightarrow>\<^sup>G \<psi> \<equiv> \<^bold>\<box>\<phi> \<^bold>\<rightarrow> \<^bold>\<box>\<psi>"  
abbreviation iorG    :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<or>\<^sup>G"50)
  where "\<phi> \<or>\<^sup>G \<psi> \<equiv> \<^bold>\<box>\<phi> \<^bold>\<or> \<^bold>\<box>\<psi>" 
abbreviation iandG   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<and>\<^sup>G"51)
  where "\<phi> \<and>\<^sup>G \<psi> \<equiv> \<phi> \<^bold>\<and> \<psi>"   

(* Some Tests *)

(* Excluded middle: Countermodel by Nitpick *)
lemma EM: "\<lfloor>\<phi> \<or>\<^sup>G \<not>\<^sup>G\<phi>\<rfloor>" nitpick oops

(* Double negation elimination: Countermodel by Nitpick *)
lemma DN: "\<lfloor>\<not>\<^sup>G\<not>\<^sup>G\<phi> \<rightarrow>\<^sup>G \<phi>\<rfloor>" nitpick oops
lemma DNC: "\<lfloor>\<phi> \<rightarrow>\<^sup>G \<not>\<^sup>G\<not>\<^sup>G\<phi>\<rfloor>" by (meson S4)


(* Law of contradiction: As exptected, this holds. *)
lemma CON: "\<lfloor>(\<phi> \<rightarrow>\<^sup>G \<psi>) \<rightarrow>\<^sup>G ((\<phi> \<rightarrow>\<^sup>G \<not>\<^sup>G\<psi>) \<rightarrow>\<^sup>G \<not>\<^sup>G\<phi>)\<rfloor>" by (metis S4)

(* Ex falso quodlibet: As exptected, this holds. *)
lemma EFQ: "\<lfloor>\<not>\<^sup>G\<phi> \<rightarrow>\<^sup>G (\<phi> \<rightarrow>\<^sup>G \<psi>)\<rfloor>" by metis


(* This here is the McKinsey/Tarski Translation *)

abbreviation iatom :: "\<sigma>\<Rightarrow>\<sigma>" ("<_>"[108]109)
  where "<\<phi>> \<equiv> \<^bold>\<box>\<phi>"
abbreviation inotT  :: "\<sigma>\<Rightarrow>\<sigma>" ("\<not>\<^sup>T_"[52]53)
  where "\<not>\<^sup>T\<phi> \<equiv> \<^bold>\<box>\<^bold>\<not>\<phi>" 
abbreviation iimpT   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<rightarrow>\<^sup>T"49) 
  where "\<phi> \<rightarrow>\<^sup>T \<psi> \<equiv> \<^bold>\<box>(\<phi> \<^bold>\<rightarrow> \<psi>)"  
abbreviation iorT    :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<or>\<^sup>T"50)
  where "\<phi> \<or>\<^sup>T \<psi> \<equiv> \<phi> \<^bold>\<or> \<psi>" 
abbreviation iandT   :: "\<sigma>\<Rightarrow>\<sigma>\<Rightarrow>\<sigma>" (infixr"\<and>\<^sup>T"51)
  where "\<phi> \<and>\<^sup>T \<psi> \<equiv> \<phi> \<^bold>\<and> \<psi>" 

(* Some Tests *)

(* Excluded middle: Countermodel by Nitpick *)
lemma EM_T: "\<lfloor><\<phi>> \<or>\<^sup>T \<not>\<^sup>T<\<phi>>\<rfloor>" nitpick oops

(* Double negation elimination: Countermodel by Nitpick *)
lemma DN_T: "\<lfloor>\<not>\<^sup>T\<not>\<^sup>T<\<phi>> \<rightarrow>\<^sup>T <\<phi>>\<rfloor>" nitpick oops
lemma DNC_T: "\<lfloor><\<phi>> \<rightarrow>\<^sup>T \<not>\<^sup>T\<not>\<^sup>T<\<phi>>\<rfloor>" by (meson S4)


(* Law of contradiction: As exptected, this holds. *)
lemma CON_T: "\<lfloor>(<\<phi>> \<rightarrow>\<^sup>T <\<psi>>) \<rightarrow>\<^sup>T ((<\<phi>> \<rightarrow>\<^sup>T \<not>\<^sup>T<\<psi>>) \<rightarrow>\<^sup>T \<not>\<^sup>T<\<phi>>)\<rfloor>" by (metis S4)

(* Ex falso quadlibet: As exptected, this holds. *)
lemma EFQ_T: "\<lfloor>\<not>\<^sup>T<\<phi>> \<rightarrow>\<^sup>T (<\<phi>> \<rightarrow>\<^sup>T <\<psi>>)\<rfloor>" by metis  


(* Meta-logical Studies: Exercise *)

lemma "\<lfloor>\<not>\<^sup>T<\<phi>>\<rfloor> \<longleftrightarrow> \<lfloor>\<not>\<^sup>G\<phi>\<rfloor>" using S4 by blast
lemma "\<lfloor><\<phi>> \<or>\<^sup>T <\<psi>>\<rfloor> \<longleftrightarrow> \<lfloor>\<phi> \<or>\<^sup>G \<psi>\<rfloor>" by simp
lemma "\<lfloor><\<phi>> \<and>\<^sup>T <\<psi>>\<rfloor> \<longleftrightarrow> \<lfloor>\<phi> \<and>\<^sup>G \<psi>\<rfloor>" using S4 by blast
lemma "\<lfloor><\<phi>> \<rightarrow>\<^sup>T <\<psi>>\<rfloor> \<longleftrightarrow> \<lfloor>\<phi> \<rightarrow>\<^sup>G \<psi>\<rfloor>" using S4 by blast


end

