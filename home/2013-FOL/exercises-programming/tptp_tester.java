

import java.io.*;
import java.util.LinkedList;
import java.util.ListIterator;
import java.util.Hashtable;
import java.lang.Exception;


/** This is a program to test TPTP file for being syntactically and 
 *  semantically correct.
 *    
 *   The invocation is:
 *   tptp_tester [-o output_file] [-I include_dir] input_file
 *   tptp_tester -h
 *   
 *     input_file -- an input TPTP file to be checked
 *     -h -- prints help message and exits
 *     -o output_file -- outputs the parsed tree into output_file
 *     -I include_dir -- specifies where to look for included files;
 *         if -I is ommited, all include directives will be ignored\n\n
 *
 *     
 *  @author Andrei Tchaltsev
 *  @author Alexandre Riazanov
 *  @since Mar 26, 2006
 *  @since Apr 19, 2006, parsing of includes was added by Alexandre Riazanov
 *     
 */
public class tptp_tester {

    public static void help_print() {
	System.out.print(
         "This is a program to test TPTP file for being syntactically correct.\n"+
         "The invocation is:\n"+
         "  tptp_tester [-h] [-o output_file] [-I include_dir] input_file\n"+
	 "  tptp_tester -h\n\n"+
         "   input_file -- an input TPTP file to be checked\n"+
         "   -h -- tells the program to print help message and exit\n"+
         "   -o output_file -- tells the program to output the parsed formulas/clauses into output_file\n" +
	 "   -I include_dir -- specifies where to look for included files; " +
	 "                     if -I is ommited, all include directives will be ignored\n\n"
         );
	return;
    }
	
    public static void main(String[] args) 
	{
	String inFile = null; /* name of the input file */
	String outFile = null; /* name of the output file */
	String includeDir = null; 
        try {
	     
             /* process the command line options */
	     /* there is input file */
	     if (args.length == 1 && !args[0].equals("-h")) {
	       inFile = args[0];
	     }   
	     /* there are input and output files */
	     else if (args.length == 3 && args[0].equals("-o")) {
	       outFile = args[1];
	       inFile = args[2];
	     }
	     /* there is an input file and an include directory */
	     else if (args.length == 3 && args[0].equals("-I")) {
	       inFile = args[2];
	       includeDir = args[1];
	     }
	     /* there are input and output files, and an include directory */
	     else if (args.length == 5 && args[0].equals("-o") && args[2].equals("-I")) {
	       outFile = args[1];
	       includeDir = args[3];
	       inFile = args[4];
	     }
	     /* there are input and output files, and an include directory */
	     else if (args.length == 5 && args[2].equals("-o") && args[0].equals("-I")) {
	       outFile = args[3];
	       includeDir = args[1];
	       inFile = args[4];
	     }
	     else { /* print the help message and exit */ 
		help_print();
		return;
	     }
		
	     /* check the input file for existence.
	        This check is done just to output nicer error messages 
	     */
	     {
	       File file = new File(inFile);
	       if (!file.isFile()) {
	          System.err.print("Error: cannot find an input file \""
		                 + inFile + "\"\n");
	          return;
	       }
	       if (!file.canRead()) {
	          System.err.print("Error: cannot read an input file \""
		                 + inFile + "\"\n");
	          return;
	       }
	     }

             /* the whole output of the parser */
	     LinkedList<SimpleTptpParserOutput.TopLevelItem> allParsed = 
		 new LinkedList<SimpleTptpParserOutput.TopLevelItem>();

	     /* create a parser output object */
	     SimpleTptpParserOutput outputManager = new SimpleTptpParserOutput();
	     
	     /* prepare the symbol table for semantic checks */

	     _signature.put(new String("="),new SymbolDescriptor(true,2)); // "=" is a binary predicate 

	     /* parse the input file and semantically check the results */
	     
	     parseAndCheck(inFile,includeDir,outputManager,allParsed,0);
	     
	     System.out.println("File \"" + inFile + "\" is OK");

	     /* printing the parsed formulas/clauses to a file*/
	     if (outFile != null) {           
	       FileOutputStream out = new FileOutputStream(outFile);
	       for (TptpParserOutput.TptpInput iter : allParsed) {
	          out.write(("\n" + iter.toString()).getBytes());
	       } /* for */
	       System.out.println("Parsed formulas/clauses were printed to \"" + outFile + "\"");
	       out.close();
	     } /* if */


	     // ********************************************************************************* //
	     // Added by Christoph Benzmueller, Sep 2012
	     // ********************************************************************************* //
	     for (SimpleTptpParserOutput.TopLevelItem iter : allParsed) {
		 demoExample(iter,outputManager);
	     }             

	}
         // general ANTLR exception. It is enough to catch all ANTRL exceptions
	catch(antlr.ANTLRException e) {
            System.err.println("\nERROR during parsing \"" + inFile + "\": "+e);
	}
        // general exception. it is enough to catch all exceptions.
  catch(Exception e) { // general exception
            System.err.println("\nGENERAL exception: "+e);
	}
    } /* end of main function */

    
    /** Parses the file <strong> fileName </strong> and checks the results semantically.
     *  If <strong> includeDir </strong> != null, included files are parsed recursively
     *  as soon as they appear.
     */
    private 
    static 
    void parseAndCheck(String fileName,
		       String includeDir,
		       SimpleTptpParserOutput outputManager,
		       LinkedList<SimpleTptpParserOutput.TopLevelItem> results,
		       int recursionDepth) 
	throws Exception
	{
	    FileInputStream in = new FileInputStream(fileName);
	    TptpLexer lexer = new TptpLexer(new DataInputStream(in));
	    TptpParser parser = new TptpParser(lexer);
	       
	    for (SimpleTptpParserOutput.TopLevelItem item = 
		     (SimpleTptpParserOutput.TopLevelItem)parser.topLevelItem(outputManager);
		 item != null;
		 item = (SimpleTptpParserOutput.TopLevelItem)parser.topLevelItem(outputManager))
	    {
		if (includeDir != null &&
		    item.getKind() == TptpParserOutput.TptpInput.Kind.Include)
		{		    
		    if (recursionDepth >= 1024)
			throw new Exception("Too many nested include directives (depth > 1024) " +
					    "in " + fileName + ", line " + item.getLineNumber() + ".");

		    String relativeIncludeFileName = 
			((SimpleTptpParserOutput.IncludeDirective)item).getFileName();
		    
		    // The file name has to be truncated because it is quoted
		    
		    relativeIncludeFileName = 
			relativeIncludeFileName.substring(1,
							  relativeIncludeFileName.length() - 1);

		    String includeFileName =  
			includeDir + "/" + relativeIncludeFileName;

		    parseAndCheck(includeFileName,
				  includeDir,
				  outputManager,
				  results,
				  recursionDepth + 1);
		}
		else
		{
		    /* Minimal semantic analysis: check that no symbol is used
		       both as a predicate and as a function or constant, and that 
		       no symbol is used with different arities.
		       checkSemantically(item) will throw 
		       java.lang.Exception(<error description>) if something is wrong 
		       with the item.
		    */	     
		    checkSemantically(item,fileName);

		    results.add(item);
		};
	    };

	    in.close();

	} // parseAndCheck(..)



    /** Checks whether <strong> item </strong> is semantically well-formed 
     *  wrt the signature <strong> _signature </strong>. 
     *  Throws java.lang.Exception(<error description>) if the use of some symbol
     *  in <strong> item </strong> is inconsistent with its declaration in  
     *  <strong> _signature </strong>. Side effect: new symbols are declared in 
     *  <strong> _signature </strong>.
     *  @param item != null
     *  @param fileName file name to be used in error messages
     */
    private 
    static void checkSemantically(SimpleTptpParserOutput.TopLevelItem item,
				  String fileName) 
	throws Exception
	{
	assert item != null;

	_semanticCheckFileName = fileName;
	_semanticCheckLineNumber = item.getLineNumber();

	switch (item.getKind()) {
	    case Formula: 
		checkSemantically(((SimpleTptpParserOutput.AnnotatedFormula)item).getFormula()); 
		break;
	    case Clause: 
		checkSemantically(((SimpleTptpParserOutput.AnnotatedClause)item).getClause()); 
		break;
	    case Include: break; // nothing to check
	} 
    } // checkSemantically(SimpleTptpParserOutput.TopLevelItem item)



    /** Auxilliary for 
     *  checkSemantically(SimpleTptpParserOutput.TopLevelItem item,String fileName):
     *  checks whether <strong> formula </strong> is semantically well-formed 
     *  wrt the signature <strong> _signature </strong>. Side effect: new symbols are 
     *  declared in <strong> _signature </strong>.
     */
    private 
    static void checkSemantically(SimpleTptpParserOutput.Formula formula)
	throws Exception
	{

	switch (formula.getKind()) {	    
	    case Atomic: 
		checkSemantically((SimpleTptpParserOutput.Formula.Atomic)formula);
		break;
	    case Negation: 
		checkSemantically(((SimpleTptpParserOutput.Formula.Negation)formula).getArgument());
		break;
	    case Binary: 
		checkSemantically(((SimpleTptpParserOutput.Formula.Binary)formula).getLhs());
		checkSemantically(((SimpleTptpParserOutput.Formula.Binary)formula).getRhs());
		break;
	    case Quantified: 
		checkSemantically(((SimpleTptpParserOutput.Formula.Quantified)formula).getMatrix());
		break;
	} 
    } // checkSemantically(SimpleTptpParserOutput.Formula formula)

    
    /** Auxilliary for 
     *  checkSemantically(SimpleTptpParserOutput.TopLevelItem item,String fileName):
     *  checks whether <strong> formula </strong> is semantically well-formed 
     *  wrt the signature <strong> _signature </strong>. Side effect: new symbols are 
     *  declared in <strong> _signature </strong>.
     */
    private 
    static void checkSemantically(SimpleTptpParserOutput.Clause clause) 
	throws Exception
	{
	
	if (clause.getLiterals() != null) {
	  
	    for (SimpleTptpParserOutput.Literal lit : clause.getLiterals()) 
		checkSemantically(lit.getAtom());

	};
    } // checkSemantically(SimpleTptpParserOutput.Clause clause)


    /** Auxilliary for 
     *  checkSemantically(SimpleTptpParserOutput.TopLevelItem item,String fileName):
     *  checks whether <strong> formula </strong> is semantically well-formed 
     *  wrt the signature <strong> _signature </strong>. Side effect: new symbols are 
     *  declared in <strong> _signature </strong>.
     */
    private 
    static void checkSemantically(SimpleTptpParserOutput.Formula.Atomic atom)
	throws Exception
	{
	
	String predicate = atom.getPredicate();

	int arity = atom.getNumberOfArguments();
	
	// Look up this symbol in the signature:
	SymbolDescriptor predicateDescriptor = _signature.get(predicate);
	
	if (predicateDescriptor == null) {
	    // New symbol, has to be added to _signature
	    _signature.put(predicate,new SymbolDescriptor(true,arity));
	}
	else
	{
	    if (!predicateDescriptor.isPredicate) {
		throw new Exception("Semantic error in " + _semanticCheckFileName +
				    ", line " + _semanticCheckLineNumber + ":" +
				    "in atom " + atom + ": predicate " + 
				    predicate + " was used as a function elsewhere.");
	    };

	    if (predicateDescriptor.arity != arity) {
		throw new Exception("Semantic error in " + _semanticCheckFileName +
				    ", line " + _semanticCheckLineNumber + ":" +
				    "in atom " + atom + ": predicate " + 
				    predicate + " was used with a different arity elsewhere.");
	    };
	};

	// Check the arguments
	
	if (atom.getArguments() != null)
	    for (SimpleTptpParserOutput.Term arg : atom.getArguments())
		checkSemantically(arg);
       
    } // checkSemantically(SimpleTptpParserOutput.Formula.Atomic atom)
    

    /** Auxilliary for 
     *  checkSemantically(SimpleTptpParserOutput.TopLevelItem item,String fileName):
     *  checks whether <strong> formula </strong> is semantically well-formed 
     *  wrt the signature <strong> _signature </strong>. Side effect: new symbols are 
     *  declared in <strong> _signature </strong>.
     */
    private 
    static void checkSemantically(SimpleTptpParserOutput.Term term) 
	throws Exception
	{
	
	if (!term.getTopSymbol().isVariable()) {

	    String function = term.getTopSymbol().getText();

	    int arity = term.getNumberOfArguments();

	    // Look up the function symbol in the signature
	    SymbolDescriptor functionDescriptor = _signature.get(function);

	    if (functionDescriptor == null) {
		// New symbol, has to be added to _signature
		_signature.put(function,new SymbolDescriptor(false,arity));
	    }
	    else
	    {
		if (functionDescriptor.isPredicate)  {
		    throw new Exception("Semantic error in " + _semanticCheckFileName +
					", line " + _semanticCheckLineNumber + ":" +
					"in term " + term + ": function " + 
					function + " was used as a predicate elsewhere.");
		};

		if (functionDescriptor.arity != arity) {
		    throw new Exception("Semantic error in " + _semanticCheckFileName +
					", line " + _semanticCheckLineNumber + ":" +
					"in term " + term + ": function " + 
					function + 
					" was used with a different arity elsewhere.");
		};
	    };
	    	    

	    // Check the arguments
	
	    if (term.getArguments() != null)
		for (SimpleTptpParserOutput.Term arg : term.getArguments())
		    checkSemantically(arg);

	}; // if (!term.getTopSymbol().isVariable())
    } // checkSemantically(SimpleTptpParserOutput.Term term)


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // See Fitting p.13
    private 
	static int formulaDegreeAsInFitting(SimpleTptpParserOutput.Formula formula)
    {
	int res = 0;
	switch (formula.getKind()) {	    
	case Atomic: 
	    res = 1;
	    break;
	case Negation: 
            int argdepth = formulaDegreeAsInFitting(((SimpleTptpParserOutput.Formula.Negation)formula).getArgument());
	    res = 1 + argdepth;
	    break;
	case Binary: 
            int argldepth = formulaDegreeAsInFitting(((SimpleTptpParserOutput.Formula.Binary)formula).getLhs());
            int argrdepth = formulaDegreeAsInFitting(((SimpleTptpParserOutput.Formula.Binary)formula).getRhs());
	    res = 1 + argldepth + argrdepth;
	    break;
	case Quantified: 
	    int matrixdepth = formulaDegreeAsInFitting(((SimpleTptpParserOutput.Formula.Quantified)formula).getMatrix());
	    res = 1 + matrixdepth;
	    break;
	}
	return res;
    } 

 
    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is $true
    private 
	static boolean isTrue(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Atomic:
	    String pred = ((SimpleTptpParserOutput.Formula.Atomic)formula).getPredicate();
	    return pred.equals("$true");
	default: return false;
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is $false
    private 
	static boolean isFalse(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Atomic:
	    String pred = ((SimpleTptpParserOutput.Formula.Atomic)formula).getPredicate();
	    return pred.equals("$false");
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is atom different from $true and $false
    private 
	static boolean isPureAtom(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Atomic:
	    return (!isTrue(formula) & !isFalse(formula));
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is ~ $true
    private 
	static boolean isNegTrue(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    return isTrue(argument);
	default: return false;
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is ~ $false
    private 
	static boolean isNegFalse(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    return isFalse(argument);
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is ~ A where A is an atom different from $true and $false
    private 
	static boolean isNegAtom(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Atomic: return (!isTrue(argument) & !isFalse(argument));
	    default: return false;
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is ~ A where A is an atom different from $true and $false
    private 
	static SimpleTptpParserOutput.Formula getNegAtom(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Atomic: 
		if (!isTrue(argument) & !isFalse(argument)) {
		    return argument;
		}
		else { 
		    throw new Error("Unexpected case: " + formula.toString()); 
		}
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is of form ~ ~ Z
    private 
	static boolean isNegNegFormula(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Negation: return true;
	    default: return false;
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns Z if formula is of form ~ ~ Z
    private 
	static SimpleTptpParserOutput.Formula  getNegNegFormula(SimpleTptpParserOutput.Formula formula)
    { 
	switch (formula.getKind()) {
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Negation: return ((SimpleTptpParserOutput.Formula.Negation)argument).getArgument();
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is an alpha-formula
    private 
	static boolean isAlphaFormula(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    switch (connective) {
	    case And: return true;
	    case NotOr: return true;
	    default: return false;
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		switch (connective) {
		case Or: return true;
		case NotAnd: return true;
		case Implication: return true;
		case ReverseImplication: return true;
		default: return false;
		}
	    default: return false;
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns the negation of a formula
    private 
	static SimpleTptpParserOutput.Formula negateFormula(SimpleTptpParserOutput.Formula formula)
    {
	SimpleTptpParserOutput.Formula newFormula = new SimpleTptpParserOutput.Formula.Negation(formula);
	return newFormula;
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns alpha1 if formula is alpha, otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getAlpha1(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula returnFormula;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    returnFormula = ((SimpleTptpParserOutput.Formula.Binary)formula).getLhs();
	    switch (connective) {
	    case And: return returnFormula;
	    case NotOr: return negateFormula(returnFormula);
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		returnFormula = ((SimpleTptpParserOutput.Formula.Binary)argument).getLhs();
		switch (connective) {
		case Or: return negateFormula(returnFormula);
		case NotAnd: return returnFormula;
		case Implication: return returnFormula;
		case ReverseImplication: return negateFormula(returnFormula);
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns alpha2 if formula is alpha, otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getAlpha2(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula returnFormula;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    returnFormula = ((SimpleTptpParserOutput.Formula.Binary)formula).getRhs();
	    switch (connective) {
	    case And: return returnFormula;
	    case NotOr: return negateFormula(returnFormula);
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		returnFormula = ((SimpleTptpParserOutput.Formula.Binary)argument).getRhs();
		switch (connective) {
		case Or: return negateFormula(returnFormula);
		case NotAnd: return returnFormula;
		case Implication: return negateFormula(returnFormula);
		case ReverseImplication: return returnFormula;
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }




    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is a beta-formula
    private 
	static boolean isBetaFormula(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    switch (connective) {
	    case Or: return true;
	    case NotAnd: return true;
	    case Implication: return true;
	    case ReverseImplication: return true;
	    default: return false;
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		switch (connective) {
		case And: return true;
		case NotOr: return true;
		default: return false;
		}
	    default: return false;
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns beta1 if formula is beta, otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getBeta1(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula returnFormula;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    returnFormula = ((SimpleTptpParserOutput.Formula.Binary)formula).getLhs();
	    switch (connective) {
	    case Or: return returnFormula;
	    case NotAnd: return negateFormula(returnFormula);
	    case Implication: return negateFormula(returnFormula);
	    case ReverseImplication: return returnFormula;
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		returnFormula = ((SimpleTptpParserOutput.Formula.Binary)argument).getLhs();
		switch (connective) {
		case And: return negateFormula(returnFormula);
		case NotOr: return returnFormula;
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns beta2 if formula is beta, otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getBeta2(SimpleTptpParserOutput.Formula formula)
    { 
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula returnFormula;
	TptpParserOutput.BinaryConnective connective;
	switch (formula.getKind()) {
	case Binary:
	    connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    returnFormula = ((SimpleTptpParserOutput.Formula.Binary)formula).getRhs();
	    switch (connective) {
	    case Or: return returnFormula;
	    case NotAnd: return negateFormula(returnFormula);
	    case Implication: return returnFormula;
	    case ReverseImplication: return negateFormula(returnFormula);
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation: 
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Binary: 
		connective = ((SimpleTptpParserOutput.Formula.Binary)argument).getConnective();
		returnFormula = ((SimpleTptpParserOutput.Formula.Binary)argument).getRhs();
		switch (connective) {
		case And: return negateFormula(returnFormula);
		case NotOr: return returnFormula;
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is a gamma-formula
    private 
	static boolean isGammaFormula(SimpleTptpParserOutput.Formula formula)
    { 
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    switch (quantifier) {
	    case ForAll: return true;
	    default: return false;
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		switch (quantifier) {
		case Exists: return true;
		default: return false;
		}
	    default: return false;		
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns gamma if formula is a gamma-formula; otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getGammaX(SimpleTptpParserOutput.Formula formula)
    { 
	//System.out.println("\n*** GammaX: " + formula.toString());
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula matrix;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    matrix = ((SimpleTptpParserOutput.Formula.Quantified)formula).getMatrix();
	    switch (quantifier) {
	    case ForAll: return matrix;
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		matrix = ((SimpleTptpParserOutput.Formula.Quantified)argument).getMatrix();
		switch (quantifier) {
		case Exists: return negateFormula(matrix);
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());		
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns true if formula is a delta-formula
    private 
	static boolean isDeltaFormula(SimpleTptpParserOutput.Formula formula)
    { 
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    switch (quantifier) {
	    case Exists: return true;
	    default: return false;
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		switch (quantifier) {
		case ForAll: return true;
		default: return false;
		}
	    default: return false;		
	    }
	default: return false;
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns delta(X) if formula is a delta-formula; otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula getDeltaX(SimpleTptpParserOutput.Formula formula)
    { 
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	SimpleTptpParserOutput.Formula matrix;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    matrix = ((SimpleTptpParserOutput.Formula.Quantified)formula).getMatrix();
	    switch (quantifier) {
	    case Exists: return matrix;
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		matrix = ((SimpleTptpParserOutput.Formula.Quantified)argument).getMatrix();
		switch (quantifier) {
		case ForAll: return negateFormula(matrix);
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());		
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns gamma(t) if formula is a gamma-formula; otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula 
	getGammaT(SimpleTptpParserOutput.Formula formula, 
		  SimpleTptpParserOutput.Term term,
		  SimpleTptpParserOutput out)
    { 
	//System.out.println("\n*** GammaT: " + formula.toString() + " " + term.toString());
	//SimpleTptpParserOutput out = new SimpleTptpParserOutput();
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	String boundVariable;	
	SimpleTptpParserOutput.Term boundVariableTerm;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    boundVariable = ((SimpleTptpParserOutput.Formula.Quantified)formula).getVariable();
	    boundVariableTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(boundVariable);
	    switch (quantifier) {
	    case ForAll: return substituteFormula(getGammaX(formula),boundVariableTerm,term,out);
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		boundVariable = ((SimpleTptpParserOutput.Formula.Quantified)argument).getVariable();
		boundVariableTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(boundVariable);
		switch (quantifier) {
		case Exists: return negateFormula(substituteFormula(getGammaX(formula),boundVariableTerm,term,out));
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());		
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // returns delta(t) if formula is a delta-formula; otherwise returns null
    private 
	static SimpleTptpParserOutput.Formula 
	getDeltaT(SimpleTptpParserOutput.Formula formula, 
		  SimpleTptpParserOutput.Term term,
		  SimpleTptpParserOutput out)
    { 
	//SimpleTptpParserOutput out = new SimpleTptpParserOutput();
	TptpParserOutput.Quantifier quantifier;
	SimpleTptpParserOutput.Formula argument;
	String boundVariable;	
	SimpleTptpParserOutput.Term boundVariableTerm;
	switch (formula.getKind()) {
	case Quantified:
	    quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    boundVariable = ((SimpleTptpParserOutput.Formula.Quantified)formula).getVariable();
	    boundVariableTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(boundVariable);
	    switch (quantifier) {
	    case Exists: return substituteFormula(getDeltaX(formula),boundVariableTerm,term,out);
	    default: throw new Error("Unexpected case: " + formula.toString());
	    }
	case Negation:
	    argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    switch (argument.getKind()) {
	    case Quantified:
		quantifier = ((SimpleTptpParserOutput.Formula.Quantified)argument).getQuantifier();
		boundVariable = ((SimpleTptpParserOutput.Formula.Quantified)argument).getVariable();
		boundVariableTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(boundVariable);
		switch (quantifier) {
		case ForAll: return negateFormula(substituteFormula(getDeltaX(formula),boundVariableTerm,term,out));
		default: throw new Error("Unexpected case: " + formula.toString());
		}
	    default: throw new Error("Unexpected case: " + formula.toString());		
	    }
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // See Fitting's Textbook on p.25
    private 
	static int formulaDepthAsInFitting(SimpleTptpParserOutput.Formula formula)
    {
	if      (isTrue(formula))          { return 0; }
	else if (isFalse(formula))         { return 0; }
	else if (isPureAtom(formula))      { return 0; }
	else if (isNegTrue(formula))       { return 1; }
	else if (isNegFalse(formula))      { return 1; }
	else if (isNegAtom(formula))       { return 0; }
	else if (isNegNegFormula(formula)) { 
	    return (formulaDepthAsInFitting(getNegNegFormula(formula)) + 1);
	}
	else if (isAlphaFormula(formula))  { 
	    return ( Math.max(formulaDepthAsInFitting(getAlpha1(formula)),formulaDepthAsInFitting(getAlpha2(formula))) + 1 );
	}
	else if (isBetaFormula(formula))   { 
	    return ( Math.max(formulaDepthAsInFitting(getBeta1(formula)),formulaDepthAsInFitting(getBeta2(formula))) + 1 );
	}
	else if (isGammaFormula(formula))  { 
	    return (formulaDepthAsInFitting(getGammaX(formula)) + 1); 
	}
	else if (isDeltaFormula(formula))  { 
	    return (formulaDepthAsInFitting(getDeltaX(formula)) + 1); 
	}
	else                               { 	
	    throw new Error("Unexpected case: " + formula.toString());
	}
    } 

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // See Fitting's Textbook on p.25 and p.112
    private 
	static int formulaRankAsInFitting(SimpleTptpParserOutput.Formula formula)
    {
	//System.out.println("*** Enter formulaRankAsInFitting: " + formula.toString());
	if      (isTrue(formula))          { return 0; }
	else if (isFalse(formula))         { return 0; }
	else if (isPureAtom(formula))      { return 0; }
	else if (isNegTrue(formula))       { return 1; }
	else if (isNegFalse(formula))      { return 1; }
	else if (isNegAtom(formula))       { return 0; }
	else if (isNegNegFormula(formula)) { 
	    return (formulaRankAsInFitting(getNegNegFormula(formula)) + 1);
	}
	else if (isAlphaFormula(formula))  { 
	    return ( formulaRankAsInFitting(getAlpha1(formula)) + formulaRankAsInFitting(getAlpha2(formula)) + 1 );
	}
	else if (isBetaFormula(formula))   { 
	    return ( formulaRankAsInFitting(getBeta1(formula)) + formulaRankAsInFitting(getBeta2(formula)) + 1 );
	}
	else if (isGammaFormula(formula))  { 
	    return (formulaRankAsInFitting(getGammaX(formula)) + 1); 
	}
	else if (isDeltaFormula(formula))  { 
	    return (formulaRankAsInFitting(getDeltaX(formula)) + 1); 
	}
	else                               { 	
	    throw new Error("Unexpected case: " + formula.toString());
	}
    } 

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    private 
	static int clauseLength(SimpleTptpParserOutput.Clause clause)
    {
	System.out.println(" clauseLength not yet implemented");
	return -1;
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
   private 
	static SimpleTptpParserOutput.Term 
	substituteTerm( SimpleTptpParserOutput.Term term1,
			SimpleTptpParserOutput.Term var,
			SimpleTptpParserOutput.Term term2,
			SimpleTptpParserOutput out )
    { 	
	String topsymstring = term1.getTopSymbol().toString();
	int numberOfArgs = term1.getNumberOfArguments();
	LinkedList<SimpleTptpParserOutput.Term> arguments = (LinkedList<SimpleTptpParserOutput.Term>)term1.getArguments();
	SimpleTptpParserOutput.Term res;
	if (numberOfArgs == 0) {
	    if (term1.equals(var)) { 
		res = term2; 
	    }
	    else {
		res = term1;
	    }
	}
	else {
	    //SimpleTptpParserOutput out = new SimpleTptpParserOutput();
	    LinkedList<TptpParserOutput.Term> new_arguments = new LinkedList<TptpParserOutput.Term>();
	    for (SimpleTptpParserOutput.Term arg : arguments) {
		new_arguments.add(substituteTerm(arg,var,term2,out));
	    }
	    res = (SimpleTptpParserOutput.Term)out.createPlainTerm(topsymstring,new_arguments);
	}
	//System.out.println(" SubstituteTerm(term1,var,term2): " + term1.toString() + " " + var.toString() + " " + term2.toString());
	//System.out.println("                          Result: " + res);
	return res;
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // create fresh variable names
    protected static int varCounter = 0;

    public static String freshVariableName () {
	varCounter = ++varCounter;
	return ("V" + varCounter);
    }

    public static SimpleTptpParserOutput.Term freshVariableTerm (SimpleTptpParserOutput out) {
	
	String newVarName = freshVariableName();
	SimpleTptpParserOutput.Term var = (SimpleTptpParserOutput.Term)out.createVariableTerm(newVarName);
	return var;
    }

    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    // Attention: this version of substitution does not yet check for variable capturing!!!
   private 
	static SimpleTptpParserOutput.Formula 
	substituteFormula ( SimpleTptpParserOutput.Formula formula,
			    SimpleTptpParserOutput.Term var,
			    SimpleTptpParserOutput.Term term, 
			    SimpleTptpParserOutput out )
    { 	
	//SimpleTptpParserOutput out = new SimpleTptpParserOutput();
	switch (formula.getKind()) {
	case Atomic:
	    String predicate = ((SimpleTptpParserOutput.Formula.Atomic)formula).getPredicate();
	    Iterable<SimpleTptpParserOutput.Term> arguments = ((SimpleTptpParserOutput.Formula.Atomic)formula).getArguments();
	    LinkedList<TptpParserOutput.Term> new_arguments = new LinkedList<TptpParserOutput.Term>();
	    for (SimpleTptpParserOutput.Term arg : arguments) {
		new_arguments.add(substituteTerm(arg,var,term,out));
	    }
	    return (SimpleTptpParserOutput.Formula)out.createPlainAtom(predicate,new_arguments);
	case Quantified:
	    SimpleTptpParserOutput.Quantifier quantifier = ((SimpleTptpParserOutput.Formula.Quantified)formula).getQuantifier();
	    String boundVariable = ((SimpleTptpParserOutput.Formula.Quantified)formula).getVariable();
	    SimpleTptpParserOutput.Term boundVariableTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(boundVariable);
	    SimpleTptpParserOutput.Formula matrix = ((SimpleTptpParserOutput.Formula.Quantified)formula).getMatrix();

	    String newVarName = freshVariableName();
	    SimpleTptpParserOutput.Term newVarTerm = (SimpleTptpParserOutput.Term)out.createVariableTerm(newVarName);
	    SimpleTptpParserOutput.Formula renamedMatrix = substituteFormula(matrix,boundVariableTerm,newVarTerm,out);
	    LinkedList<String> varlist = new LinkedList<String>();
	    varlist.add(newVarName);
	    SimpleTptpParserOutput.Formula newMatrix = substituteFormula(renamedMatrix,var,term,out);
		return (SimpleTptpParserOutput.Formula)out.createQuantifiedFormula(quantifier,varlist,newMatrix);
	case Binary:
	    SimpleTptpParserOutput.BinaryConnective connective = ((SimpleTptpParserOutput.Formula.Binary)formula).getConnective();
	    SimpleTptpParserOutput.Formula lhs = ((SimpleTptpParserOutput.Formula.Binary)formula).getLhs();
	    SimpleTptpParserOutput.Formula rhs = ((SimpleTptpParserOutput.Formula.Binary)formula).getRhs();
	    SimpleTptpParserOutput.Formula newlhs = substituteFormula(lhs,var,term,out);
	    SimpleTptpParserOutput.Formula newrhs = substituteFormula(rhs,var,term,out);
	    return (SimpleTptpParserOutput.Formula)out.createBinaryFormula(newlhs,connective,newrhs);
	case Negation:
	    SimpleTptpParserOutput.Formula argument = ((SimpleTptpParserOutput.Formula.Negation)formula).getArgument();
	    SimpleTptpParserOutput.Formula newargument = substituteFormula(argument,var,term,out);
	    return (SimpleTptpParserOutput.Formula)out.createNegationOf(newargument);
	default: throw new Error("Unexpected case: " + formula.toString());
	}
    }


    // ********************************************************************************* //
    // Added by Christoph Benzmueller, Sep 2012
    // ********************************************************************************* //
    private 
	static void demoExample(SimpleTptpParserOutput.TopLevelItem item,SimpleTptpParserOutput out)
    {
	
	switch (item.getKind()) {
	case Formula: 
	    SimpleTptpParserOutput.Formula formula = ((SimpleTptpParserOutput.AnnotatedFormula)item).getFormula();
	    int res1 = formulaDegreeAsInFitting(formula);
	    int res2 = formulaDepthAsInFitting(formula);
	    int res3 = formulaRankAsInFitting(formula);
	    boolean isTrue = isTrue(formula);
	    boolean isFalse = isFalse(formula);
	    boolean isPureAtom = isPureAtom(formula);
	    boolean isNegTrue = isNegTrue(formula);
	    boolean isNegFalse = isNegFalse(formula);
	    boolean isNegAtom = isNegAtom(formula);
	    boolean isNegNegFormula = isNegNegFormula(formula);   
	    boolean isAlpha = isAlphaFormula(formula);
	    boolean isBeta = isBetaFormula(formula);
	    boolean isGamma = isGammaFormula(formula);
	    boolean isDelta = isDeltaFormula(formula);
	    System.out.println(item.toString());
	    System.out.println("\nAnalyzing formula: " + formula.toString());
	    System.out.println(" isTrue         : " + isTrue);
	    System.out.println(" isFalse        : " + isFalse);
	    System.out.println(" isPureAtom     : " + isPureAtom);
	    System.out.println(" isNegTrue      : " + isNegTrue);
	    System.out.println(" isNegFalse     : " + isNegFalse);
	    System.out.println(" isNegAtom      : " + isNegAtom);
	    System.out.println(" isNegNegForm   : " + isNegNegFormula);
	    System.out.println(" isAlpha        : " + isAlpha);
	    if (isAlpha) {
		SimpleTptpParserOutput.Formula alpha1 = getAlpha1(formula);
		SimpleTptpParserOutput.Formula alpha2 = getAlpha2(formula);
		System.out.println("  alpha1                  " + alpha1.toString());
		System.out.println("  alpha2                  " + alpha2.toString());
	    };
	    System.out.println(" isBeta         : " + isBeta);
	    if (isBeta) {
		SimpleTptpParserOutput.Formula beta1 = getBeta1(formula);
		SimpleTptpParserOutput.Formula beta2 = getBeta2(formula);
		System.out.println("  beta1                   " + beta1.toString());
		System.out.println("  beta2                   " + beta2.toString());
	    };
	    System.out.println(" isGamma        : " + isGamma);
	    if (isGamma) {
		SimpleTptpParserOutput.Formula gamma = getGammaX(formula);
		System.out.println("  gamma                    " + gamma.toString());
		//SimpleTptpParserOutput out = new SimpleTptpParserOutput();
		SimpleTptpParserOutput.Term varX = (SimpleTptpParserOutput.Term)out.createVariableTerm("X1");
		SimpleTptpParserOutput.Formula gammaT = getGammaT(formula,varX,out);
		System.out.println("  gamma(T) for T=X1        " + gammaT.toString());
		SimpleTptpParserOutput.Term term_a = (SimpleTptpParserOutput.Term)out.createPlainTerm("a1",null);
		LinkedList<TptpParserOutput.Term> arguments = new LinkedList<TptpParserOutput.Term>();
		arguments.add(term_a);
		SimpleTptpParserOutput.Term term_fa = (SimpleTptpParserOutput.Term)out.createPlainTerm("g1",arguments);
		SimpleTptpParserOutput.Formula gammaT2 = getGammaT(formula,term_fa,out);
		System.out.println("  gamma(T) for T=g1(a1)    " + gammaT2.toString());
		SimpleTptpParserOutput.Term varZ = (SimpleTptpParserOutput.Term)out.createVariableTerm("Z");
		arguments.add(varZ);
		SimpleTptpParserOutput.Term term_faX = (SimpleTptpParserOutput.Term)out.createPlainTerm("g2",arguments);
		SimpleTptpParserOutput.Formula gammaT3 = getGammaT(formula,term_faX,out);
		System.out.println("  gamma(T) for T=g2(a1,Z)  " + gammaT3.toString());
	    };
	    System.out.println(" isDelta        : " + isDelta);
	    if (isDelta) {
		SimpleTptpParserOutput.Formula delta = getDeltaX(formula);
		System.out.println("  delta                    " + delta.toString());
		//SimpleTptpParserOutput out = new SimpleTptpParserOutput();
		SimpleTptpParserOutput.Term varX = (SimpleTptpParserOutput.Term)out.createVariableTerm("X1");
		SimpleTptpParserOutput.Formula deltaT = getDeltaT(formula,varX,out);
		System.out.println("  delta(T) for T=X1        " + deltaT.toString());
		SimpleTptpParserOutput.Term term_a = (SimpleTptpParserOutput.Term)out.createPlainTerm("a1",null);
		LinkedList<TptpParserOutput.Term> arguments = new LinkedList<TptpParserOutput.Term>();
		arguments.add(term_a);
		SimpleTptpParserOutput.Term term_fa = (SimpleTptpParserOutput.Term)out.createPlainTerm("g1",arguments);
		SimpleTptpParserOutput.Formula deltaT2 = getDeltaT(formula,term_fa,out);
		System.out.println("  delta(T) for T=g1(a1)    " + deltaT2.toString());
		SimpleTptpParserOutput.Term varZ = (SimpleTptpParserOutput.Term)out.createVariableTerm("Z");
		arguments.add(varZ);
		SimpleTptpParserOutput.Term term_faX = (SimpleTptpParserOutput.Term)out.createPlainTerm("g2",arguments);
		SimpleTptpParserOutput.Formula deltaT3 = getDeltaT(formula,term_faX,out);
		System.out.println("  delta(T) for T=g2(a1,Z)  " + deltaT3.toString());
	    };
	    System.out.println(" Formula degree (Fitting) : " + res1);
	    System.out.println(" Formula depth (Fitting)  : " + res2);
	    System.out.println(" Formula rank  (Fitting)  : " + res3 + "\n");
	    break;
	case Clause:
	    int res4 = clauseLength(((SimpleTptpParserOutput.AnnotatedClause)item).getClause()); 
	    System.out.println(item.toString());
	    System.out.println("Clause length: " + res4 + "\n");
	    break;
	case Include: 
	    System.out.println("Include");
	    break; // nothing to check
	} 
    }
    


    /** Keeps information about the usage of a symbol: the category (predicate or function)
     *  and the arity.
     */
    private static class SymbolDescriptor {
	
	public SymbolDescriptor(boolean isPred,int ar) {
	    isPredicate = isPred;
	    arity = ar;
	}

	public boolean isPredicate;

	public int arity;

    } // class SymbolDescriptor

    /** Keeps descriptors of all symbols registered so far. */
    private static Hashtable<String,SymbolDescriptor> _signature = 
	new Hashtable<String,SymbolDescriptor>();

    /** This is here to avoid threading this information through different
     *  variants of checkSemantically(_).
     */
    private static String _semanticCheckFileName;

    /** This is here to avoid threading this information through different
     *  variants of checkSemantically(_).
     */
    private static int _semanticCheckLineNumber;

} /* end of the class */

