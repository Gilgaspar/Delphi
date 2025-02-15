// CodeGear C++Builder
// Copyright (c) 1995, 2015 by Embarcadero Technologies, Inc.
// All rights reserved

// (DO NOT EDIT: machine generated header) 'MSXML_TLB.pas' rev: 30.00 (Windows)

#ifndef Msxml_tlbHPP
#define Msxml_tlbHPP

#pragma delphiheader begin
#pragma option push
#pragma option -w-      // All warnings off
#pragma option -Vx      // Zero-length empty class member 
#pragma pack(push,8)
#include <System.hpp>
#include <SysInit.hpp>
#include <Winapi.Windows.hpp>
#include <Winapi.ActiveX.hpp>
#include <System.Classes.hpp>
#include <Vcl.Graphics.hpp>
#include <Vcl.OleServer.hpp>
#include <Vcl.OleCtrls.hpp>
#include <System.Win.StdVCL.hpp>

//-- user supplied -----------------------------------------------------------

namespace Msxml_tlb
{
//-- forward type declarations -----------------------------------------------
__interface IXMLDOMDocument;
typedef System::DelphiInterface<IXMLDOMDocument> _di_IXMLDOMDocument;
__interface IXMLHttpRequest;
typedef System::DelphiInterface<IXMLHttpRequest> _di_IXMLHttpRequest;
__interface IXMLDSOControl;
typedef System::DelphiInterface<IXMLDSOControl> _di_IXMLDSOControl;
__interface IXMLDocument2;
typedef System::DelphiInterface<IXMLDocument2> _di_IXMLDocument2;
struct _xml_error;
__interface IXMLDOMImplementation;
typedef System::DelphiInterface<IXMLDOMImplementation> _di_IXMLDOMImplementation;
__dispinterface IXMLDOMImplementationDisp;
typedef System::DelphiInterface<IXMLDOMImplementationDisp> _di_IXMLDOMImplementationDisp;
__interface IXMLDOMNode;
typedef System::DelphiInterface<IXMLDOMNode> _di_IXMLDOMNode;
__dispinterface IXMLDOMNodeDisp;
typedef System::DelphiInterface<IXMLDOMNodeDisp> _di_IXMLDOMNodeDisp;
__interface IXMLDOMNodeList;
typedef System::DelphiInterface<IXMLDOMNodeList> _di_IXMLDOMNodeList;
__dispinterface IXMLDOMNodeListDisp;
typedef System::DelphiInterface<IXMLDOMNodeListDisp> _di_IXMLDOMNodeListDisp;
__interface IXMLDOMNamedNodeMap;
typedef System::DelphiInterface<IXMLDOMNamedNodeMap> _di_IXMLDOMNamedNodeMap;
__dispinterface IXMLDOMNamedNodeMapDisp;
typedef System::DelphiInterface<IXMLDOMNamedNodeMapDisp> _di_IXMLDOMNamedNodeMapDisp;
__dispinterface IXMLDOMDocumentDisp;
typedef System::DelphiInterface<IXMLDOMDocumentDisp> _di_IXMLDOMDocumentDisp;
__interface IXMLDOMDocumentType;
typedef System::DelphiInterface<IXMLDOMDocumentType> _di_IXMLDOMDocumentType;
__dispinterface IXMLDOMDocumentTypeDisp;
typedef System::DelphiInterface<IXMLDOMDocumentTypeDisp> _di_IXMLDOMDocumentTypeDisp;
__interface IXMLDOMElement;
typedef System::DelphiInterface<IXMLDOMElement> _di_IXMLDOMElement;
__dispinterface IXMLDOMElementDisp;
typedef System::DelphiInterface<IXMLDOMElementDisp> _di_IXMLDOMElementDisp;
__interface IXMLDOMAttribute;
typedef System::DelphiInterface<IXMLDOMAttribute> _di_IXMLDOMAttribute;
__dispinterface IXMLDOMAttributeDisp;
typedef System::DelphiInterface<IXMLDOMAttributeDisp> _di_IXMLDOMAttributeDisp;
__interface IXMLDOMDocumentFragment;
typedef System::DelphiInterface<IXMLDOMDocumentFragment> _di_IXMLDOMDocumentFragment;
__dispinterface IXMLDOMDocumentFragmentDisp;
typedef System::DelphiInterface<IXMLDOMDocumentFragmentDisp> _di_IXMLDOMDocumentFragmentDisp;
__interface IXMLDOMCharacterData;
typedef System::DelphiInterface<IXMLDOMCharacterData> _di_IXMLDOMCharacterData;
__dispinterface IXMLDOMCharacterDataDisp;
typedef System::DelphiInterface<IXMLDOMCharacterDataDisp> _di_IXMLDOMCharacterDataDisp;
__interface IXMLDOMText;
typedef System::DelphiInterface<IXMLDOMText> _di_IXMLDOMText;
__dispinterface IXMLDOMTextDisp;
typedef System::DelphiInterface<IXMLDOMTextDisp> _di_IXMLDOMTextDisp;
__interface IXMLDOMComment;
typedef System::DelphiInterface<IXMLDOMComment> _di_IXMLDOMComment;
__dispinterface IXMLDOMCommentDisp;
typedef System::DelphiInterface<IXMLDOMCommentDisp> _di_IXMLDOMCommentDisp;
__interface IXMLDOMCDATASection;
typedef System::DelphiInterface<IXMLDOMCDATASection> _di_IXMLDOMCDATASection;
__dispinterface IXMLDOMCDATASectionDisp;
typedef System::DelphiInterface<IXMLDOMCDATASectionDisp> _di_IXMLDOMCDATASectionDisp;
__interface IXMLDOMProcessingInstruction;
typedef System::DelphiInterface<IXMLDOMProcessingInstruction> _di_IXMLDOMProcessingInstruction;
__dispinterface IXMLDOMProcessingInstructionDisp;
typedef System::DelphiInterface<IXMLDOMProcessingInstructionDisp> _di_IXMLDOMProcessingInstructionDisp;
__interface IXMLDOMEntityReference;
typedef System::DelphiInterface<IXMLDOMEntityReference> _di_IXMLDOMEntityReference;
__dispinterface IXMLDOMEntityReferenceDisp;
typedef System::DelphiInterface<IXMLDOMEntityReferenceDisp> _di_IXMLDOMEntityReferenceDisp;
__interface IXMLDOMParseError;
typedef System::DelphiInterface<IXMLDOMParseError> _di_IXMLDOMParseError;
__dispinterface IXMLDOMParseErrorDisp;
typedef System::DelphiInterface<IXMLDOMParseErrorDisp> _di_IXMLDOMParseErrorDisp;
__interface IXMLDOMNotation;
typedef System::DelphiInterface<IXMLDOMNotation> _di_IXMLDOMNotation;
__dispinterface IXMLDOMNotationDisp;
typedef System::DelphiInterface<IXMLDOMNotationDisp> _di_IXMLDOMNotationDisp;
__interface IXMLDOMEntity;
typedef System::DelphiInterface<IXMLDOMEntity> _di_IXMLDOMEntity;
__dispinterface IXMLDOMEntityDisp;
typedef System::DelphiInterface<IXMLDOMEntityDisp> _di_IXMLDOMEntityDisp;
__interface IXTLRuntime;
typedef System::DelphiInterface<IXTLRuntime> _di_IXTLRuntime;
__dispinterface IXTLRuntimeDisp;
typedef System::DelphiInterface<IXTLRuntimeDisp> _di_IXTLRuntimeDisp;
__dispinterface XMLDOMDocumentEvents;
typedef System::DelphiInterface<XMLDOMDocumentEvents> _di_XMLDOMDocumentEvents;
__dispinterface IXMLHttpRequestDisp;
typedef System::DelphiInterface<IXMLHttpRequestDisp> _di_IXMLHttpRequestDisp;
__dispinterface IXMLDSOControlDisp;
typedef System::DelphiInterface<IXMLDSOControlDisp> _di_IXMLDSOControlDisp;
__interface IXMLElementCollection;
typedef System::DelphiInterface<IXMLElementCollection> _di_IXMLElementCollection;
__dispinterface IXMLElementCollectionDisp;
typedef System::DelphiInterface<IXMLElementCollectionDisp> _di_IXMLElementCollectionDisp;
__interface IXMLDocument;
typedef System::DelphiInterface<IXMLDocument> _di_IXMLDocument;
__dispinterface IXMLDocumentDisp;
typedef System::DelphiInterface<IXMLDocumentDisp> _di_IXMLDocumentDisp;
__interface IXMLElement;
typedef System::DelphiInterface<IXMLElement> _di_IXMLElement;
__dispinterface IXMLElementDisp;
typedef System::DelphiInterface<IXMLElementDisp> _di_IXMLElementDisp;
__interface IXMLElement2;
typedef System::DelphiInterface<IXMLElement2> _di_IXMLElement2;
__dispinterface IXMLElement2Disp;
typedef System::DelphiInterface<IXMLElement2Disp> _di_IXMLElement2Disp;
__interface IXMLAttribute;
typedef System::DelphiInterface<IXMLAttribute> _di_IXMLAttribute;
__dispinterface IXMLAttributeDisp;
typedef System::DelphiInterface<IXMLAttributeDisp> _di_IXMLAttributeDisp;
__interface IXMLError;
typedef System::DelphiInterface<IXMLError> _di_IXMLError;
class DELPHICLASS CoDOMDocument;
class DELPHICLASS TDOMDocument;
class DELPHICLASS CoDOMFreeThreadedDocument;
class DELPHICLASS TDOMFreeThreadedDocument;
class DELPHICLASS CoXMLHTTPRequest;
class DELPHICLASS TXMLHTTPRequest;
class DELPHICLASS CoXMLDSOControl;
class DELPHICLASS TXMLDSOControl;
class DELPHICLASS CoXMLDocument;
class DELPHICLASS TXMLDocument;
//-- type declarations -------------------------------------------------------
typedef Winapi::Activex::TOleEnum tagDOMNodeType;

typedef Winapi::Activex::TOleEnum tagXMLEMEM_TYPE;

typedef _di_IXMLDOMDocument DOMDocument;

typedef _di_IXMLDOMDocument DOMFreeThreadedDocument;

typedef _di_IXMLHttpRequest XMLHTTPRequest;

typedef _di_IXMLDSOControl XMLDSOControl;

typedef _di_IXMLDocument2 XMLDocument;

typedef GUID *PUserType1;

typedef Winapi::Activex::TOleEnum DOMNodeType;

#pragma pack(push,1)
struct DECLSPEC_DRECORD _xml_error
{
public:
	unsigned _nLine;
	System::WideString _pchBuf;
	unsigned _cchBuf;
	unsigned _ich;
	System::WideString _pszFound;
	System::WideString _pszExpected;
	unsigned _reserved1;
	unsigned _reserved2;
};
#pragma pack(pop)


typedef Winapi::Activex::TOleEnum XMLELEM_TYPE;

__interface  INTERFACE_UUID("{2933BF8F-7B36-11D2-B20E-00C04F983E60}") IXMLDOMImplementation  : public IDispatch 
{
	virtual HRESULT __safecall hasFeature(const System::WideString feature, const System::WideString version, System::WordBool &__hasFeature_result) = 0 ;
};

__dispinterface  INTERFACE_UUID("{2933BF8F-7B36-11D2-B20E-00C04F983E60}") IXMLDOMImplementationDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF80-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNode  : public IDispatch 
{
	virtual HRESULT __safecall Get_nodeName(System::WideString &__Get_nodeName_result) = 0 ;
	virtual HRESULT __safecall Get_nodeValue(System::OleVariant &__Get_nodeValue_result) = 0 ;
	virtual HRESULT __safecall Set_nodeValue(const System::OleVariant value) = 0 ;
	virtual HRESULT __safecall Get_nodeType(Winapi::Activex::TOleEnum &__Get_nodeType_result) = 0 ;
	virtual HRESULT __safecall Get_parentNode(_di_IXMLDOMNode &__Get_parentNode_result) = 0 ;
	virtual HRESULT __safecall Get_childNodes(_di_IXMLDOMNodeList &__Get_childNodes_result) = 0 ;
	virtual HRESULT __safecall Get_firstChild(_di_IXMLDOMNode &__Get_firstChild_result) = 0 ;
	virtual HRESULT __safecall Get_lastChild(_di_IXMLDOMNode &__Get_lastChild_result) = 0 ;
	virtual HRESULT __safecall Get_previousSibling(_di_IXMLDOMNode &__Get_previousSibling_result) = 0 ;
	virtual HRESULT __safecall Get_nextSibling(_di_IXMLDOMNode &__Get_nextSibling_result) = 0 ;
	virtual HRESULT __safecall Get_attributes(_di_IXMLDOMNamedNodeMap &__Get_attributes_result) = 0 ;
	virtual HRESULT __safecall insertBefore(const _di_IXMLDOMNode newChild, const System::OleVariant refChild, _di_IXMLDOMNode &__insertBefore_result) = 0 ;
	virtual HRESULT __safecall replaceChild(const _di_IXMLDOMNode newChild, const _di_IXMLDOMNode oldChild, _di_IXMLDOMNode &__replaceChild_result) = 0 ;
	virtual HRESULT __safecall removeChild(const _di_IXMLDOMNode childNode, _di_IXMLDOMNode &__removeChild_result) = 0 ;
	virtual HRESULT __safecall appendChild(const _di_IXMLDOMNode newChild, _di_IXMLDOMNode &__appendChild_result) = 0 ;
	virtual HRESULT __safecall hasChildNodes(System::WordBool &__hasChildNodes_result) = 0 ;
	virtual HRESULT __safecall Get_ownerDocument(_di_IXMLDOMDocument &__Get_ownerDocument_result) = 0 ;
	virtual HRESULT __safecall cloneNode(System::WordBool deep, _di_IXMLDOMNode &__cloneNode_result) = 0 ;
	virtual HRESULT __safecall Get_nodeTypeString(System::WideString &__Get_nodeTypeString_result) = 0 ;
	virtual HRESULT __safecall Get_text(System::WideString &__Get_text_result) = 0 ;
	virtual HRESULT __safecall Set_text(const System::WideString text) = 0 ;
	virtual HRESULT __safecall Get_specified(System::WordBool &__Get_specified_result) = 0 ;
	virtual HRESULT __safecall Get_definition(_di_IXMLDOMNode &__Get_definition_result) = 0 ;
	virtual HRESULT __safecall Get_nodeTypedValue(System::OleVariant &__Get_nodeTypedValue_result) = 0 ;
	virtual HRESULT __safecall Set_nodeTypedValue(const System::OleVariant typedValue) = 0 ;
	virtual HRESULT __safecall Get_dataType(System::OleVariant &__Get_dataType_result) = 0 ;
	virtual HRESULT __safecall Set_dataType(const System::WideString dataTypeName) = 0 ;
	virtual HRESULT __safecall Get_xml(System::WideString &__Get_xml_result) = 0 ;
	virtual HRESULT __safecall transformNode(const _di_IXMLDOMNode stylesheet, System::WideString &__transformNode_result) = 0 ;
	virtual HRESULT __safecall selectNodes(const System::WideString queryString, _di_IXMLDOMNodeList &__selectNodes_result) = 0 ;
	virtual HRESULT __safecall selectSingleNode(const System::WideString queryString, _di_IXMLDOMNode &__selectSingleNode_result) = 0 ;
	virtual HRESULT __safecall Get_parsed(System::WordBool &__Get_parsed_result) = 0 ;
	virtual HRESULT __safecall Get_namespaceURI(System::WideString &__Get_namespaceURI_result) = 0 ;
	virtual HRESULT __safecall Get_prefix(System::WideString &__Get_prefix_result) = 0 ;
	virtual HRESULT __safecall Get_baseName(System::WideString &__Get_baseName_result) = 0 ;
	virtual HRESULT __safecall transformNodeToObject(const _di_IXMLDOMNode stylesheet, const System::OleVariant outputObject) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_nodeName() { System::WideString __r; HRESULT __hr = Get_nodeName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString nodeName = {read=_scw_Get_nodeName};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_nodeValue() { System::OleVariant __r; HRESULT __hr = Get_nodeValue(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant nodeValue = {read=_scw_Get_nodeValue, write=Set_nodeValue};
	#pragma option push -w-inl
	/* safecall wrapper */ inline Winapi::Activex::TOleEnum _scw_Get_nodeType() { Winapi::Activex::TOleEnum __r; HRESULT __hr = Get_nodeType(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property Winapi::Activex::TOleEnum nodeType = {read=_scw_Get_nodeType};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_parentNode() { _di_IXMLDOMNode __r; HRESULT __hr = Get_parentNode(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode parentNode = {read=_scw_Get_parentNode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNodeList _scw_Get_childNodes() { _di_IXMLDOMNodeList __r; HRESULT __hr = Get_childNodes(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNodeList childNodes = {read=_scw_Get_childNodes};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_firstChild() { _di_IXMLDOMNode __r; HRESULT __hr = Get_firstChild(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode firstChild = {read=_scw_Get_firstChild};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_lastChild() { _di_IXMLDOMNode __r; HRESULT __hr = Get_lastChild(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode lastChild = {read=_scw_Get_lastChild};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_previousSibling() { _di_IXMLDOMNode __r; HRESULT __hr = Get_previousSibling(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode previousSibling = {read=_scw_Get_previousSibling};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_nextSibling() { _di_IXMLDOMNode __r; HRESULT __hr = Get_nextSibling(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode nextSibling = {read=_scw_Get_nextSibling};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNamedNodeMap _scw_Get_attributes() { _di_IXMLDOMNamedNodeMap __r; HRESULT __hr = Get_attributes(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNamedNodeMap attributes = {read=_scw_Get_attributes};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMDocument _scw_Get_ownerDocument() { _di_IXMLDOMDocument __r; HRESULT __hr = Get_ownerDocument(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMDocument ownerDocument = {read=_scw_Get_ownerDocument};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_nodeTypeString() { System::WideString __r; HRESULT __hr = Get_nodeTypeString(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString nodeTypeString = {read=_scw_Get_nodeTypeString};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_text() { System::WideString __r; HRESULT __hr = Get_text(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString text = {read=_scw_Get_text, write=Set_text};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_specified() { System::WordBool __r; HRESULT __hr = Get_specified(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool specified = {read=_scw_Get_specified};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_definition() { _di_IXMLDOMNode __r; HRESULT __hr = Get_definition(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode definition = {read=_scw_Get_definition};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_nodeTypedValue() { System::OleVariant __r; HRESULT __hr = Get_nodeTypedValue(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant nodeTypedValue = {read=_scw_Get_nodeTypedValue, write=Set_nodeTypedValue};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_xml() { System::WideString __r; HRESULT __hr = Get_xml(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString xml = {read=_scw_Get_xml};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_parsed() { System::WordBool __r; HRESULT __hr = Get_parsed(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool parsed = {read=_scw_Get_parsed};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_namespaceURI() { System::WideString __r; HRESULT __hr = Get_namespaceURI(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString namespaceURI = {read=_scw_Get_namespaceURI};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_prefix() { System::WideString __r; HRESULT __hr = Get_prefix(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString prefix = {read=_scw_Get_prefix};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_baseName() { System::WideString __r; HRESULT __hr = Get_baseName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString baseName = {read=_scw_Get_baseName};
};

__dispinterface  INTERFACE_UUID("{2933BF80-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNodeDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF82-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNodeList  : public IDispatch 
{
	
public:
	_di_IXMLDOMNode operator[](int index) { return item[index]; }
	virtual HRESULT __safecall Get_item(int index, _di_IXMLDOMNode &__Get_item_result) = 0 ;
	virtual HRESULT __safecall Get_length(int &__Get_length_result) = 0 ;
	virtual HRESULT __safecall nextNode(_di_IXMLDOMNode &__nextNode_result) = 0 ;
	virtual HRESULT __safecall reset(void) = 0 ;
	virtual HRESULT __safecall Get__newEnum(System::_di_IInterface &__Get__newEnum_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_item(int index) { _di_IXMLDOMNode __r; HRESULT __hr = Get_item(index, __r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode item[int index] = {read=_scw_Get_item/*, default*/};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_length() { int __r; HRESULT __hr = Get_length(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int length = {read=_scw_Get_length};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::_di_IInterface _scw_Get__newEnum() { System::_di_IInterface __r; HRESULT __hr = Get__newEnum(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::_di_IInterface _newEnum = {read=_scw_Get__newEnum};
};

__dispinterface  INTERFACE_UUID("{2933BF82-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNodeListDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF83-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNamedNodeMap  : public IDispatch 
{
	
public:
	_di_IXMLDOMNode operator[](int index) { return item[index]; }
	virtual HRESULT __safecall getNamedItem(const System::WideString name, _di_IXMLDOMNode &__getNamedItem_result) = 0 ;
	virtual HRESULT __safecall setNamedItem(const _di_IXMLDOMNode newItem, _di_IXMLDOMNode &__setNamedItem_result) = 0 ;
	virtual HRESULT __safecall removeNamedItem(const System::WideString name, _di_IXMLDOMNode &__removeNamedItem_result) = 0 ;
	virtual HRESULT __safecall Get_item(int index, _di_IXMLDOMNode &__Get_item_result) = 0 ;
	virtual HRESULT __safecall Get_length(int &__Get_length_result) = 0 ;
	virtual HRESULT __safecall getQualifiedItem(const System::WideString baseName, const System::WideString namespaceURI, _di_IXMLDOMNode &__getQualifiedItem_result) = 0 ;
	virtual HRESULT __safecall removeQualifiedItem(const System::WideString baseName, const System::WideString namespaceURI, _di_IXMLDOMNode &__removeQualifiedItem_result) = 0 ;
	virtual HRESULT __safecall nextNode(_di_IXMLDOMNode &__nextNode_result) = 0 ;
	virtual HRESULT __safecall reset(void) = 0 ;
	virtual HRESULT __safecall Get__newEnum(System::_di_IInterface &__Get__newEnum_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNode _scw_Get_item(int index) { _di_IXMLDOMNode __r; HRESULT __hr = Get_item(index, __r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNode item[int index] = {read=_scw_Get_item/*, default*/};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_length() { int __r; HRESULT __hr = Get_length(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int length = {read=_scw_Get_length};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::_di_IInterface _scw_Get__newEnum() { System::_di_IInterface __r; HRESULT __hr = Get__newEnum(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::_di_IInterface _newEnum = {read=_scw_Get__newEnum};
};

__dispinterface  INTERFACE_UUID("{2933BF83-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNamedNodeMapDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF81-7B36-11D2-B20E-00C04F983E60}") IXMLDOMDocument  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_doctype(_di_IXMLDOMDocumentType &__Get_doctype_result) = 0 ;
	virtual HRESULT __safecall Get_implementation_(_di_IXMLDOMImplementation &__Get_implementation__result) = 0 ;
	virtual HRESULT __safecall Get_documentElement(_di_IXMLDOMElement &__Get_documentElement_result) = 0 ;
	virtual HRESULT __safecall Set_documentElement(const _di_IXMLDOMElement DOMElement) = 0 ;
	virtual HRESULT __safecall createElement(const System::WideString tagName, _di_IXMLDOMElement &__createElement_result) = 0 ;
	virtual HRESULT __safecall createDocumentFragment(_di_IXMLDOMDocumentFragment &__createDocumentFragment_result) = 0 ;
	virtual HRESULT __safecall createTextNode(const System::WideString data, _di_IXMLDOMText &__createTextNode_result) = 0 ;
	virtual HRESULT __safecall createComment(const System::WideString data, _di_IXMLDOMComment &__createComment_result) = 0 ;
	virtual HRESULT __safecall createCDATASection(const System::WideString data, _di_IXMLDOMCDATASection &__createCDATASection_result) = 0 ;
	virtual HRESULT __safecall createProcessingInstruction(const System::WideString target, const System::WideString data, _di_IXMLDOMProcessingInstruction &__createProcessingInstruction_result) = 0 ;
	virtual HRESULT __safecall createAttribute(const System::WideString name, _di_IXMLDOMAttribute &__createAttribute_result) = 0 ;
	virtual HRESULT __safecall createEntityReference(const System::WideString name, _di_IXMLDOMEntityReference &__createEntityReference_result) = 0 ;
	virtual HRESULT __safecall getElementsByTagName(const System::WideString tagName, _di_IXMLDOMNodeList &__getElementsByTagName_result) = 0 ;
	virtual HRESULT __safecall createNode(const System::OleVariant type_, const System::WideString name, const System::WideString namespaceURI, _di_IXMLDOMNode &__createNode_result) = 0 ;
	virtual HRESULT __safecall nodeFromID(const System::WideString idString, _di_IXMLDOMNode &__nodeFromID_result) = 0 ;
	virtual HRESULT __safecall load(const System::OleVariant xmlSource, System::WordBool &__load_result) = 0 ;
	virtual HRESULT __safecall Get_readyState(int &__Get_readyState_result) = 0 ;
	virtual HRESULT __safecall Get_parseError(_di_IXMLDOMParseError &__Get_parseError_result) = 0 ;
	virtual HRESULT __safecall Get_url(System::WideString &__Get_url_result) = 0 ;
	virtual HRESULT __safecall Get_async(System::WordBool &__Get_async_result) = 0 ;
	virtual HRESULT __safecall Set_async(System::WordBool isAsync) = 0 ;
	virtual HRESULT __safecall abort(void) = 0 ;
	virtual HRESULT __safecall loadXML(const System::WideString bstrXML, System::WordBool &__loadXML_result) = 0 ;
	virtual HRESULT __safecall save(const System::OleVariant desination) = 0 ;
	virtual HRESULT __safecall Get_validateOnParse(System::WordBool &__Get_validateOnParse_result) = 0 ;
	virtual HRESULT __safecall Set_validateOnParse(System::WordBool isValidating) = 0 ;
	virtual HRESULT __safecall Get_resolveExternals(System::WordBool &__Get_resolveExternals_result) = 0 ;
	virtual HRESULT __safecall Set_resolveExternals(System::WordBool isResolving) = 0 ;
	virtual HRESULT __safecall Get_preserveWhiteSpace(System::WordBool &__Get_preserveWhiteSpace_result) = 0 ;
	virtual HRESULT __safecall Set_preserveWhiteSpace(System::WordBool isPreserving) = 0 ;
	virtual HRESULT __safecall Set_onreadystatechange(const System::OleVariant Param1) = 0 ;
	virtual HRESULT __safecall Set_ondataavailable(const System::OleVariant Param1) = 0 ;
	virtual HRESULT __safecall Set_ontransformnode(const System::OleVariant Param1) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMDocumentType _scw_Get_doctype() { _di_IXMLDOMDocumentType __r; HRESULT __hr = Get_doctype(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMDocumentType doctype = {read=_scw_Get_doctype};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMImplementation _scw_Get_implementation_() { _di_IXMLDOMImplementation __r; HRESULT __hr = Get_implementation_(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMImplementation implementation_ = {read=_scw_Get_implementation_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMElement _scw_Get_documentElement() { _di_IXMLDOMElement __r; HRESULT __hr = Get_documentElement(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMElement documentElement = {read=_scw_Get_documentElement, write=Set_documentElement};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_readyState() { int __r; HRESULT __hr = Get_readyState(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int readyState = {read=_scw_Get_readyState};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMParseError _scw_Get_parseError() { _di_IXMLDOMParseError __r; HRESULT __hr = Get_parseError(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMParseError parseError = {read=_scw_Get_parseError};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_url() { System::WideString __r; HRESULT __hr = Get_url(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString url = {read=_scw_Get_url};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_async() { System::WordBool __r; HRESULT __hr = Get_async(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool async = {read=_scw_Get_async, write=Set_async};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_validateOnParse() { System::WordBool __r; HRESULT __hr = Get_validateOnParse(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool validateOnParse = {read=_scw_Get_validateOnParse, write=Set_validateOnParse};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_resolveExternals() { System::WordBool __r; HRESULT __hr = Get_resolveExternals(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool resolveExternals = {read=_scw_Get_resolveExternals, write=Set_resolveExternals};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WordBool _scw_Get_preserveWhiteSpace() { System::WordBool __r; HRESULT __hr = Get_preserveWhiteSpace(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WordBool preserveWhiteSpace = {read=_scw_Get_preserveWhiteSpace, write=Set_preserveWhiteSpace};
	__property System::OleVariant onreadystatechange = {write=Set_onreadystatechange};
	__property System::OleVariant ondataavailable = {write=Set_ondataavailable};
	__property System::OleVariant ontransformnode = {write=Set_ontransformnode};
};

__dispinterface  INTERFACE_UUID("{2933BF81-7B36-11D2-B20E-00C04F983E60}") IXMLDOMDocumentDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF8B-7B36-11D2-B20E-00C04F983E60}") IXMLDOMDocumentType  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_name(System::WideString &__Get_name_result) = 0 ;
	virtual HRESULT __safecall Get_entities(_di_IXMLDOMNamedNodeMap &__Get_entities_result) = 0 ;
	virtual HRESULT __safecall Get_notations(_di_IXMLDOMNamedNodeMap &__Get_notations_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_name() { System::WideString __r; HRESULT __hr = Get_name(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString name = {read=_scw_Get_name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNamedNodeMap _scw_Get_entities() { _di_IXMLDOMNamedNodeMap __r; HRESULT __hr = Get_entities(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNamedNodeMap entities = {read=_scw_Get_entities};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMNamedNodeMap _scw_Get_notations() { _di_IXMLDOMNamedNodeMap __r; HRESULT __hr = Get_notations(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMNamedNodeMap notations = {read=_scw_Get_notations};
};

__dispinterface  INTERFACE_UUID("{2933BF8B-7B36-11D2-B20E-00C04F983E60}") IXMLDOMDocumentTypeDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF86-7B36-11D2-B20E-00C04F983E60}") IXMLDOMElement  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_tagName(System::WideString &__Get_tagName_result) = 0 ;
	virtual HRESULT __safecall getAttribute(const System::WideString name, System::OleVariant &__getAttribute_result) = 0 ;
	virtual HRESULT __safecall setAttribute(const System::WideString name, const System::OleVariant value) = 0 ;
	virtual HRESULT __safecall removeAttribute(const System::WideString name) = 0 ;
	virtual HRESULT __safecall getAttributeNode(const System::WideString name, _di_IXMLDOMAttribute &__getAttributeNode_result) = 0 ;
	virtual HRESULT __safecall setAttributeNode(const _di_IXMLDOMAttribute DOMAttribute, _di_IXMLDOMAttribute &__setAttributeNode_result) = 0 ;
	virtual HRESULT __safecall removeAttributeNode(const _di_IXMLDOMAttribute DOMAttribute, _di_IXMLDOMAttribute &__removeAttributeNode_result) = 0 ;
	virtual HRESULT __safecall getElementsByTagName(const System::WideString tagName, _di_IXMLDOMNodeList &__getElementsByTagName_result) = 0 ;
	virtual HRESULT __safecall normalize(void) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_tagName() { System::WideString __r; HRESULT __hr = Get_tagName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString tagName = {read=_scw_Get_tagName};
};

__dispinterface  INTERFACE_UUID("{2933BF86-7B36-11D2-B20E-00C04F983E60}") IXMLDOMElementDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF85-7B36-11D2-B20E-00C04F983E60}") IXMLDOMAttribute  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_name(System::WideString &__Get_name_result) = 0 ;
	virtual HRESULT __safecall Get_value(System::OleVariant &__Get_value_result) = 0 ;
	virtual HRESULT __safecall Set_value(const System::OleVariant attributeValue) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_name() { System::WideString __r; HRESULT __hr = Get_name(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString name = {read=_scw_Get_name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_value() { System::OleVariant __r; HRESULT __hr = Get_value(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant value = {read=_scw_Get_value, write=Set_value};
};

__dispinterface  INTERFACE_UUID("{2933BF85-7B36-11D2-B20E-00C04F983E60}") IXMLDOMAttributeDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{3EFAA413-272F-11D2-836F-0000F87A7782}") IXMLDOMDocumentFragment  : public IXMLDOMNode 
{
	
};

__dispinterface  INTERFACE_UUID("{3EFAA413-272F-11D2-836F-0000F87A7782}") IXMLDOMDocumentFragmentDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF84-7B36-11D2-B20E-00C04F983E60}") IXMLDOMCharacterData  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_data(System::WideString &__Get_data_result) = 0 ;
	virtual HRESULT __safecall Set_data(const System::WideString data) = 0 ;
	virtual HRESULT __safecall Get_length(int &__Get_length_result) = 0 ;
	virtual HRESULT __safecall substringData(int offset, int count, System::WideString &__substringData_result) = 0 ;
	virtual HRESULT __safecall appendData(const System::WideString data) = 0 ;
	virtual HRESULT __safecall insertData(int offset, const System::WideString data) = 0 ;
	virtual HRESULT __safecall deleteData(int offset, int count) = 0 ;
	virtual HRESULT __safecall replaceData(int offset, int count, const System::WideString data) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_data() { System::WideString __r; HRESULT __hr = Get_data(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString data = {read=_scw_Get_data, write=Set_data};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_length() { int __r; HRESULT __hr = Get_length(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int length = {read=_scw_Get_length};
};

__dispinterface  INTERFACE_UUID("{2933BF84-7B36-11D2-B20E-00C04F983E60}") IXMLDOMCharacterDataDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF87-7B36-11D2-B20E-00C04F983E60}") IXMLDOMText  : public IXMLDOMCharacterData 
{
	virtual HRESULT __safecall splitText(int offset, _di_IXMLDOMText &__splitText_result) = 0 ;
};

__dispinterface  INTERFACE_UUID("{2933BF87-7B36-11D2-B20E-00C04F983E60}") IXMLDOMTextDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF88-7B36-11D2-B20E-00C04F983E60}") IXMLDOMComment  : public IXMLDOMCharacterData 
{
	
};

__dispinterface  INTERFACE_UUID("{2933BF88-7B36-11D2-B20E-00C04F983E60}") IXMLDOMCommentDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF8A-7B36-11D2-B20E-00C04F983E60}") IXMLDOMCDATASection  : public IXMLDOMText 
{
	
};

__dispinterface  INTERFACE_UUID("{2933BF8A-7B36-11D2-B20E-00C04F983E60}") IXMLDOMCDATASectionDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF89-7B36-11D2-B20E-00C04F983E60}") IXMLDOMProcessingInstruction  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_target(System::WideString &__Get_target_result) = 0 ;
	virtual HRESULT __safecall Get_data(System::WideString &__Get_data_result) = 0 ;
	virtual HRESULT __safecall Set_data(const System::WideString value) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_target() { System::WideString __r; HRESULT __hr = Get_target(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString target = {read=_scw_Get_target};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_data() { System::WideString __r; HRESULT __hr = Get_data(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString data = {read=_scw_Get_data, write=Set_data};
};

__dispinterface  INTERFACE_UUID("{2933BF89-7B36-11D2-B20E-00C04F983E60}") IXMLDOMProcessingInstructionDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF8E-7B36-11D2-B20E-00C04F983E60}") IXMLDOMEntityReference  : public IXMLDOMNode 
{
	
};

__dispinterface  INTERFACE_UUID("{2933BF8E-7B36-11D2-B20E-00C04F983E60}") IXMLDOMEntityReferenceDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{3EFAA426-272F-11D2-836F-0000F87A7782}") IXMLDOMParseError  : public IDispatch 
{
	virtual HRESULT __safecall Get_errorCode(int &__Get_errorCode_result) = 0 ;
	virtual HRESULT __safecall Get_url(System::WideString &__Get_url_result) = 0 ;
	virtual HRESULT __safecall Get_reason(System::WideString &__Get_reason_result) = 0 ;
	virtual HRESULT __safecall Get_srcText(System::WideString &__Get_srcText_result) = 0 ;
	virtual HRESULT __safecall Get_line(int &__Get_line_result) = 0 ;
	virtual HRESULT __safecall Get_linepos(int &__Get_linepos_result) = 0 ;
	virtual HRESULT __safecall Get_filepos(int &__Get_filepos_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_errorCode() { int __r; HRESULT __hr = Get_errorCode(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int errorCode = {read=_scw_Get_errorCode};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_url() { System::WideString __r; HRESULT __hr = Get_url(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString url = {read=_scw_Get_url};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_reason() { System::WideString __r; HRESULT __hr = Get_reason(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString reason = {read=_scw_Get_reason};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_srcText() { System::WideString __r; HRESULT __hr = Get_srcText(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString srcText = {read=_scw_Get_srcText};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_line() { int __r; HRESULT __hr = Get_line(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int line = {read=_scw_Get_line};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_linepos() { int __r; HRESULT __hr = Get_linepos(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int linepos = {read=_scw_Get_linepos};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_filepos() { int __r; HRESULT __hr = Get_filepos(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int filepos = {read=_scw_Get_filepos};
};

__dispinterface  INTERFACE_UUID("{3EFAA426-272F-11D2-836F-0000F87A7782}") IXMLDOMParseErrorDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF8C-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNotation  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_publicId(System::OleVariant &__Get_publicId_result) = 0 ;
	virtual HRESULT __safecall Get_systemId(System::OleVariant &__Get_systemId_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_publicId() { System::OleVariant __r; HRESULT __hr = Get_publicId(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant publicId = {read=_scw_Get_publicId};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_systemId() { System::OleVariant __r; HRESULT __hr = Get_systemId(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant systemId = {read=_scw_Get_systemId};
};

__dispinterface  INTERFACE_UUID("{2933BF8C-7B36-11D2-B20E-00C04F983E60}") IXMLDOMNotationDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2933BF8D-7B36-11D2-B20E-00C04F983E60}") IXMLDOMEntity  : public IXMLDOMNode 
{
	virtual HRESULT __safecall Get_publicId(System::OleVariant &__Get_publicId_result) = 0 ;
	virtual HRESULT __safecall Get_systemId(System::OleVariant &__Get_systemId_result) = 0 ;
	virtual HRESULT __safecall Get_notationName(System::WideString &__Get_notationName_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_publicId() { System::OleVariant __r; HRESULT __hr = Get_publicId(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant publicId = {read=_scw_Get_publicId};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_systemId() { System::OleVariant __r; HRESULT __hr = Get_systemId(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant systemId = {read=_scw_Get_systemId};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_notationName() { System::WideString __r; HRESULT __hr = Get_notationName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString notationName = {read=_scw_Get_notationName};
};

__dispinterface  INTERFACE_UUID("{2933BF8D-7B36-11D2-B20E-00C04F983E60}") IXMLDOMEntityDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{3EFAA425-272F-11D2-836F-0000F87A7782}") IXTLRuntime  : public IXMLDOMNode 
{
	virtual HRESULT __safecall uniqueID(const _di_IXMLDOMNode pNode, int &__uniqueID_result) = 0 ;
	virtual HRESULT __safecall depth(const _di_IXMLDOMNode pNode, int &__depth_result) = 0 ;
	virtual HRESULT __safecall childNumber(const _di_IXMLDOMNode pNode, int &__childNumber_result) = 0 ;
	virtual HRESULT __safecall ancestorChildNumber(const System::WideString bstrNodeName, const _di_IXMLDOMNode pNode, int &__ancestorChildNumber_result) = 0 ;
	virtual HRESULT __safecall absoluteChildNumber(const _di_IXMLDOMNode pNode, int &__absoluteChildNumber_result) = 0 ;
	virtual HRESULT __safecall formatIndex(int lIndex, const System::WideString bstrFormat, System::WideString &__formatIndex_result) = 0 ;
	virtual HRESULT __safecall formatNumber(double dblNumber, const System::WideString bstrFormat, System::WideString &__formatNumber_result) = 0 ;
	virtual HRESULT __safecall formatDate(const System::OleVariant varDate, const System::WideString bstrFormat, const System::OleVariant varDestLocale, System::WideString &__formatDate_result) = 0 ;
	virtual HRESULT __safecall formatTime(const System::OleVariant varTime, const System::WideString bstrFormat, const System::OleVariant varDestLocale, System::WideString &__formatTime_result) = 0 ;
};

__dispinterface  INTERFACE_UUID("{3EFAA425-272F-11D2-836F-0000F87A7782}") IXTLRuntimeDisp  : public IDispatch 
{
	
};

__dispinterface  INTERFACE_UUID("{3EFAA427-272F-11D2-836F-0000F87A7782}") XMLDOMDocumentEvents  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{ED8C108D-4349-11D2-91A4-00C04F7969E8}") IXMLHttpRequest  : public IDispatch 
{
	virtual HRESULT __safecall open(const System::WideString bstrMethod, const System::WideString bstrUrl, const System::OleVariant varAsync, const System::OleVariant bstrUser, const System::OleVariant bstrPassword) = 0 ;
	virtual HRESULT __safecall setRequestHeader(const System::WideString bstrHeader, const System::WideString bstrValue) = 0 ;
	virtual HRESULT __safecall getResponseHeader(const System::WideString bstrHeader, System::WideString &__getResponseHeader_result) = 0 ;
	virtual HRESULT __safecall getAllResponseHeaders(System::WideString &__getAllResponseHeaders_result) = 0 ;
	virtual HRESULT __safecall send(const System::OleVariant varBody) = 0 ;
	virtual HRESULT __safecall abort(void) = 0 ;
	virtual HRESULT __safecall Get_status(int &__Get_status_result) = 0 ;
	virtual HRESULT __safecall Get_statusText(System::WideString &__Get_statusText_result) = 0 ;
	virtual HRESULT __safecall Get_responseXML(_di_IDispatch &__Get_responseXML_result) = 0 ;
	virtual HRESULT __safecall Get_responseText(System::WideString &__Get_responseText_result) = 0 ;
	virtual HRESULT __safecall Get_responseBody(System::OleVariant &__Get_responseBody_result) = 0 ;
	virtual HRESULT __safecall Get_responseStream(System::OleVariant &__Get_responseStream_result) = 0 ;
	virtual HRESULT __safecall Get_readyState(int &__Get_readyState_result) = 0 ;
	virtual HRESULT __safecall Set_onreadystatechange(const _di_IDispatch Param1) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_status() { int __r; HRESULT __hr = Get_status(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int status = {read=_scw_Get_status};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_statusText() { System::WideString __r; HRESULT __hr = Get_statusText(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString statusText = {read=_scw_Get_statusText};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IDispatch _scw_Get_responseXML() { _di_IDispatch __r; HRESULT __hr = Get_responseXML(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IDispatch responseXML = {read=_scw_Get_responseXML};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_responseText() { System::WideString __r; HRESULT __hr = Get_responseText(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString responseText = {read=_scw_Get_responseText};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_responseBody() { System::OleVariant __r; HRESULT __hr = Get_responseBody(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant responseBody = {read=_scw_Get_responseBody};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::OleVariant _scw_Get_responseStream() { System::OleVariant __r; HRESULT __hr = Get_responseStream(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::OleVariant responseStream = {read=_scw_Get_responseStream};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_readyState() { int __r; HRESULT __hr = Get_readyState(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int readyState = {read=_scw_Get_readyState};
	__property _di_IDispatch onreadystatechange = {write=Set_onreadystatechange};
};

__dispinterface  INTERFACE_UUID("{ED8C108D-4349-11D2-91A4-00C04F7969E8}") IXMLHttpRequestDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{310AFA62-0575-11D2-9CA9-0060B0EC3D39}") IXMLDSOControl  : public IDispatch 
{
	virtual HRESULT __safecall Get_XMLDocument(_di_IXMLDOMDocument &__Get_XMLDocument_result) = 0 ;
	virtual HRESULT __safecall Set_XMLDocument(const _di_IXMLDOMDocument ppDoc) = 0 ;
	virtual HRESULT __safecall Get_JavaDSOCompatible(int &__Get_JavaDSOCompatible_result) = 0 ;
	virtual HRESULT __safecall Set_JavaDSOCompatible(int fJavaDSOCompatible) = 0 ;
	virtual HRESULT __safecall Get_readyState(int &__Get_readyState_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLDOMDocument _scw_Get_XMLDocument() { _di_IXMLDOMDocument __r; HRESULT __hr = Get_XMLDocument(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLDOMDocument XMLDocument = {read=_scw_Get_XMLDocument, write=Set_XMLDocument};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_JavaDSOCompatible() { int __r; HRESULT __hr = Get_JavaDSOCompatible(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int JavaDSOCompatible = {read=_scw_Get_JavaDSOCompatible, write=Set_JavaDSOCompatible};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_readyState() { int __r; HRESULT __hr = Get_readyState(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int readyState = {read=_scw_Get_readyState};
};

__dispinterface  INTERFACE_UUID("{310AFA62-0575-11D2-9CA9-0060B0EC3D39}") IXMLDSOControlDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{65725580-9B5D-11D0-9BFE-00C04FC99C8E}") IXMLElementCollection  : public IDispatch 
{
	virtual HRESULT __safecall Set_length(int p) = 0 ;
	virtual HRESULT __safecall Get_length(int &__Get_length_result) = 0 ;
	virtual HRESULT __safecall Get__newEnum(System::_di_IInterface &__Get__newEnum_result) = 0 ;
	virtual HRESULT __safecall item(const System::OleVariant var1, const System::OleVariant var2, _di_IDispatch &__item_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_length() { int __r; HRESULT __hr = Get_length(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int length = {read=_scw_Get_length, write=Set_length};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::_di_IInterface _scw_Get__newEnum() { System::_di_IInterface __r; HRESULT __hr = Get__newEnum(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::_di_IInterface _newEnum = {read=_scw_Get__newEnum};
};

__dispinterface  INTERFACE_UUID("{65725580-9B5D-11D0-9BFE-00C04FC99C8E}") IXMLElementCollectionDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{F52E2B61-18A1-11D1-B105-00805F49916B}") IXMLDocument  : public IDispatch 
{
	virtual HRESULT __safecall Get_root(_di_IXMLElement &__Get_root_result) = 0 ;
	virtual HRESULT __safecall Get_fileSize(System::WideString &__Get_fileSize_result) = 0 ;
	virtual HRESULT __safecall Get_fileModifiedDate(System::WideString &__Get_fileModifiedDate_result) = 0 ;
	virtual HRESULT __safecall Get_fileUpdatedDate(System::WideString &__Get_fileUpdatedDate_result) = 0 ;
	virtual HRESULT __safecall Get_url(System::WideString &__Get_url_result) = 0 ;
	virtual HRESULT __safecall Set_url(const System::WideString p) = 0 ;
	virtual HRESULT __safecall Get_mimeType(System::WideString &__Get_mimeType_result) = 0 ;
	virtual HRESULT __safecall Get_readyState(int &__Get_readyState_result) = 0 ;
	virtual HRESULT __safecall Get_charset(System::WideString &__Get_charset_result) = 0 ;
	virtual HRESULT __safecall Set_charset(const System::WideString p) = 0 ;
	virtual HRESULT __safecall Get_version(System::WideString &__Get_version_result) = 0 ;
	virtual HRESULT __safecall Get_doctype(System::WideString &__Get_doctype_result) = 0 ;
	virtual HRESULT __safecall Get_dtdURL(System::WideString &__Get_dtdURL_result) = 0 ;
	virtual HRESULT __safecall createElement(const System::OleVariant vType, const System::OleVariant var1, _di_IXMLElement &__createElement_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElement _scw_Get_root() { _di_IXMLElement __r; HRESULT __hr = Get_root(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElement root = {read=_scw_Get_root};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_fileSize() { System::WideString __r; HRESULT __hr = Get_fileSize(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString fileSize = {read=_scw_Get_fileSize};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_fileModifiedDate() { System::WideString __r; HRESULT __hr = Get_fileModifiedDate(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString fileModifiedDate = {read=_scw_Get_fileModifiedDate};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_fileUpdatedDate() { System::WideString __r; HRESULT __hr = Get_fileUpdatedDate(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString fileUpdatedDate = {read=_scw_Get_fileUpdatedDate};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_url() { System::WideString __r; HRESULT __hr = Get_url(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString url = {read=_scw_Get_url, write=Set_url};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_mimeType() { System::WideString __r; HRESULT __hr = Get_mimeType(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString mimeType = {read=_scw_Get_mimeType};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_readyState() { int __r; HRESULT __hr = Get_readyState(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int readyState = {read=_scw_Get_readyState};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_charset() { System::WideString __r; HRESULT __hr = Get_charset(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString charset = {read=_scw_Get_charset, write=Set_charset};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_version() { System::WideString __r; HRESULT __hr = Get_version(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString version = {read=_scw_Get_version};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_doctype() { System::WideString __r; HRESULT __hr = Get_doctype(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString doctype = {read=_scw_Get_doctype};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_dtdURL() { System::WideString __r; HRESULT __hr = Get_dtdURL(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString dtdURL = {read=_scw_Get_dtdURL};
};

__dispinterface  INTERFACE_UUID("{F52E2B61-18A1-11D1-B105-00805F49916B}") IXMLDocumentDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{3F7F31AC-E15F-11D0-9C25-00C04FC99C8E}") IXMLElement  : public IDispatch 
{
	virtual HRESULT __safecall Get_tagName(System::WideString &__Get_tagName_result) = 0 ;
	virtual HRESULT __safecall Set_tagName(const System::WideString p) = 0 ;
	virtual HRESULT __safecall Get_parent(_di_IXMLElement &__Get_parent_result) = 0 ;
	virtual HRESULT __safecall setAttribute(const System::WideString strPropertyName, const System::OleVariant PropertyValue) = 0 ;
	virtual HRESULT __safecall getAttribute(const System::WideString strPropertyName, System::OleVariant &__getAttribute_result) = 0 ;
	virtual HRESULT __safecall removeAttribute(const System::WideString strPropertyName) = 0 ;
	virtual HRESULT __safecall Get_children(_di_IXMLElementCollection &__Get_children_result) = 0 ;
	virtual HRESULT __safecall Get_type_(int &__Get_type__result) = 0 ;
	virtual HRESULT __safecall Get_text(System::WideString &__Get_text_result) = 0 ;
	virtual HRESULT __safecall Set_text(const System::WideString p) = 0 ;
	virtual HRESULT __safecall addChild(const _di_IXMLElement pChildElem, int lIndex, int lReserved) = 0 ;
	virtual HRESULT __safecall removeChild(const _di_IXMLElement pChildElem) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_tagName() { System::WideString __r; HRESULT __hr = Get_tagName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString tagName = {read=_scw_Get_tagName, write=Set_tagName};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElement _scw_Get_parent() { _di_IXMLElement __r; HRESULT __hr = Get_parent(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElement parent = {read=_scw_Get_parent};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElementCollection _scw_Get_children() { _di_IXMLElementCollection __r; HRESULT __hr = Get_children(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElementCollection children = {read=_scw_Get_children};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_type_() { int __r; HRESULT __hr = Get_type_(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int type_ = {read=_scw_Get_type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_text() { System::WideString __r; HRESULT __hr = Get_text(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString text = {read=_scw_Get_text, write=Set_text};
};

__dispinterface  INTERFACE_UUID("{3F7F31AC-E15F-11D0-9C25-00C04FC99C8E}") IXMLElementDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{2B8DE2FE-8D2D-11D1-B2FC-00C04FD915A9}") IXMLDocument2  : public IDispatch 
{
	virtual HRESULT __stdcall Get_root(/* out */ _di_IXMLElement2 &p) = 0 ;
	virtual HRESULT __stdcall Get_fileSize(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_fileModifiedDate(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_fileUpdatedDate(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_url(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Set_url(const System::WideString p) = 0 ;
	virtual HRESULT __stdcall Get_mimeType(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_readyState(/* out */ int &pl) = 0 ;
	virtual HRESULT __stdcall Get_charset(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Set_charset(const System::WideString p) = 0 ;
	virtual HRESULT __stdcall Get_version(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_doctype(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall Get_dtdURL(/* out */ System::WideString &p) = 0 ;
	virtual HRESULT __stdcall createElement(const System::OleVariant vType, const System::OleVariant var1, /* out */ _di_IXMLElement2 &ppElem) = 0 ;
	virtual HRESULT __stdcall Get_async(/* out */ System::WordBool &pf) = 0 ;
	virtual HRESULT __stdcall Set_async(System::WordBool pf) = 0 ;
};

__interface  INTERFACE_UUID("{2B8DE2FF-8D2D-11D1-B2FC-00C04FD915A9}") IXMLElement2  : public IDispatch 
{
	virtual HRESULT __safecall Get_tagName(System::WideString &__Get_tagName_result) = 0 ;
	virtual HRESULT __safecall Set_tagName(const System::WideString p) = 0 ;
	virtual HRESULT __safecall Get_parent(_di_IXMLElement2 &__Get_parent_result) = 0 ;
	virtual HRESULT __safecall setAttribute(const System::WideString strPropertyName, const System::OleVariant PropertyValue) = 0 ;
	virtual HRESULT __safecall getAttribute(const System::WideString strPropertyName, System::OleVariant &__getAttribute_result) = 0 ;
	virtual HRESULT __safecall removeAttribute(const System::WideString strPropertyName) = 0 ;
	virtual HRESULT __safecall Get_children(_di_IXMLElementCollection &__Get_children_result) = 0 ;
	virtual HRESULT __safecall Get_type_(int &__Get_type__result) = 0 ;
	virtual HRESULT __safecall Get_text(System::WideString &__Get_text_result) = 0 ;
	virtual HRESULT __safecall Set_text(const System::WideString p) = 0 ;
	virtual HRESULT __safecall addChild(const _di_IXMLElement2 pChildElem, int lIndex, int lReserved) = 0 ;
	virtual HRESULT __safecall removeChild(const _di_IXMLElement2 pChildElem) = 0 ;
	virtual HRESULT __safecall Get_attributes(_di_IXMLElementCollection &__Get_attributes_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_tagName() { System::WideString __r; HRESULT __hr = Get_tagName(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString tagName = {read=_scw_Get_tagName, write=Set_tagName};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElement2 _scw_Get_parent() { _di_IXMLElement2 __r; HRESULT __hr = Get_parent(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElement2 parent = {read=_scw_Get_parent};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElementCollection _scw_Get_children() { _di_IXMLElementCollection __r; HRESULT __hr = Get_children(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElementCollection children = {read=_scw_Get_children};
	#pragma option push -w-inl
	/* safecall wrapper */ inline int _scw_Get_type_() { int __r; HRESULT __hr = Get_type_(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property int type_ = {read=_scw_Get_type_};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_text() { System::WideString __r; HRESULT __hr = Get_text(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString text = {read=_scw_Get_text, write=Set_text};
	#pragma option push -w-inl
	/* safecall wrapper */ inline _di_IXMLElementCollection _scw_Get_attributes() { _di_IXMLElementCollection __r; HRESULT __hr = Get_attributes(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property _di_IXMLElementCollection attributes = {read=_scw_Get_attributes};
};

__dispinterface  INTERFACE_UUID("{2B8DE2FF-8D2D-11D1-B2FC-00C04FD915A9}") IXMLElement2Disp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{D4D4A0FC-3B73-11D1-B2B4-00C04FB92596}") IXMLAttribute  : public IDispatch 
{
	virtual HRESULT __safecall Get_name(System::WideString &__Get_name_result) = 0 ;
	virtual HRESULT __safecall Get_value(System::WideString &__Get_value_result) = 0 ;
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_name() { System::WideString __r; HRESULT __hr = Get_name(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString name = {read=_scw_Get_name};
	#pragma option push -w-inl
	/* safecall wrapper */ inline System::WideString _scw_Get_value() { System::WideString __r; HRESULT __hr = Get_value(__r); System::CheckSafecallResult(__hr); return __r; }
	#pragma option pop
	__property System::WideString value = {read=_scw_Get_value};
};

__dispinterface  INTERFACE_UUID("{D4D4A0FC-3B73-11D1-B2B4-00C04FB92596}") IXMLAttributeDisp  : public IDispatch 
{
	
};

__interface  INTERFACE_UUID("{948C5AD3-C58D-11D0-9C0B-00C04FC99C8E}") IXMLError  : public System::IInterface 
{
	virtual HRESULT __stdcall GetErrorInfo(GUID &pErrorReturn) = 0 ;
};

#pragma pack(push,4)
class PASCALIMPLEMENTATION CoDOMDocument : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IXMLDOMDocument __fastcall Create();
	__classmethod _di_IXMLDOMDocument __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoDOMDocument(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoDOMDocument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TDOMDocument : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	System::Classes::TNotifyEvent FOnondataavailable;
	System::Classes::TNotifyEvent FOnonreadystatechange;
	_di_IXMLDOMDocument FIntf;
	_di_IXMLDOMDocument __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, System::Win::Comobj::TOleVariantArray &Params);
	_di_IXMLDOMDocumentType __fastcall Get_doctype(void);
	_di_IXMLDOMImplementation __fastcall Get_implementation_(void);
	_di_IXMLDOMElement __fastcall Get_documentElement(void);
	void __fastcall Set_documentElement(const _di_IXMLDOMElement DOMElement);
	int __fastcall Get_readyState(void);
	_di_IXMLDOMParseError __fastcall Get_parseError(void);
	System::WideString __fastcall Get_url(void);
	System::WordBool __fastcall Get_async(void);
	void __fastcall Set_async(System::WordBool isAsync);
	System::WordBool __fastcall Get_validateOnParse(void);
	void __fastcall Set_validateOnParse(System::WordBool isValidating);
	System::WordBool __fastcall Get_resolveExternals(void);
	void __fastcall Set_resolveExternals(System::WordBool isResolving);
	System::WordBool __fastcall Get_preserveWhiteSpace(void);
	void __fastcall Set_preserveWhiteSpace(System::WordBool isPreserving);
	void __fastcall Set_onreadystatechange(const System::OleVariant &Param1);
	void __fastcall Set_ondataavailable(const System::OleVariant &Param1);
	void __fastcall Set_ontransformnode(const System::OleVariant &Param1);
	
public:
	__fastcall virtual TDOMDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDOMDocument(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IXMLDOMDocument svrIntf);
	virtual void __fastcall Disconnect(void);
	_di_IXMLDOMElement __fastcall createElement(const System::WideString tagName);
	_di_IXMLDOMDocumentFragment __fastcall createDocumentFragment(void);
	_di_IXMLDOMText __fastcall createTextNode(const System::WideString data);
	_di_IXMLDOMComment __fastcall createComment(const System::WideString data);
	_di_IXMLDOMCDATASection __fastcall createCDATASection(const System::WideString data);
	_di_IXMLDOMProcessingInstruction __fastcall createProcessingInstruction(const System::WideString target, const System::WideString data);
	_di_IXMLDOMAttribute __fastcall createAttribute(const System::WideString name);
	_di_IXMLDOMEntityReference __fastcall createEntityReference(const System::WideString name);
	_di_IXMLDOMNodeList __fastcall getElementsByTagName(const System::WideString tagName);
	_di_IXMLDOMNode __fastcall createNode(const System::OleVariant &type_, const System::WideString name, const System::WideString namespaceURI);
	_di_IXMLDOMNode __fastcall nodeFromID(const System::WideString idString);
	System::WordBool __fastcall load(const System::OleVariant &xmlSource);
	void __fastcall abort(void);
	System::WordBool __fastcall loadXML(const System::WideString bstrXML);
	void __fastcall save(const System::OleVariant &desination);
	__property _di_IXMLDOMDocument DefaultInterface = {read=GetDefaultInterface};
	__property _di_IXMLDOMDocumentType doctype = {read=Get_doctype};
	__property _di_IXMLDOMImplementation implementation_ = {read=Get_implementation_};
	__property _di_IXMLDOMElement documentElement = {read=Get_documentElement, write=Set_documentElement};
	__property int readyState = {read=Get_readyState, nodefault};
	__property _di_IXMLDOMParseError parseError = {read=Get_parseError};
	__property System::WideString url = {read=Get_url};
	__property System::OleVariant onreadystatechange = {write=Set_onreadystatechange};
	__property System::OleVariant ondataavailable = {write=Set_ondataavailable};
	__property System::OleVariant ontransformnode = {write=Set_ontransformnode};
	__property System::WordBool async = {read=Get_async, write=Set_async, nodefault};
	__property System::WordBool validateOnParse = {read=Get_validateOnParse, write=Set_validateOnParse, nodefault};
	__property System::WordBool resolveExternals = {read=Get_resolveExternals, write=Set_resolveExternals, nodefault};
	__property System::WordBool preserveWhiteSpace = {read=Get_preserveWhiteSpace, write=Set_preserveWhiteSpace, nodefault};
	
__published:
	__property System::Classes::TNotifyEvent Onondataavailable = {read=FOnondataavailable, write=FOnondataavailable};
	__property System::Classes::TNotifyEvent Ononreadystatechange = {read=FOnonreadystatechange, write=FOnonreadystatechange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoDOMFreeThreadedDocument : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IXMLDOMDocument __fastcall Create();
	__classmethod _di_IXMLDOMDocument __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoDOMFreeThreadedDocument(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoDOMFreeThreadedDocument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TDOMFreeThreadedDocument : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	System::Classes::TNotifyEvent FOnondataavailable;
	System::Classes::TNotifyEvent FOnonreadystatechange;
	_di_IXMLDOMDocument FIntf;
	_di_IXMLDOMDocument __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	virtual void __fastcall InvokeEvent(int DispID, System::Win::Comobj::TOleVariantArray &Params);
	_di_IXMLDOMDocumentType __fastcall Get_doctype(void);
	_di_IXMLDOMImplementation __fastcall Get_implementation_(void);
	_di_IXMLDOMElement __fastcall Get_documentElement(void);
	void __fastcall Set_documentElement(const _di_IXMLDOMElement DOMElement);
	int __fastcall Get_readyState(void);
	_di_IXMLDOMParseError __fastcall Get_parseError(void);
	System::WideString __fastcall Get_url(void);
	System::WordBool __fastcall Get_async(void);
	void __fastcall Set_async(System::WordBool isAsync);
	System::WordBool __fastcall Get_validateOnParse(void);
	void __fastcall Set_validateOnParse(System::WordBool isValidating);
	System::WordBool __fastcall Get_resolveExternals(void);
	void __fastcall Set_resolveExternals(System::WordBool isResolving);
	System::WordBool __fastcall Get_preserveWhiteSpace(void);
	void __fastcall Set_preserveWhiteSpace(System::WordBool isPreserving);
	void __fastcall Set_onreadystatechange(const System::OleVariant &Param1);
	void __fastcall Set_ondataavailable(const System::OleVariant &Param1);
	void __fastcall Set_ontransformnode(const System::OleVariant &Param1);
	
public:
	__fastcall virtual TDOMFreeThreadedDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TDOMFreeThreadedDocument(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IXMLDOMDocument svrIntf);
	virtual void __fastcall Disconnect(void);
	_di_IXMLDOMElement __fastcall createElement(const System::WideString tagName);
	_di_IXMLDOMDocumentFragment __fastcall createDocumentFragment(void);
	_di_IXMLDOMText __fastcall createTextNode(const System::WideString data);
	_di_IXMLDOMComment __fastcall createComment(const System::WideString data);
	_di_IXMLDOMCDATASection __fastcall createCDATASection(const System::WideString data);
	_di_IXMLDOMProcessingInstruction __fastcall createProcessingInstruction(const System::WideString target, const System::WideString data);
	_di_IXMLDOMAttribute __fastcall createAttribute(const System::WideString name);
	_di_IXMLDOMEntityReference __fastcall createEntityReference(const System::WideString name);
	_di_IXMLDOMNodeList __fastcall getElementsByTagName(const System::WideString tagName);
	_di_IXMLDOMNode __fastcall createNode(const System::OleVariant &type_, const System::WideString name, const System::WideString namespaceURI);
	_di_IXMLDOMNode __fastcall nodeFromID(const System::WideString idString);
	System::WordBool __fastcall load(const System::OleVariant &xmlSource);
	void __fastcall abort(void);
	System::WordBool __fastcall loadXML(const System::WideString bstrXML);
	void __fastcall save(const System::OleVariant &desination);
	__property _di_IXMLDOMDocument DefaultInterface = {read=GetDefaultInterface};
	__property _di_IXMLDOMDocumentType doctype = {read=Get_doctype};
	__property _di_IXMLDOMImplementation implementation_ = {read=Get_implementation_};
	__property _di_IXMLDOMElement documentElement = {read=Get_documentElement, write=Set_documentElement};
	__property int readyState = {read=Get_readyState, nodefault};
	__property _di_IXMLDOMParseError parseError = {read=Get_parseError};
	__property System::WideString url = {read=Get_url};
	__property System::OleVariant onreadystatechange = {write=Set_onreadystatechange};
	__property System::OleVariant ondataavailable = {write=Set_ondataavailable};
	__property System::OleVariant ontransformnode = {write=Set_ontransformnode};
	__property System::WordBool async = {read=Get_async, write=Set_async, nodefault};
	__property System::WordBool validateOnParse = {read=Get_validateOnParse, write=Set_validateOnParse, nodefault};
	__property System::WordBool resolveExternals = {read=Get_resolveExternals, write=Set_resolveExternals, nodefault};
	__property System::WordBool preserveWhiteSpace = {read=Get_preserveWhiteSpace, write=Set_preserveWhiteSpace, nodefault};
	
__published:
	__property System::Classes::TNotifyEvent Onondataavailable = {read=FOnondataavailable, write=FOnondataavailable};
	__property System::Classes::TNotifyEvent Ononreadystatechange = {read=FOnonreadystatechange, write=FOnonreadystatechange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoXMLHTTPRequest : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IXMLHttpRequest __fastcall Create();
	__classmethod _di_IXMLHttpRequest __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoXMLHTTPRequest(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoXMLHTTPRequest(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TXMLHTTPRequest : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IXMLHttpRequest FIntf;
	_di_IXMLHttpRequest __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	int __fastcall Get_status(void);
	System::WideString __fastcall Get_statusText(void);
	_di_IDispatch __fastcall Get_responseXML(void);
	System::WideString __fastcall Get_responseText(void);
	System::OleVariant __fastcall Get_responseBody(void);
	System::OleVariant __fastcall Get_responseStream(void);
	int __fastcall Get_readyState(void);
	void __fastcall Set_onreadystatechange(const _di_IDispatch Param1);
	
public:
	__fastcall virtual TXMLHTTPRequest(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TXMLHTTPRequest(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IXMLHttpRequest svrIntf);
	virtual void __fastcall Disconnect(void);
	void __fastcall open(const System::WideString bstrMethod, const System::WideString bstrUrl)/* overload */;
	void __fastcall open(const System::WideString bstrMethod, const System::WideString bstrUrl, const System::OleVariant &varAsync)/* overload */;
	void __fastcall open(const System::WideString bstrMethod, const System::WideString bstrUrl, const System::OleVariant &varAsync, const System::OleVariant &bstrUser)/* overload */;
	void __fastcall open(const System::WideString bstrMethod, const System::WideString bstrUrl, const System::OleVariant &varAsync, const System::OleVariant &bstrUser, const System::OleVariant &bstrPassword)/* overload */;
	void __fastcall setRequestHeader(const System::WideString bstrHeader, const System::WideString bstrValue);
	System::WideString __fastcall getResponseHeader(const System::WideString bstrHeader);
	System::WideString __fastcall getAllResponseHeaders(void);
	void __fastcall send(void)/* overload */;
	void __fastcall send(const System::OleVariant &varBody)/* overload */;
	void __fastcall abort(void);
	__property _di_IXMLHttpRequest DefaultInterface = {read=GetDefaultInterface};
	__property int status = {read=Get_status, nodefault};
	__property System::WideString statusText = {read=Get_statusText};
	__property _di_IDispatch responseXML = {read=Get_responseXML};
	__property System::WideString responseText = {read=Get_responseText};
	__property System::OleVariant responseBody = {read=Get_responseBody};
	__property System::OleVariant responseStream = {read=Get_responseStream};
	__property int readyState = {read=Get_readyState, nodefault};
	__property _di_IDispatch onreadystatechange = {write=Set_onreadystatechange};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoXMLDSOControl : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IXMLDSOControl __fastcall Create();
	__classmethod _di_IXMLDSOControl __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoXMLDSOControl(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoXMLDSOControl(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TXMLDSOControl : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IXMLDSOControl FIntf;
	_di_IXMLDSOControl __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	_di_IXMLDOMDocument __fastcall Get_XMLDocument(void);
	void __fastcall Set_XMLDocument(const _di_IXMLDOMDocument ppDoc);
	int __fastcall Get_JavaDSOCompatible(void);
	void __fastcall Set_JavaDSOCompatible(int fJavaDSOCompatible);
	int __fastcall Get_readyState(void);
	
public:
	__fastcall virtual TXMLDSOControl(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TXMLDSOControl(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IXMLDSOControl svrIntf);
	virtual void __fastcall Disconnect(void);
	__property _di_IXMLDSOControl DefaultInterface = {read=GetDefaultInterface};
	__property int readyState = {read=Get_readyState, nodefault};
	__property _di_IXMLDOMDocument XMLDocument = {read=Get_XMLDocument, write=Set_XMLDocument};
	__property int JavaDSOCompatible = {read=Get_JavaDSOCompatible, write=Set_JavaDSOCompatible, nodefault};
};


#pragma pack(push,4)
class PASCALIMPLEMENTATION CoXMLDocument : public System::TObject
{
	typedef System::TObject inherited;
	
public:
	__classmethod _di_IXMLDocument2 __fastcall Create();
	__classmethod _di_IXMLDocument2 __fastcall CreateRemote(const System::UnicodeString MachineName);
public:
	/* TObject.Create */ inline __fastcall CoXMLDocument(void) : System::TObject() { }
	/* TObject.Destroy */ inline __fastcall virtual ~CoXMLDocument(void) { }
	
};

#pragma pack(pop)

class PASCALIMPLEMENTATION TXMLDocument : public Vcl::Oleserver::TOleServer
{
	typedef Vcl::Oleserver::TOleServer inherited;
	
private:
	_di_IXMLDocument2 FIntf;
	_di_IXMLDocument2 __fastcall GetDefaultInterface(void);
	
protected:
	virtual void __fastcall InitServerData(void);
	HRESULT __fastcall Get_root(/* out */ _di_IXMLElement2 &p);
	HRESULT __fastcall Get_url(/* out */ System::WideString &p);
	HRESULT __fastcall Set_url(const System::WideString p);
	HRESULT __fastcall Get_readyState(/* out */ int &pl);
	HRESULT __fastcall Get_charset(/* out */ System::WideString &p);
	HRESULT __fastcall Set_charset(const System::WideString p);
	HRESULT __fastcall Get_version(/* out */ System::WideString &p);
	HRESULT __fastcall Get_doctype(/* out */ System::WideString &p);
	HRESULT __fastcall Get_async(/* out */ System::WordBool &pf);
	HRESULT __fastcall Set_async(System::WordBool pf);
	
public:
	__fastcall virtual TXMLDocument(System::Classes::TComponent* AOwner);
	__fastcall virtual ~TXMLDocument(void);
	virtual void __fastcall Connect(void);
	void __fastcall ConnectTo(_di_IXMLDocument2 svrIntf);
	virtual void __fastcall Disconnect(void);
	HRESULT __fastcall createElement(const System::OleVariant &vType, const System::OleVariant &var1, /* out */ _di_IXMLElement2 &ppElem);
	__property _di_IXMLDocument2 DefaultInterface = {read=GetDefaultInterface};
};


//-- var, const, procedure ---------------------------------------------------
static const System::Int8 MSXMLMajorVersion = System::Int8(0x2);
static const System::Int8 MSXMLMinorVersion = System::Int8(0x0);
extern DELPHI_PACKAGE GUID LIBID_MSXML;
extern DELPHI_PACKAGE GUID IID_IXMLDOMImplementation;
extern DELPHI_PACKAGE GUID IID_IXMLDOMNode;
extern DELPHI_PACKAGE GUID IID_IXMLDOMNodeList;
extern DELPHI_PACKAGE GUID IID_IXMLDOMNamedNodeMap;
extern DELPHI_PACKAGE GUID IID_IXMLDOMDocument;
extern DELPHI_PACKAGE GUID IID_IXMLDOMDocumentType;
extern DELPHI_PACKAGE GUID IID_IXMLDOMElement;
extern DELPHI_PACKAGE GUID IID_IXMLDOMAttribute;
extern DELPHI_PACKAGE GUID IID_IXMLDOMDocumentFragment;
extern DELPHI_PACKAGE GUID IID_IXMLDOMCharacterData;
extern DELPHI_PACKAGE GUID IID_IXMLDOMText;
extern DELPHI_PACKAGE GUID IID_IXMLDOMComment;
extern DELPHI_PACKAGE GUID IID_IXMLDOMCDATASection;
extern DELPHI_PACKAGE GUID IID_IXMLDOMProcessingInstruction;
extern DELPHI_PACKAGE GUID IID_IXMLDOMEntityReference;
extern DELPHI_PACKAGE GUID IID_IXMLDOMParseError;
extern DELPHI_PACKAGE GUID IID_IXMLDOMNotation;
extern DELPHI_PACKAGE GUID IID_IXMLDOMEntity;
extern DELPHI_PACKAGE GUID IID_IXTLRuntime;
extern DELPHI_PACKAGE GUID DIID_XMLDOMDocumentEvents;
extern DELPHI_PACKAGE GUID CLASS_DOMDocument;
extern DELPHI_PACKAGE GUID CLASS_DOMFreeThreadedDocument;
extern DELPHI_PACKAGE GUID IID_IXMLHttpRequest;
extern DELPHI_PACKAGE GUID CLASS_XMLHTTPRequest;
extern DELPHI_PACKAGE GUID IID_IXMLDSOControl;
extern DELPHI_PACKAGE GUID CLASS_XMLDSOControl;
extern DELPHI_PACKAGE GUID IID_IXMLElementCollection;
extern DELPHI_PACKAGE GUID IID_IXMLDocument;
extern DELPHI_PACKAGE GUID IID_IXMLElement;
extern DELPHI_PACKAGE GUID IID_IXMLDocument2;
extern DELPHI_PACKAGE GUID IID_IXMLElement2;
extern DELPHI_PACKAGE GUID IID_IXMLAttribute;
extern DELPHI_PACKAGE GUID IID_IXMLError;
extern DELPHI_PACKAGE GUID CLASS_XMLDocument;
static const System::Int8 NODE_INVALID = System::Int8(0x0);
static const System::Int8 NODE_ELEMENT = System::Int8(0x1);
static const System::Int8 NODE_ATTRIBUTE = System::Int8(0x2);
static const System::Int8 NODE_TEXT = System::Int8(0x3);
static const System::Int8 NODE_CDATA_SECTION = System::Int8(0x4);
static const System::Int8 NODE_ENTITY_REFERENCE = System::Int8(0x5);
static const System::Int8 NODE_ENTITY = System::Int8(0x6);
static const System::Int8 NODE_PROCESSING_INSTRUCTION = System::Int8(0x7);
static const System::Int8 NODE_COMMENT = System::Int8(0x8);
static const System::Int8 NODE_DOCUMENT = System::Int8(0x9);
static const System::Int8 NODE_DOCUMENT_TYPE = System::Int8(0xa);
static const System::Int8 NODE_DOCUMENT_FRAGMENT = System::Int8(0xb);
static const System::Int8 NODE_NOTATION = System::Int8(0xc);
static const System::Int8 XMLELEMTYPE_ELEMENT = System::Int8(0x0);
static const System::Int8 XMLELEMTYPE_TEXT = System::Int8(0x1);
static const System::Int8 XMLELEMTYPE_COMMENT = System::Int8(0x2);
static const System::Int8 XMLELEMTYPE_DOCUMENT = System::Int8(0x3);
static const System::Int8 XMLELEMTYPE_DTD = System::Int8(0x4);
static const System::Int8 XMLELEMTYPE_PI = System::Int8(0x5);
static const System::Int8 XMLELEMTYPE_OTHER = System::Int8(0x6);
}	/* namespace Msxml_tlb */
#if !defined(DELPHIHEADER_NO_IMPLICIT_NAMESPACE_USE) && !defined(NO_USING_NAMESPACE_MSXML_TLB)
using namespace Msxml_tlb;
#endif
#pragma pack(pop)
#pragma option pop

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// Msxml_tlbHPP
