##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##
##
## Abstract:
##   Initialization file ~/.latexmkrc contains a sequence of Perl statements implementing run-time configuration for the
## automated LaTeX document generation tool Latexmk.
##
## Details:
## - This Latexmk initialization file is written for Latexmk version 4.35.
##
## References:
## - latexmk(1l) man page
##   --> http://mirror.ctan.org/support/latexmk/latexmk.pdf
## - Perl Programming Documentation
##   --> http://perldoc.perl.org/index.html
##
## Author:
##   Michael H. Pock || MHP || mhp77@gmx.at
##
## © Copyleft 2016 MHP
##
##---------------------------------------------------------------------------------------------------------------------------##
###############################################################################################################################
##---------------------------------------------------------------------------------------------------------------------------##


## ********** General **********

$pdf_mode = 1;

$force_mode = 1;

$bibtex_use = 2;

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Commands **********

$latex_default_switches = '-file-line-error';

$pdflatex_default_switches = $latex_default_switches;

$bibtex               = 'bibtex8 -c latin9.csf -W %B %O';
$bibtex_silent_switch = '>/dev/null';

$dvipdf               = 'dvipdfmx %O -o %D %S';
$dvipdf_silent_switch = '-q';

$pdf_previewer     = 'evince %O %S 2>/dev/null';
$pdf_update_method = 0;

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Custom Dependencies **********

add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
add_cus_dep('noa', 'not', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

##---------------------------------------------------------------------------------------------------------------------------##


## ********** Files **********

push @generated_exts, 'lol';
push @generated_exts, 'run.xml';
push @generated_exts, 'cut';
push @generated_exts, 'glo', 'gls', 'glg';
push @generated_exts, 'acn', 'acr', 'alg';
push @generated_exts, 'noa', 'not', 'nlg';

$clean_ext .= ' %R-blx.bib';
$clean_ext .= ' %R.ist %R.xdy';

##---------------------------------------------------------------------------------------------------------------------------##


## LocalWords: latexmkrc latexmk
