. Allows svc.dcmonitoring (S-1-5-21-1085031214-2052111302-1417001333-49246) to query Windows servers as non-admin account
. For BGNONPRDIC001 \ 002
. D.Lum 5/22/2019

sc.exe sdset Interconnect-DEV-EDI "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-DEV-CVWizard "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-DEV-INTERFACES "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-DEV-Televox "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-QuestPDF "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-REL-CVWizard "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-REL-EDI "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset Interconnect-REL-INTERFACES "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"
sc.exe sdset W3SVC "D:(A;;CCLCRPRC;;;AU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)(A;;KA;;;S-1-5-21-1085031214-2052111302-1417001333-49246)S:(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)"