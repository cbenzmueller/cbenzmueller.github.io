(* Christoph Benzmüller, February 2016 *)

theory ScottOld
imports Main 

begin

section {* Introduction *}

 text {* Dana Scott's version \cite{ScottNotes} (cf.~Fig.~1)
 of G\"odel's proof of God's existence \cite{GoedelNotes} is 
 formalized in quantified modal logic KB (QML KB) within the proof assistant Isabelle/HOL. 
 QML KB is  modeled as a fragment of classical higher-order logic (HOL); 
 thus, the formalization is essentially a formalization in HOL. The employed embedding 
 of QML KB in HOL is adapting the work of Benzm\"uller and Paulson \cite{J23,B9}.
 Note that the QML KB formalization employs quantification over individuals and 
 quantification over sets of individuals (properties).

 The gaps in Scott's proof have been automated 
 with Sledgehammer \cite{Sledgehammer}, performing remote calls to the higher-order automated
 theorem prover LEO-II \cite{LEO-II}. Sledgehammer suggests the 
 Metis \cite{Metis} calls, which result in proofs that are verified by Isabelle/HOL.
 For consistency checking, the model finder Nitpick \cite{Nitpick} has been employed.
 The successfull calls to Sledgehammer
 are deliberately kept as comments in the file for demonstration purposes
 (normally, they are automatically eliminated by Isabelle/HOL).
 
 Isabelle is described in the textbook by Nipkow, 
 Paulson, and Wenzel \cite{Isabelle} and in tutorials available 
 at: \url{http://isabelle.in.tum.de}.
 
\subsection{Related Work}

 The formalization presented here is related to the THF \cite{J22} and 
 Coq \cite{Coq} formalizations at 
 \url{https://github.com/FormalTheology/GoedelGod/tree/master/Formalizations/}.
 
 An older ontological argument by Anselm was formalized in PVS by John Rushby \cite{rushby}.
*}

section {* An Embedding of QML KB in HOL *}

text {* The types @{text "i"} for possible worlds and $\mu$ for individuals are introduced. *}

  typedecl i    -- "the type for possible worlds" 
  typedecl \<mu>    -- "the type for indiviuals"      

text {* Possible worlds are connected by an accessibility relation @{text "r"}.*} 

  consts r :: "i \<Rightarrow> i \<Rightarrow> bool" (infixr "r" 70)    -- "accessibility relation r"   

text {* QML formulas are translated as HOL terms of type @{typ "i \<Rightarrow> bool"}. 
This type is abbreviated as @{text "\<sigma>"}. *}

  type_synonym \<sigma> = "(i \<Rightarrow> bool)"
 
text {* The classical connectives $\neg, \wedge, \rightarrow$, and $\forall$
(over individuals and over sets of individuals) and $\exists$ (over individuals) are
lifted to type $\sigma$. The lifted connectives are @{text "\<^bold>\<not>"}, @{text "\<^bold>\<and>"}, @{text "\<^bold>\<rightarrow>"},
@{text "\<^bold>\<forall>"}, and @{text "\<^bold>\<exists>"}. 
Other connectives can be introduced analogously. We exemplarily do this for @{text "\<^bold>\<or>"} and
@{text "\<^bold>\<leftrightarrow>"}. Moreover, the modal 
operators @{text "\<^bold>\<box>"} and @{text "\<^bold>\<diamond>"}  are introduced. Definitions could be used instead of 
abbreviations. *}

  abbreviation mnot :: "\<sigma> \<Rightarrow>\<sigma>" ("\<^bold>\<not>") where "\<^bold>\<not>\<phi> \<equiv> (\<lambda>w. \<not> \<phi> w)"    
  abbreviation mand :: "\<sigma> \<Rightarrow> \<sigma> \<Rightarrow> \<sigma>" (infixr"\<^bold>\<and>"51) where "\<phi> \<^bold>\<and> \<psi> \<equiv> (\<lambda>w. \<phi> w \<and> \<psi> w)"   
  abbreviation mor :: "\<sigma> \<Rightarrow> \<sigma> \<Rightarrow> \<sigma>" (infixr"\<^bold>\<or>"50) where "\<phi> \<^bold>\<or> \<psi> \<equiv> (\<lambda>w. \<phi> w \<or> \<psi> w)"   
  abbreviation mimplies :: "\<sigma> \<Rightarrow> \<sigma> \<Rightarrow> \<sigma>" (infixr"\<^bold>\<rightarrow>"49) where "\<phi> \<^bold>\<rightarrow> \<psi> \<equiv> (\<lambda>w. \<phi> w \<longrightarrow> \<psi> w)"  
  abbreviation mequiv:: "\<sigma> \<Rightarrow> \<sigma> \<Rightarrow> \<sigma>" (infixr"\<^bold>\<leftrightarrow>"48) where "\<phi> \<^bold>\<leftrightarrow> \<psi> \<equiv> (\<lambda>w. \<phi> w \<longleftrightarrow> \<psi> w)" 
  abbreviation mforall :: "('a \<Rightarrow> \<sigma>) \<Rightarrow> \<sigma>" ("\<^bold>\<forall>") where "\<^bold>\<forall>\<Phi> \<equiv> (\<lambda>w. \<forall>x. \<Phi> x w)"   
  abbreviation mallB:: "('a \<Rightarrow> \<sigma>) \<Rightarrow> \<sigma>" (binder"\<^bold>\<forall>"[8]9) where "\<^bold>\<forall>x. \<phi>(x) \<equiv> \<^bold>\<forall>\<phi>"   
  abbreviation mexists :: "('a \<Rightarrow> \<sigma>) \<Rightarrow> \<sigma>" ("\<^bold>\<exists>") where "\<^bold>\<exists>\<Phi> \<equiv> (\<lambda>w. \<exists>x. \<Phi> x w)"
  abbreviation mexiB:: "('a \<Rightarrow> \<sigma>) \<Rightarrow> \<sigma>" (binder"\<^bold>\<exists>"[8]9) where "\<^bold>\<exists>x. \<phi>(x) \<equiv> \<^bold>\<exists>\<phi>"  
  abbreviation mLeibeq :: "\<mu> \<Rightarrow> \<mu> \<Rightarrow> \<sigma>" (infixr"\<^bold>="52) where "x \<^bold>= y \<equiv> \<^bold>\<forall>(\<lambda>\<phi>. (\<phi> x \<^bold>\<rightarrow> \<phi> y))" 
  abbreviation mbox :: "\<sigma> \<Rightarrow> \<sigma>" ("\<^bold>\<box>") where "\<^bold>\<box> \<phi> \<equiv> (\<lambda>w. \<forall>v.  w r v \<longrightarrow> \<phi> v)"

  abbreviation mdia :: "\<sigma> \<Rightarrow> \<sigma>" ("\<^bold>\<diamond>") where "\<^bold>\<diamond> \<phi> \<equiv> (\<lambda>w. \<exists>v. w r v \<and> \<phi> v)" 
  
text {* For grounding lifted formulas, the meta-predicate @{text "valid"} is introduced. *}

  (*<*) no_syntax "_list" :: "args \<Rightarrow> 'a list" ("[(_)]") (*>*) 
  abbreviation valid :: "\<sigma> \<Rightarrow> bool" ("\<lfloor>_\<rfloor>") where "\<lfloor>p\<rfloor> \<equiv> \<forall>w. p w"
  
section {* G\"odel's Ontological Argument *}  
  
text {* Constant symbol @{text "P"} (G\"odel's `Positive') is declared. *}

  consts P :: "(\<mu> \<Rightarrow> \<sigma>) \<Rightarrow> \<sigma>"  

text {* The meaning of @{text "P"} is restricted by axioms @{text "A1(a/b)"}: $\all \phi 
[P(\neg \phi) \biimp \neg P(\phi)]$ (Either a property or its negation is positive, but not both.) 
and @{text "A2"}: $\all \phi \all \psi [(P(\phi) \wedge \nec \all x [\phi(x) \imp \psi(x)]) 
\imp P(\psi)]$ (A property necessarily implied by a positive property is positive). *}

  axiomatization where
    A1a: "\<lfloor>\<^bold>\<forall>\<Phi>. P(\<lambda>x. \<^bold>\<not>(\<Phi> x)) \<^bold>\<rightarrow> \<^bold>\<not> (P \<Phi>)\<rfloor>" and
    A1b: "\<lfloor>\<^bold>\<forall>\<Phi>. \<^bold>\<not> (P \<Phi>) \<^bold>\<rightarrow> P (\<lambda>x. \<^bold>\<not> (\<Phi> x))\<rfloor>" and
    A2:  "\<lfloor>\<^bold>\<forall>\<Phi>. \<^bold>\<forall>(\<lambda>\<Psi>. (P \<Phi> \<^bold>\<and> \<^bold>\<box> (\<^bold>\<forall>(\<lambda>x. \<Phi> x \<^bold>\<rightarrow> \<Psi> x))) \<^bold>\<rightarrow> P \<Psi>)\<rfloor>"

text {* We prove theorem T1: $\all \phi [P(\phi) \imp \pos \ex x \phi(x)]$ (Positive 
properties are possibly exemplified). T1 is proved directly by Sledgehammer with command @{text 
"sledgehammer [provers = remote_leo2]"}. 
Sledgehammer suggests to call Metis with axioms A1a and A2. 
Metis sucesfully generates a proof object 
that is verified in Isabelle/HOL's kernel. *}
 
  theorem T1: "\<lfloor>\<^bold>\<forall>\<Phi>. P \<Phi> \<^bold>\<rightarrow> \<^bold>\<diamond> (\<^bold>\<exists> \<Phi>)\<rfloor>"  
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis A1a A2)

text {* Next, the symbol @{text "G"} for `God-like'  is introduced and defined 
as $G(x) \biimp \forall \phi [P(\phi) \to \phi(x)]$ \\ (A God-like being possesses 
all positive properties). *} 

  definition G :: "\<mu> \<Rightarrow> \<sigma>" where "G = (\<lambda>x. \<^bold>\<forall>\<Phi>. P \<Phi> \<^bold>\<rightarrow> \<Phi> x)"   

text {* Axiom @{text "A3"} is added: $P(G)$ (The property of being God-like is positive).
Sledgehammer and Metis then prove corollary @{text "C"}: $\pos \ex x G(x)$ 
(Possibly, God exists). *} 
 
  axiomatization where A3:  "\<lfloor>P G\<rfloor>" 

  corollary C: "\<lfloor>\<^bold>\<diamond> (\<^bold>\<exists> G)\<rfloor>" 
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis A3 T1)

text {* Axiom @{text "A4"} is added: $\all \phi [P(\phi) \to \Box \; P(\phi)]$ 
(Positive properties are necessarily positive). *}

  axiomatization where A4:  "\<lfloor>\<^bold>\<forall>\<Phi>. P \<Phi> \<^bold>\<rightarrow> \<^bold>\<box> (P \<Phi>)\<rfloor>" 

text {* Symbol @{text "ess"} for `Essence' is introduced and defined as 
$$\ess{\phi}{x} \biimp \phi(x) \wedge \all \psi (\psi(x) \imp \nec \all y (\phi(y) 
\imp \psi(y)))$$ (An \emph{essence} of an individual is a property possessed by it and necessarily implying any of its properties). *}

  definition ess :: "(\<mu> \<Rightarrow> \<sigma>) \<Rightarrow> \<mu> \<Rightarrow> \<sigma>" (infixr "ess" 85) where
    "\<Phi> ess x = \<Phi> x \<^bold>\<and> \<^bold>\<forall>(\<lambda>\<Psi>. \<Psi> x \<^bold>\<rightarrow> \<^bold>\<box> (\<^bold>\<forall>(\<lambda>y. \<Phi> y \<^bold>\<rightarrow> \<Psi> y)))"

text {* Next, Sledgehammer and Metis prove theorem @{text "T2"}: $\all x [G(x) \imp \ess{G}{x}]$ \\
(Being God-like is an essence of any God-like being). *}

  theorem T2: "\<lfloor>\<^bold>\<forall>(\<lambda>x. G x \<^bold>\<rightarrow> G ess x)\<rfloor>"
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis A1b A4 G_def ess_def)

text {* Symbol @{text "NE"}, for `Necessary Existence', is introduced and
defined as $$\NE(x) \biimp \all \phi [\ess{\phi}{x} \imp \nec \ex y \phi(y)]$$ (Necessary 
existence of an individual is the necessary exemplification of all its essences). *}

  definition NE :: "\<mu> \<Rightarrow> \<sigma>" where "NE = (\<lambda>x. \<^bold>\<forall>\<Phi>. \<Phi> ess x \<^bold>\<rightarrow> \<^bold>\<box> (\<^bold>\<exists> \<Phi>))"

text {* Moreover, axiom @{text "A5"} is added: $P(\NE)$ (Necessary existence is a positive 
property). *}

  axiomatization where A5:  "\<lfloor>P NE\<rfloor>"

text {* The @{text "B"} axiom (symmetry) for relation r is stated. @{text "B"} is needed only 
for proving theorem T3 and for corollary C2. *}

  axiomatization where sym: "x r y \<longrightarrow> y r x" 

text {* Finally, Sledgehammer and Metis prove the main theorem @{text "T3"}: $\nec \ex x G(x)$ \\
(Necessarily, God exists). *}

  theorem T3: "\<lfloor>\<^bold>\<box> (\<^bold>\<exists> G)\<rfloor>" 
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis A5 C T2 sym G_def NE_def)

text {* Surprisingly, the following corollary can be derived even without the @{text "T"} axiom 
(reflexivity). *}

  corollary C2: "\<lfloor>\<^bold>\<exists> G\<rfloor>" 
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis T1 T3 G_def sym)

text {* The consistency of the entire theory is confirmed by Nitpick. *}

  lemma True nitpick [satisfy, user_axioms, expect = genuine] oops


section {* Additional Results on G\"odel's God. *}  

text {* G\"odel's God is flawless: (s)he does not have non-positive properties. *}

  theorem Flawlessness: "\<lfloor>\<^bold>\<forall>\<Phi>. \<^bold>\<forall>(\<lambda>x. (G x \<^bold>\<rightarrow> (\<^bold>\<not> (P \<Phi>) \<^bold>\<rightarrow> \<^bold>\<not> (\<Phi> x))))\<rfloor>"
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis A1b G_def) 
  
text {* There is only one God: any two God-like beings are equal. *}   
  
  theorem Monotheism: "\<lfloor>\<^bold>\<forall>(\<lambda>x.\<^bold>\<forall>(\<lambda>y. (G x \<^bold>\<rightarrow> (G y \<^bold>\<rightarrow> (x \<^bold>= y)))))\<rfloor>"
  -- {* sledgehammer [provers = remote\_leo2] *}
  by (metis Flawlessness G_def) 

section {* Modal Collapse *}  

text {* G\"odel's axioms have been criticized for entailing the so-called 
modal collapse. The prover Satallax \cite{Satallax} confirms this. 
However, sledgehammer is not able to determine which axioms, 
definitions and previous theorems are used by Satallax;
hence it suggests to call Metis using everything, but this (unsurprinsingly) fails.
Attempting to use `Sledegehammer min' to minimize Sledgehammer's suggestion does not work.
Calling Metis with @{text "T2"}, @{text "T3"} and @{text "ess_def"} also does not work. *} 

  lemma MC: "\<lfloor>\<^bold>\<forall>\<Phi>.(\<Phi> \<^bold>\<rightarrow> (\<^bold>\<box> \<Phi>))\<rfloor>"  
  sledgehammer [provers = remote_satallax, verbose, timeout = 600]
  -- {* by (metis T2 T3 ess\_def) *}
  -- {* by (meson T2 T3 ess_def) *}
  oops

(*<*) 
end
(*>*) 