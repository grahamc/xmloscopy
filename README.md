

Demo finding obviously broken stuff:

    nixpkgs/doc$ xmloscopy
        Feasability check on files without xincludes...

    A document is feasibly valid if it could be transformed into a valid
    document by inserting any number of attributes and child elements
    anywhere in the tree.

    This is equivalent to pretending every element is optional.

    This option may be useful while a document is still under
    construction.

    This option also disables checking that references are valid.
    <snip>
    ./coding-conventions.xml: Not feasibly valid:
    Line 7:
         4
         5	  <title>Coding conventions</title>
         6
         7	 <section xml:id="sec-syntax"><title foo="bar">Syntax</title>
         8
         9	<itemizedlist>
        10
         error: attribute "foo" not allowed
        here; expected attribute
        "annotations", "arch", "audience",
        "condition", "conformance", "dir",
        "linkend", "os", "remap", "revision",
        "revisionflag", "role", "security",
        "userlevel", "vendor", "version",
        "wordsize", "xlink:actuate",
        "xlink:arcrole", "xlink:href",
        "xlink:role", "xlink:show",
        "xlink:title", "xlink:type",
        "xml:base", "xml:id", "xml:lang" or
        "xreflabel"

Demo finding other broken stuff:

    nixpkgs/doc$ xmloscopy

    <snip>

        Checking files without xincludes, ignoring reference errors...

    Ensures document fragments are valid, but without validating links
    are valid.

    <snip>

    ./coding-conventions.xml: Not valid:
    Line 9:
         6
         7	 <section xml:id="sec-syntax">
         8
         9	<itemizedlist>
        10
        11	  <listitem><para>Use 2 spaces of indentation per indentation level in
        12	  Nix expressions, 4 spaces in shell scripts.</para></listitem>
         error: element "itemizedlist" not
        allowed yet; expected element
        "info", "subtitle", "title" or
        "titleabbrev"

also this magic:

    Line 6625:
      6622	  in <link xlink:href="https://github.com/NixOS/nixpkgs/blob/master/pkgs/development/lua-modules/generic/default.nix">
      6623	  <filename>pkgs/development/lua-modules/generic/default.nix</filename></link>
      6624	  and works similarly to <varname>buildPerlPackage</varname>. (See
      6625	  <xref linkend="sec-language-prl"/> for details.)
      6626	</para>
      6627
      6628	<para>
         error: IDREF "sec-language-prl"
        without matching ID; error: IDREF
        "sec-language-prl" without matching ID

    Maybe you intended one of the following IDs which do exist:
     - sec-language-perl
