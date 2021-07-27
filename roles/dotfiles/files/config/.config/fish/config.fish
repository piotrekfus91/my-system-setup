thefuck --alias | source

set -gx PATH ~/touk/workspace/integracja/bin $PATH
set -gx PATH ~/Programowanie/Bash/bin $PATH
set -gx PATH ~/apps/bin/ $PATH

set -gx P4_TESTBED_PASS @P4_TESTBED_PASS@
set -gx P4_PREPROD_PASS @P4_PREPROD_PASS@
set -gx P4_PROD_FUDO_PASS @P4_PROD_FUDO_PASS@
set -gx P4_PROD_SMX_X_PASS @P4_PROD_SMX_X_PASS@
set -gx P4_PROD_SMX_X_DR_PASS @P4_PROD_SMX_X_DR_PASS@
set -gx P4_PROD_SMXCS0_X @P4_PROD_SMXCS0_X@

set -gx EDITOR vim

function tig
  /usr/bin/tig --all
end

source /home/pfus/touk/workspace/integracja/bin/smx4-completion.fish

set -g theme_color_scheme nord