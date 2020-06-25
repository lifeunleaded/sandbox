#!/usr/local/bin/python3
import json,sys,pprint
from lxml import etree
schemafile=open(sys.argv[1],'r')
xmlparser=etree.XMLParser(remove_comments=True,ns_clean=True)
schema=etree.parse(schemafile,xmlparser)
schemafile.close()
schemaroot=schema.getroot()
attributes={}
elements={}
attribute={}
combinations={}
element={}
refs={}

structure={}

unhandled={}

def populate_dict(dict,tree):
    for attr in tree.attrib.keys():
        if '}' in attr:
            dict[attr.split('}')[1]]=tree.attrib[attr]
        else:
            dict[attr]=tree.attrib[attr]
    if tree.text and (tree.text.strip() != ''):
        dict['text']=tree.text
    for subelem in tree:
        sys.stderr.write("Subelem tag: {}\n".format(subelem.tag))
        # if subelem.tag=='{http://relaxng.org/ns/structure/1.0}ref':
        #     indextag=subelem.attrib['name']
        #     dict[indextag]={'type':'ref'}
        #     populate_dict(dict[indextag],subelem)
        if subelem.tag in ['{http://relaxng.org/ns/structure/1.0}choice','{http://relaxng.org/ns/structure/1.0}interleave','{http://relaxng.org/ns/structure/1.0}optional']:
            sys.stderr.write("Match\n")
            indextag=subelem.tag.split('}')[1]
            if indextag not in dict.keys():
                dict[indextag]=[]
            for subsubelem in subelem:
                subitem={}
                populate_dict(subitem,subsubelem)                
                dict[indextag].append(subitem)
        else:
            indextag=subelem.tag.split('}')[1]
            dict[indextag]={}
            populate_dict(dict[indextag],subelem)
    return dict

for definition in schemaroot.findall('{http://relaxng.org/ns/structure/1.0}define'):
    definition_content=definition[0]
    definition_exists=(definition.attrib['name'] in refs.keys())
    if definition_content.tag=='{http://relaxng.org/ns/structure/1.0}attribute':
        if definition_exists:
            sys.stderr.write("Augmenting definition {}\n".format(definition.attrib['name']))
            attribute=attributes[definition.attrib['name']]
            sys.stderr.write("Before: {}\n".format(attribute))
        else:
            attribute={}
            try:
                refs[definition.attrib['name']]='attribute'
            except KeyError:
                sys.stderr.write("Nameless attribute {}, bypassing\n".format(definition.attrib['name']))
                continue
        attribute=populate_dict(attribute,definition_content)
        if definition_exists:
            sys.stderr.write("After: {}\n".format(attribute))
        attributes[definition.attrib['name']]=attribute
    elif definition_content.tag=='{http://relaxng.org/ns/structure/1.0}element':
        if definition_exists:
            sys.stderr.write("Augmenting definition {}\n".format(definition.attrib['name']))
            element=elements[definition.attrib['name']]
            sys.stderr.write("Before: {}\n".format(element))
        else:
            element={}
            try:
                refs[definition.attrib['name']]='element'
            except KeyError:
                sys.stderr.write("Nameless element {}, bypassing\n".format(definition.attrib['name']))
                continue
        element=populate_dict(element,definition_content)
        if definition_exists:
            sys.stderr.write("After: {}\n".format(element))
        elements[definition.attrib['name']]=element
    else:
        if definition_exists:
            sys.stderr.write("Augmenting definition {}\n".format(definition.attrib['name']))
            combination=combinations[definition.attrib['name']]
            sys.stderr.write("Before: {}\n".format(combination))
        else:
            combination={}
            try:
                refs[definition.attrib['name']]=definition_content.tag
            except KeyError:
                sys.stderr.write("Nameless define child {}, bypassing\n".format(definition.attrib['name']))
                continue
        combination=populate_dict(combination,definition_content)
        if definition_exists:
            sys.stderr.write("After: {}\n".format(combination))
        combinations[definition.attrib['name']]=combination

startelem=schemaroot.find('{http://relaxng.org/ns/structure/1.0}start')
structure['start']={}
populate_dict(structure['start'],startelem)
    # for choice in reference.findall('{http://relaxng.org/ns/structure/1.0}choice'):
    #     structure['start'].append=[]    
    # try:
    #     refname=reference.attrib['name']
    #     if refname in refs.keys():
    #         print("Found reference {}, which is an {}".format(refname,refs[refname]))
    #         if refs[refname] == 'element':
    #             structure[refname]=elements[refname]
    #         else:
    #             sys.stderr.write("Non-element ref in start/choice: {}".format(refname))
    #     else: 
    #         sys.stderr.write("Found reference {}, from unhandled definition {}".format(refname,unhandled[refname]))
    # except KeyError:
    #     sys.stderr.write("Nameless reference, bypassing\n")



outfile=open(sys.argv[2],'w')
json.dump({'structure':structure,'attributes':attributes,'elements':elements,'combinations':combinations},outfile,indent=4)
outfile.close()
