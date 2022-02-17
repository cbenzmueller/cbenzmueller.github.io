(*<*) 
theory SIXTEEN
imports Main Set

begin
(*>*) 

section {* Embedding of SIXTEEN into HOL *}

text {* This file contains an semantic embedding of the many-valued logic SIXTEEN
        into classical higher-order logic (HOL).
        This files was created by Alexander Steen with the help of
        Christoph Benzmüller.
       
        Alexander Steen, Freie Universität Berlin, July 2015. *}

text {* The type synonym \<tau> is introduced, that models the generalized truth values as
        sets of sets of Booleans, hence of type (bool \<Rightarrow> bool) \<Rightarrow> bool.
        The sets of Isabelle/HOL generate some fact overhead and are therefore not used. *}

type_synonym \<tau> = "(bool => bool) => bool" -- "type of generalized truth values"

text {* In the following, the list of all 16 generalized truth values is given.
        We chose abbreviations rather than definitions since the latter produces
        irrelevant facts while the former does not. *}

(** Shorthands for alle 16 quasitruth values **)
abbreviation n :: "'a => bool" ("N") where "N \<equiv> \<lambda>x. False" -- "\<emptyset>"
abbreviation nn :: \<tau> ("\<N>") where "\<N> \<equiv> \<lambda>x. \<not>(x False) \<and> \<not>(x True)"  -- "{\<emptyset>}"
abbreviation ff :: \<tau> ("\<F>") where "\<F> \<equiv> \<lambda>x. (x False) \<and> \<not>(x True)" -- "{{False}}"
abbreviation tt :: \<tau> ("\<T>") where "\<T> \<equiv> \<lambda>x. \<not>(x False) \<and> (x True)"  -- "{{True}}"
abbreviation bb :: \<tau> ("\<B>") where "\<B> \<equiv> \<lambda>x. (x False) \<and> (x True)" -- "{{False, True}}"

abbreviation nf :: \<tau> ("NF") where "NF \<equiv> \<lambda>x. \<not>(x True)" -- "{\<emptyset>, {False}}"
abbreviation nt :: \<tau> ("NT") where "NT \<equiv> \<lambda>x. \<not>(x False)" -- "{\<emptyset>, {True}}"
abbreviation nb :: \<tau> ("NB") where "NB \<equiv> \<lambda>x. ((x False) \<and> (x True)) \<or> (\<not>(x False) \<and> \<not>(x True))" -- "{\<emptyset>, {False, True}}"
abbreviation ft :: \<tau> ("FT") where "FT \<equiv> \<lambda>x. ((x False) \<and> \<not>(x True)) \<or> ((x True) \<and> \<not>(x False))" -- "{{False},{True}}"
abbreviation fb :: \<tau> ("FB") where "FB \<equiv> \<lambda>x. (x False)" -- "{{False},{False, True}}"
abbreviation tb :: \<tau> ("TB") where "TB \<equiv> \<lambda>x. (x True)" -- "{{True},{False,True}}"

abbreviation nft :: \<tau> ("NFT") where "NFT \<equiv> \<lambda>x. \<not>(x True) \<or> \<not>(x False)" -- "{\<emptyset>, {False}, {True}}"
abbreviation nfb :: \<tau> ("NFB") where "NFB \<equiv> \<lambda>x. \<not>(x True) \<or> (x False)" -- "{\<emptyset>, {False}, {False, True}}"
abbreviation ntb :: \<tau> ("NTB") where "NTB \<equiv> \<lambda>x. \<not>(x False) \<or> (x True)" -- "{\<emptyset>, {True}, {False, True}}"
abbreviation ftb :: \<tau> ("FTB") where "FTB \<equiv> \<lambda>x. (x True) \<or> (x False)" -- "{{False}, {True}, {False, True}}"

abbreviation all :: \<tau> ("All") where "All \<equiv> \<lambda>x. True" -- "{\<emptyset>, {False}, {True}, {False, True}} = \<P>(\<P>({True, False}))"

text {* As in the textbook, the truthful/truthless/... subsets are used to define
        the ordering relation between the generalzed truth values. *}

abbreviation truthful_subset :: "\<tau> \<Rightarrow> \<tau>" ("(_)\<^sup>t") where "a\<^sup>t \<equiv> \<lambda>x. (a x) \<and> (x True)" -- "{x. x \<in> a \<and> True \<in> x}"
abbreviation truthless_subset :: "\<tau> \<Rightarrow> \<tau>" ("(_)\<^sup>-\<^sup>t") where "a\<^sup>-\<^sup>t \<equiv> \<lambda>x. (a x) \<and> \<not>(x True)" -- "{x. x \<in> a \<and> True \<notin> x}"
abbreviation falsityful_subset :: "\<tau> \<Rightarrow> \<tau>" ("(_)\<^sup>f") where "a\<^sup>f \<equiv> \<lambda>x. (a x) \<and> (x False)" -- "{x. x \<in> a \<and> False \<in> x}"
abbreviation falsityless_subset :: "\<tau> \<Rightarrow> \<tau>" ("(_)\<^sup>-\<^sup>f") where "a\<^sup>-\<^sup>f \<equiv> \<lambda>x. (a x) \<and> \<not>(x False)" -- "{x. x \<in> a \<and> False \<notin> x}"

(** ordering relations for the tri-lattice, not really important here **)
definition ord_i :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> bool" (infixr "\<le>\<^sub>i" 70) where "x \<le>\<^sub>i y \<equiv> \<forall>a. (x a) \<longrightarrow> (y a)"
definition ord_t :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> bool" (infixr "\<le>\<^sub>t" 70) where "x \<le>\<^sub>t y \<equiv> \<forall>a. (((x\<^sup>t) a) \<longrightarrow> ((y\<^sup>t) a)) \<and> (((y\<^sup>-\<^sup>t) a) \<longrightarrow> ((x\<^sup>-\<^sup>t) a))"
definition ord_f :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> bool" (infixr "\<le>\<^sub>f" 70) where "x \<le>\<^sub>f y \<equiv> \<forall>a. (((x\<^sup>f) a) \<longrightarrow> ((y\<^sup>f) a)) \<and> (((y\<^sup>-\<^sup>f) a) \<longrightarrow> ((x\<^sup>-\<^sup>f) a))"

text {* Inverse and join functions for t-axis (ordering \<le>\<^sub>t).
        Inverse can be described by {y \<union> {True}| y. y \<in> (x\<^sup>-\<^sup>t)} \<union> {y - {True}| y. y \<in> (x\<^sup>t)}. *}

(** I1: this one performs quite nicely in satallax *)
definition inverse_t :: "\<tau> \<Rightarrow> \<tau>" ("~\<^sub>t(_)") where "~\<^sub>t a \<equiv> \<lambda>x. (a (\<lambda>y.
                                                                  ((\<not>y) \<longrightarrow> (x False)) \<and>
                                                                   (y \<longrightarrow> \<not>(x True)) ))"

(** I2: this one performs very poorly in satallax **)
(*definition inverse_t :: "\<tau> \<Rightarrow> \<tau>" ("~t(_)") where "~t a \<equiv> \<lambda>x. \<exists>y. a y
                                                          \<and> ((y False) \<longleftrightarrow> (x False))
                                                          \<and> ((y True) \<longleftrightarrow> \<not>(x True))" *)

text {* Analogously for f-axis.  *}
definition inverse_f :: "\<tau> \<Rightarrow> \<tau>" ("~\<^sub>f(_)") where "~\<^sub>f a \<equiv> \<lambda>x. (a (\<lambda>y.
                                                                  ((\<not>y) \<longrightarrow> \<not>(x False)) \<and>
                                                                   (y \<longrightarrow> (x True)) ))"

text {* meet and join for two quasi truth values *}

(* union and intersection only neede for definition of join_t *)
abbreviation union :: "('a \<Rightarrow> bool) \<Rightarrow> ('a \<Rightarrow> bool) \<Rightarrow> ('a \<Rightarrow> bool)" (infixr "\<union>\<^sub>s" 51) where "s \<union>\<^sub>s t \<equiv> \<lambda>x. s x \<or> t x"   
abbreviation intersection :: "('a \<Rightarrow> bool) \<Rightarrow> ('a \<Rightarrow> bool) \<Rightarrow> ('a \<Rightarrow> bool)" (infixr "\<inter>\<^sub>s" 51) where "s \<inter>\<^sub>s t \<equiv> \<lambda>x. s x \<and> t x"
abbreviation elem :: "'a => ('a \<Rightarrow> bool) \<Rightarrow> bool" (infixr "\<in>s" 50) where "x \<in>s s \<equiv> s x"


definition join_t :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<squnion>\<^sub>t" 60) where "x \<squnion>\<^sub>t y \<equiv> (x\<^sup>t) \<union>\<^sub>s (y\<^sup>t) \<union>\<^sub>s ((x\<^sup>-\<^sup>t) \<inter>\<^sub>s (y\<^sup>-\<^sup>t))"
definition join_f :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<squnion>\<^sub>f" 60) where "x \<squnion>\<^sub>f y \<equiv> (x\<^sup>f) \<union>\<^sub>s (y\<^sup>f) \<union>\<^sub>s ((x\<^sup>-\<^sup>f) \<inter>\<^sub>s (y\<^sup>-\<^sup>f))"

definition meet_t :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<sqinter>\<^sub>t" 60) where "x \<sqinter>\<^sub>t y \<equiv> ((x\<^sup>t) \<inter>\<^sub>s (y\<^sup>t)) \<union>\<^sub>s (x\<^sup>-\<^sup>t) \<union>\<^sub>s (y\<^sup>-\<^sup>t)"
definition meet_f :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<sqinter>\<^sub>f" 60) where "x \<sqinter>\<^sub>f y \<equiv> ((x\<^sup>f) \<inter>\<^sub>s (y\<^sup>f)) \<union>\<^sub>s (x\<^sup>-\<^sup>f) \<union>\<^sub>s (y\<^sup>-\<^sup>f)"


section {*Metalogical results for operators within the embedded SIXTEEN *}

abbreviation T :: "bool \<Rightarrow> bool" ("T") where "T \<equiv> \<lambda>x. x"  -- "{True}"
abbreviation B :: "bool \<Rightarrow> bool" ("B") where "B \<equiv> \<lambda>x. True"  -- "{True, False}"
abbreviation F :: "bool \<Rightarrow> bool" ("F") where "F \<equiv> \<lambda>x. \<not>x"  -- "{False}"

text {* Proposition 3.2  (Truth and Falsehood, p. 57) *}

text {* \<sqinter>\<^sub>t-part of prop. 3.2 *}
lemma prop321T:  "\<forall>s. \<forall>t.  (((T \<in>s s) \<and> (T \<in>s t)) \<longleftrightarrow> (T \<in>s (s \<sqinter>\<^sub>t t)))"
by (metis meet_t_def)

lemma prop321B:  "\<forall>s. \<forall>t.  (((B \<in>s s) \<and> (B \<in>s t)) \<longleftrightarrow> (B \<in>s (s \<sqinter>\<^sub>t t)))"
by (metis meet_t_def)

lemma prop321F:  "\<forall>s. \<forall>t.  (((F \<in>s s) \<or> (F \<in>s t)) \<longleftrightarrow> (F \<in>s (s \<sqinter>\<^sub>t t)))"
by (metis meet_t_def)

lemma prop321N:  "\<forall>s. \<forall>t.  (((N \<in>s s) \<or> (N \<in>s t)) \<longleftrightarrow> (N \<in>s (s \<sqinter>\<^sub>t t)))"
by (metis meet_t_def)

text {* \<squnion>\<^sub>t-part of prop. 3.2 *}
lemma prop322T: "\<forall>s. \<forall>t. (((T \<in>s s) \<or> (T \<in>s t)) \<longleftrightarrow> (T \<in>s (s \<squnion>\<^sub>t t)))"
by (metis join_t_def)

lemma prop322B: "\<forall>s. \<forall>t.  (((B \<in>s s) \<or> (B \<in>s t)) \<longleftrightarrow> (B \<in>s (s \<squnion>\<^sub>t t)))"
by (metis join_t_def)

lemma prop322F: "\<forall>s. \<forall>t.  (((F \<in>s s) \<and> (F \<in>s t)) \<longleftrightarrow> (F \<in>s (s \<squnion>\<^sub>t t)))"
by (metis join_t_def)

lemma prop322N: "\<forall>s. \<forall>t.  (((N \<in>s s) \<and> (N \<in>s t)) \<longleftrightarrow> (N \<in>s (s \<squnion>\<^sub>t t)))"
by (metis join_t_def)

text {* \<squnion>\<^sub>f-part of prop. 3.2 *}
lemma prop323T: "\<forall>s. \<forall>t.  (((T \<in>s s) \<and> (T \<in>s t)) \<longleftrightarrow> (T \<in>s (s \<squnion>\<^sub>f t)))"
by (metis join_f_def)

lemma prop323N: "\<forall>s. \<forall>t.  (((N \<in>s s) \<and> (N \<in>s t)) \<longleftrightarrow> (N \<in>s (s \<squnion>\<^sub>f t)))"
by (metis join_f_def)

lemma prop323F: "\<forall>s. \<forall>t.  (((F \<in>s s) \<or> (F \<in>s t)) \<longleftrightarrow> (F \<in>s (s \<squnion>\<^sub>f t)))"
by (metis join_f_def)

lemma prop323B: "\<forall>s. \<forall>t.  (((B \<in>s s) \<or> (B \<in>s t)) \<longleftrightarrow> (B \<in>s (s \<squnion>\<^sub>f t)))"
by (metis join_f_def)

text {* \<sqinter>\<^sub>f-part of prop. 3.2 *}
lemma prop324T:  "\<forall>s. \<forall>t.  (((T \<in>s s) \<or> (T \<in>s t)) \<longleftrightarrow> (T \<in>s (s \<sqinter>\<^sub>f t)))"
by (metis meet_f_def)

lemma prop324N:  "\<forall>s. \<forall>t.  (((N \<in>s s) \<or> (N \<in>s t)) \<longleftrightarrow> (N \<in>s (s \<sqinter>\<^sub>f t)))"
by (metis meet_f_def)

lemma prop324F:  "\<forall>s. \<forall>t.  (((F \<in>s s) \<and> (F \<in>s t)) \<longleftrightarrow> (F \<in>s (s \<sqinter>\<^sub>f t)))"
by (metis meet_f_def)

lemma prop324B:  "\<forall>s. \<forall>t.  (((B \<in>s s) \<and> (B \<in>s t)) \<longleftrightarrow> (B \<in>s (s \<sqinter>\<^sub>f t)))"
by (metis meet_f_def)


text {* Checking definitions of inversion against Def. 3.6  (Truth and Falsehood, p. 58) *}

text {* t-inversion part of Def. 3.6. *}
lemma def361a: "\<forall>a. \<forall>b. (a \<le>\<^sub>t b) \<longrightarrow> ((~\<^sub>t b) \<le>\<^sub>t (~\<^sub>t a))"
by (smt ext inverse_t_def ord_t_def)


lemma def361b: "\<forall>a. \<forall>b. (a \<le>\<^sub>f b) \<longrightarrow> ((~\<^sub>t a) \<le>\<^sub>f (~\<^sub>t b))"
by (smt ext inverse_t_def ord_f_def)

lemma def361c: "\<forall>a. \<forall>b. (a \<le>\<^sub>i b) \<longrightarrow> ((~\<^sub>t a) \<le>\<^sub>i (~\<^sub>t b))"
by (smt ext inverse_t_def ord_i_def)


lemma def361d: "\<forall>a. (~\<^sub>t (~\<^sub>t a)) = a"
oops
(*by (metis ext inverse_t_def)*)

text {* f-inversion part of Def. 3.6. *}

lemma def362a: "\<forall>a. \<forall>b. (a \<le>\<^sub>f b) \<longrightarrow> ((~\<^sub>f a) \<le>\<^sub>t (~\<^sub>f b))"
oops

lemma def362b: "\<forall>a. \<forall>b. (a \<le>\<^sub>f b) \<longrightarrow> ((~\<^sub>f b) \<le>\<^sub>f (~\<^sub>f a))"
by (smt ext inverse_f_def ord_f_def)

lemma def362c: "\<forall>a. \<forall>b. (a \<le>\<^sub>f b) \<longrightarrow> ((~\<^sub>f a) \<le>\<^sub>i (~\<^sub>f b))"
oops  

lemma def362d: "\<forall>a. (~\<^sub>f (~\<^sub>f a)) = a"
oops

text {* Proposition 3.4  (Truth and Falsehood, p. 59) *}

text {* t-inversion part of prop. 3.4 *}
lemma prop341T: "\<forall>s. (T \<in>s ~\<^sub>t x) \<longleftrightarrow> (N \<in>s x)"
(*sledgehammer [provers=satallax, timeout=60]*)
oops
(*by (metis ext inverse_t_def)*)

lemma prop341N: "\<forall>s. (N \<in>s ~\<^sub>t x) \<longleftrightarrow> (T \<in>s x)"
(*sledgehammer [provers=satallax, timeout=60]*)
oops
(*by (metis ext inverse_t_def)*)

lemma prop341F: "\<forall>s. (F \<in>s ~\<^sub>t x) \<longleftrightarrow> (B \<in>s x)"
(*sledgehammer [provers=satallax, timeout=60]*)
oops
(*by (metis ext inverse_t_def)*)

lemma prop341B: "\<forall>s. (B \<in>s ~\<^sub>t x) \<longleftrightarrow> (F \<in>s x)"
(*sledgehammer [provers=satallax, timeout=60]*)
oops
(*by (metis ext inverse_t_def)*)

section {* Language L_t *}

abbreviation not_t :: "\<tau> \<Rightarrow> \<tau>" ("\<not>\<^sub>t") where "\<not>\<^sub>t x \<equiv> ~\<^sub>t x"
abbreviation or_t :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<or>\<^sub>t" 40) where "x \<or>\<^sub>t y \<equiv> x \<squnion>\<^sub>t y"
abbreviation and_t :: "\<tau> \<Rightarrow> \<tau> \<Rightarrow> \<tau>" (infixr "\<and>\<^sub>t" 41) where "x \<and>\<^sub>t y \<equiv> \<not>\<^sub>t (\<not>\<^sub>t x \<or>\<^sub>t \<not>\<^sub>t y)"

end
