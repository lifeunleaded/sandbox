$(document).ready(function () {indexDict['en'] = [{ "title" : "Test ", 
"url" : "engvars.html", 
"breadcrumbs" : "Test \/ Test ", 
"snippet" : "45% contentwidth Test Scale 45, scalefit 1 sysvars name desc def sysvar1 blabla 0 sysvar2 blublu 2 Figure title A caption Referencing a footnote with manually set xml:id here: Referencing a footnote with generated xml:id here:...", 
"body" : "45% contentwidth Test Scale 45, scalefit 1 sysvars name desc def sysvar1 blabla 0 sysvar2 blublu 2 Figure title A caption Referencing a footnote with manually set xml:id here: Referencing a footnote with generated xml:id here: " }, 
{ "title" : "Topic with footnote ", 
"url" : "engvars.html#UUID-9128f31a-4c75-6cad-1a3f-4a7c1d49fe2a_UUID-058b65a1-21fc-a604-956b-7f8be563a2b2", 
"breadcrumbs" : "Test \/ Test \/ Topic with footnote ", 
"snippet" : "Some text here With a footnote...", 
"body" : "Some text here With a footnote " }, 
{ "title" : "Topic with footnote (automatic ID) ", 
"url" : "engvars.html#UUID-9128f31a-4c75-6cad-1a3f-4a7c1d49fe2a_UUID-97465771-1c4e-ca04-49cf-8b99100d859d", 
"breadcrumbs" : "Test \/ Test \/ Topic with footnote (automatic ID) ", 
"snippet" : "Some text here With a footnote...", 
"body" : "Some text here With a footnote " }, 
{ "title" : "Linktopic ", 
"url" : "linktopic.html", 
"breadcrumbs" : "Test \/ Linktopic ", 
"snippet" : "Link here: sysvar1...", 
"body" : "Link here: sysvar1" }
]
$(document).trigger('search.ready');
});