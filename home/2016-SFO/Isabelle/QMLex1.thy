(* Christoph Benzmüller, February 2016 *)

theory QMLex1
imports QML

begin

-- "Checking for Consistency"
lemma True nitpick [satisfy, user_axioms, expect = genuine] oops


lemma "a \<and> b \<longrightarrow> b \<and> a"
 proof
  assume ab: "a \<and> b"
  from ab have a: "a" ..
  from ab have b: "b" ..
  from b a show "b \<and> a" ..
qed


lemma "a \<and> b \<longrightarrow> b \<and> a"
 proof
  assume ab: "a \<and> b"
  from ab have a: "a" by (rule conjE)
  from ab have b: "b" by (rule conjE)
  from b a show "b \<and> a" by (rule conjI)
qed


lemma "a \<and> b \<longrightarrow> b \<and> a"
 proof
  assume ab: "a \<and> b"
  have a: "a" by (simp add: ab)
  have b: "b" by (simp add: ab)
  show "b \<and> a" by (simp add: a b)
qed


lemma "a \<and> b \<longrightarrow> b \<and> a"
by simp


lemma "\<lfloor>(\<^bold>\<box>a \<^bold>\<and> \<^bold>\<box>b) \<^bold>\<rightarrow> \<^bold>\<box>(a \<^bold>\<or> b)\<rfloor>" 
proof
 fix v 
 show "((\<^bold>\<box>a \<^bold>\<and> \<^bold>\<box>b)(v) \<longrightarrow> (\<^bold>\<box>(a \<^bold>\<or> b))(v))"
 proof
  assume a1: "((\<^bold>\<box>a \<^bold>\<and> \<^bold>\<box>b))(v)" 
  have a2: "(\<^bold>\<box>a)(v) \<and> (\<^bold>\<box>b)(v)" by (simp add: a1)
  from a2 have a3: "(\<^bold>\<box>a)(v)" by (rule conjE)
  from a3 have a4: "\<forall>w. v r w \<longrightarrow> a(w)" by simp
  from a4 have a5: "\<forall>w. v r w \<longrightarrow> (a(w) \<or> b(w))" by simp
  from a5 show "(\<^bold>\<box>(a \<^bold>\<or> b))(v)" by simp
 qed
qed

lemma "\<lfloor>(\<^bold>\<box>a \<^bold>\<and> \<^bold>\<box>b) \<^bold>\<rightarrow> \<^bold>\<box>(a \<^bold>\<or> b)\<rfloor>" 
by simp

lemma "\<lfloor>(a \<^bold>\<and> \<^bold>\<box>b) \<^bold>\<rightarrow> \<^bold>\<diamond>(c \<^bold>\<or> b)\<rfloor>" 
nitpick oops

lemma "T_ax \<longrightarrow>(\<lfloor>(a \<^bold>\<and> \<^bold>\<box>b) \<^bold>\<rightarrow> \<^bold>\<diamond>(c \<^bold>\<or> b)\<rfloor>)" 
by blast



section {* Further Examples *}

text {* For a demonstration, we prove several formulae from the QMLTP \cite{Raths2012} using Isabelle's automated tools. *}

-- "QMLTP-v.1.1, SYM035+1.p; theorem in logic K"
lemma "\<lfloor>((\<^bold>\<forall>x . \<^bold>\<box>f(x)) \<^bold>\<and> (\<^bold>\<exists>y . \<^bold>\<diamond>g(y)) \<^bold>\<rightarrow> (\<^bold>\<exists>x . \<^bold>\<diamond>(f(x) \<^bold>\<and> g(x))))\<rfloor>"
by blast

-- "QMLTP-v.1.1, SYM012+1.p; in S4 (with semantic constraints)"
lemma "(\<lfloor>\<^bold>\<box>(\<^bold>\<forall>x. f(x) \<^bold>\<rightarrow> g(x)) \<^bold>\<rightarrow> ((\<^bold>\<forall>x . f(x)) \<^bold>\<rightarrow> (\<^bold>\<forall>x . g(x)))\<rfloor>)"
nitpick oops

lemma "T_sem \<longrightarrow> (\<lfloor>\<^bold>\<box>(\<^bold>\<forall>x. f(x) \<^bold>\<rightarrow> g(x)) \<^bold>\<rightarrow> ((\<^bold>\<forall>x . f(x)) \<^bold>\<rightarrow> (\<^bold>\<forall>x . g(x)))\<rfloor>)"
by simp

lemma "S4_sem \<longrightarrow> 
 (\<lfloor>\<^bold>\<box>(\<^bold>\<forall>x. f(x) \<^bold>\<rightarrow> g(x)) \<^bold>\<rightarrow> ((\<^bold>\<forall>x . f(x)) \<^bold>\<rightarrow> (\<^bold>\<forall>x . g(x)))\<rfloor>)"
by blast

-- "QMLTP-v.1.1, SYM039+1.p; in S5 (with semantic constraints)"
lemma "S5_sem \<longrightarrow> 
 (\<lfloor>\<^bold>\<box>(\<^bold>\<forall>X . f(X) \<^bold>\<rightarrow> \<^bold>\<box>(a \<^bold>\<rightarrow> \<^bold>\<not>f(X))) \<^bold>\<and> \<^bold>\<box>(\<^bold>\<exists>X . f(X) \<^bold>\<and> (\<^bold>\<box>(b \<^bold>\<rightarrow> f(X)))) \<^bold>\<rightarrow> \<^bold>\<not>(\<^bold>\<box>(a \<^bold>\<and> b))\<rfloor>)"
by meson

(*<*)
end
(*>*)